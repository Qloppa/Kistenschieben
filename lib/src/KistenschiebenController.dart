import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'Gamekey.dart';
import 'KistenschiebenModel.dart';
import 'KistenschiebenView.dart';
import 'LevelGenerator.dart';

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
const gamekeyCheck = const Duration(seconds: 10);

const gameSecret = '0be594b5c089ceca';

const gamekeySettings = 'gamekey.json';
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
bool isGameRunning = false;

class KistenschiebenController {


  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  //var gamekey = new GameKey('127.0.0.1', 8080, 'dac62aa0-9408-4b7d-abca-7104dd701230','2819b92f78114417');
  var gamekey = new GameKey('undefined', 8080, 'undefined', 'undefined');

  /**
   * Periodic trigger controlling availability of gamekey service.
   */
  Timer gamekeyTrigger;

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  bool gkAvailable = false;

  String username;
  String password;

  LevelGenerator genLvl;
  KistenschiebenModel ksModel;
  KistenschiebenView ksView;

  /*
  CONSTRUCTOR
   */
  KistenschiebenController() {
    genLvl = new LevelGenerator();
    ksModel = new KistenschiebenModel();
    ksView = new KistenschiebenView();
    ksView.startScreen();
    startscreenListener();


    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    //print("startGameKey");
    try {
      // Download gamekey settings. Display warning on problems.
      HttpRequest.getString(gamekeySettings).then((json) {
        final settings = JSON.decode(json);

        // Create gamekey client using connection parameters
        this.gamekey = new GameKey(
            settings['host'],
            settings['port'],
            settings['gameid'],
            gameSecret
        );

        // Check periodically if gamekey service is reachable. Display warning if not.
        this.gamekeyTrigger = new Timer.periodic(gamekeyCheck, (_) async {
          if (await this.gamekey.authenticate() == true) {
            print("Authentifizierung Erfolgreich!");
            gkAvailable = true;
          } else {
            print("Authentifizierung Fehlgeschlagen!");
            gkAvailable = false;
          }
          ksView.setGameKeyAvailable(gkAvailable);
        });
      });
    } catch (error, stacktrace) {
      print("KistenschiebenKontroller() caused following error: '$error'");
      print("$stacktrace");
    }
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    //ksModel.playerPos_old = ksModel.playerPositionAsString();
    //ksModel.crates_old = ksModel.crateList();
    window.onKeyDown.listen((KeyboardEvent ev) {
      switch (ev.keyCode) {
        case KeyCode.UP:
          moveUp();
          break;
        case KeyCode.RIGHT:
          moveRight();
          break;
        case KeyCode.DOWN:
          moveDown();
          break;
        case KeyCode.LEFT:
          moveLeft();
          break;
      }
      return "";
    });
  }

  setgameRunning(bool value) {
    isGameRunning = value;
  }


  dynamic startscreenListener() async {

    /*
    register
    */
    querySelector('#register').onMouseDown.listen((MouseEvent e) {
      ksView.userdates();
      querySelector('#start').innerHtml = "";
      document
          .querySelector('#submit')
          .onMouseDown
          .listen((MouseEvent ev) {
        String username = ksView.username;
        String password = ksView.userPassword;
        print(username + " " + password);
        gamekey.registerUser(username, password);
        querySelector("#userinput").innerHtml = "";
        ksView.startScreen();
        startscreenListener();
      });
      querySelector("#close").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
        querySelector("#about").innerHtml = "";
        ksView.startScreen();
        startscreenListener();
      });

    });

    /*
			Login
		*/
    querySelector('#login').onMouseDown.listen((MouseEvent e) {
      ksView.userdates();
      document
          .querySelector('#submit')
          .onMouseDown
          .listen((MouseEvent ev) {
        String username = ksView.username;
        String password = ksView.userPassword;
        print(username + " " + password);
        querySelector("#userinput").innerHtml = "";
        checklogin(username, password);
      });
      querySelector("#close").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
        ksView.startScreen();
        startscreenListener();
      });
    });
    /*
    Play without login
    */
    querySelector('#wOLogin').onMouseDown.listen((MouseEvent e) {
      querySelector('#start').innerHtml = "";
      querySelector("#resetbutton").style.visibility = "visible";
      newGame();
    });

    querySelector('#about').onMouseDown.listen((MouseEvent g) {
      querySelector('#start').innerHtml = "";
      ksView.getAbout();
      querySelector("#close").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
        querySelector("#about").innerHtml = "";
        ksView.startScreen();
        startscreenListener();
      });
    });

    querySelector("#resetbutton").onMouseDown.listen((MouseEvent e) {
      querySelector('#start').innerHtml = "";
      querySelector("#registered").innerHtml = "";
      querySelector("#container").innerHtml = "";
      resetGame();
    });
  }

  checklogin(String name, String pw) async {
    final answer = await gamekey.loginUser(name, pw);
    if (answer == true) {
      querySelector("#start").innerHtml = "";
      querySelector("#userstatus").innerHtml = "Userstatus: Angemeldet";
      querySelector("#userstatus").style.color = "green";
      ksView.registeredScreen();
      registeredListener();
    }
  }

  /*
  listener to the buttons on the "registered" layout
  */
  registeredListener() async {

    querySelector("#newgame").onMouseDown.listen((MouseEvent f) {
      newGame();
      querySelector("#registered").innerHtml = "";
    });

    querySelector("#edituserbutton").onMouseDown.listen((MouseEvent g) {
      ksView.editUser();
      editUserListener();
    });
  }

  /*
  listener to the buttons on the "edit user" layout
  */
  dynamic editUserListener() async {
    querySelector("#getuser").onMouseDown.listen((MouseEvent f) async {
      ksView.getUser();
      document
          .querySelector('#submit')
          .onMouseDown
          .listen((MouseEvent ev) {
        String userid = ksView.userId;
        String password = ksView.userPassword;
        Future<String> us = gamekey.getUser(userid, password);
        String getu = us.toString();
        print("the user you get is: $getu");
      });
      querySelector("#close").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
      });
    });

    querySelector("#getuserid").onMouseDown.listen((MouseEvent f) async {
      ksView.getUserId();
      document
          .querySelector('#submit')
          .onMouseDown
          .listen((MouseEvent ev) {
        String username = ksView.username;
        Future<String> pw = gamekey.getUserId(username);
        String getp = pw.toString();
        print("the user you get is: $getp");
      });
      querySelector("#close").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
      });
    });

    querySelector("#changename").onMouseDown.listen((MouseEvent f) {
      ksView.changeUserName();
      document
          .querySelector('#submit')
          .onMouseDown
          .listen((MouseEvent ev) {
        String oldName = ksView.oldUsername;
        String password = ksView.userPassword;
        String username = ksView.username;
        print(username + " " + password);
        gamekey.changeUserName(oldName, password, username);
      });
      querySelector("#close").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
      });
    });

    querySelector("#changepassword").onMouseDown.listen((MouseEvent f) {
      ksView.changeUserPassword();
      document
          .querySelector('#submit')
          .onMouseDown
          .listen((MouseEvent ev) {
        String username = ksView.username;
        String oldpassword = ksView.oldUserpassword;
        String password = ksView.userPassword;
        print(username + " " + password);
        gamekey.changeUserPassword(username, oldpassword, password);
      });
      querySelector("#close").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
      });
    });

    querySelector("#delete").onMouseDown.listen((MouseEvent f) {
      ksView.userdates();
      document
          .querySelector('#submit')
          .onMouseDown
          .listen((MouseEvent ev) {
        String username = ksView.username;
        String password = ksView.userPassword;
        gamekey.deleteUser(username, password);
      });
      querySelector("#close").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
      });
    });
  }



  /**
   * Retrieves TOP 10 highscore from Gamekey service.
   * - Returns List of max. 10 highscore entries. { 'name': STRING, 'score': INT }
   * - Returns [] if gamekey service is not available.
   * - Returns [] if no highscores are present.
   */
  Future<List<Map>> getHighscores() async {
    var scores = [];
    try {
      final states = await gamekey.getStates();
      scores = states.map((entry) => {
        'name' : "${entry['username']}",
        'score' : entry['state']['points']
      }).toList();
      scores.sort((a, b) => b['score'] - a['score']);
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }
    return scores.take(10);
  }

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  /*
  tells the Player to move up. updates the view if the model returns true
   */
  bool moveUp() {
    List<String> positions = ksModel.moveUp();
    if (positions.isEmpty == false) {
      String playerPos_old = positions.removeLast();
      String playerPos_new = positions.removeLast();
      updateView(playerPos_old, playerPos_new, positions);
      return true;
    }
    return false;
  }

  /*
  tells the Player to move right. updates the view if the model returns true
   */
  bool moveRight() {
    List<String> positions = ksModel.moveRight();
    if (positions.isEmpty == false) {
      String playerPos_old = positions.removeLast();
      String playerPos_new = positions.removeLast();
      updateView(playerPos_old, playerPos_new, positions);
      return true;
    }
    return false;
  }

  /*
  tells the Player to move down. updates the view if the model returns true
   */
  bool moveDown() {
    List<String> positions = ksModel.moveDown();
    if (positions.isEmpty == false) {
      String playerPos_old = positions.removeLast();
      String playerPos_new = positions.removeLast();
      updateView(playerPos_old, playerPos_new, positions);
      return true;
    }
    return false;
  }

  /*
  tells the Player to move left. updates the view if the model returns true
   */
  bool moveLeft() {
    List<String> positions = ksModel.moveLeft();
    if (positions.isEmpty == false) {
      String playerPos_old = positions.removeLast();
      String playerPos_new = positions.removeLast();
      updateView(playerPos_old, playerPos_new, positions);
      return true;
    }
    return false;
  }

  /*
  enables movement by clicking on the Field. Takes the coordinates and hands them over to the moveTouch
   */
  void reactTouch() {
    querySelectorAll("td").onMouseDown.listen((MouseEvent ev) {
      String id = (ev.target as HtmlElement).id;
      if (id == "") {
        id = (ev.target as HtmlElement).parent.id;
      }
      id = id.replaceAll("pos", "");
      List<String> l = id.split("_");
      int x = int.parse(l[0]);
      int y = int.parse(l[1]);
      moveTouch(x, y);
    });
  }

  /*
  moves the player to a given position when the touchscreen is used.
   */
  void moveTouch(int targetX, int targetY) {
    int px = ksModel.getPlayerPosX();
    int py = ksModel.getPlayerPosY();
    int dir = checkDirection(targetX, targetY, px, py);
    switch (dir) {
      case 0 :
        break;
    //stay
      case 1 :
      //up
        touchUp(py - targetY);
        break;
      case 2 :
      //right
        touchRight(targetX - px);
        break;
      case 3 :
      //down
        touchDown(targetY - py);
        break;
      case 4 :
      //left
        touchLeft(px - targetX);
        break;
    }
  }


  /*
  moves the player up for a given number of fields.
   */
  void touchUp(int count) {
    while (count > 0) {
      if(!moveUp()) count = 1;
      count--;
    }
  }

  /*
  moves the player to the right for a given number of fields.
   */
  void touchRight(int count) {
    while (count > 0) {
      if(!moveRight()) count = 1;
      count--;
    }
  }

  /*
  moves the player down for a given number of fields.
   */
  void touchDown(int count) {
    while (count > 0) {
      if(!moveDown()) count = 1;
      count--;
    }
  }

  /*
  moves the player to the left for a given number of fields.
   */
  void touchLeft(int count) {
    while (count > 0) {
      if(!moveLeft()) count = 1;
      count--;
    }
  }

  /*
  returns an integer as id for the direction the player has to move
  0 - stay
  1 - up
  2 - right
  3 - down
  4 - left
   */
  int checkDirection(int targetX, int targetY, int playerX, int playerY) {
    if (targetX == playerX && targetY == playerY) {
      return 0;
    }
    if (targetX == playerX) {
      if (targetY < playerY) {
        return 1;
      } else {
        return 3;
      }
    }
    if (targetY == playerY) {
      if (targetX < playerX) {
        return 4;
      } else {
        return 2;
      }
    }
    return 0;
  }

  /*
  takes the positions of the player and the crates
   */
  void updateView(String playerPos_old,
      String playerPos_new, List<String> crates_new) {
    updateStats();
    ksView.updateView(playerPos_old, playerPos_new, crates_new);
    checkWin();
  }

  /**
   * Updates the stats in the view
   */
  void updateStats() {
    ksView.updateStats(ksModel.getStats(), genLvl.getLevelValue().toString());
  }

  /**
   * Checks if the User has already won
   */
  checkWin() {
    if (ksModel.checkWin() == true) {
      ksView.showWin();
      setgameRunning(false);
        querySelector("#next").onMouseDown.listen((MouseEvent e) {
          querySelector("#container").innerHtml = "";
          updateStats();
          nextLvl();
        });
      }
  }

  /*
  Starts the next Level
  */
  nextLvl() {
    if (genLvl.getLevelValue() <= genLvl.getLevelAmount()) {
      genLvl.nextLvl();
      genLvl.loadData().whenComplete(newGame);
    }
  }

  /*
  creates the model, starts a new game and creates the map from a String (later from a json)
   */
  void newGame() {
    setgameRunning(true);
    ksModel = new KistenschiebenModel();
    ksModel.loadLvl(genLvl.getLevelList(), genLvl.getColumn(), genLvl.getRow());
    ksView.loadLvl(
        genLvl.getEndFormat(), genLvl.getColumn(), genLvl.getRow()).whenComplete(reactTouch); //.whenComplete(reactTouch)
    querySelector("#resetbutton").style.visibility = "visible";
    updateStats();
  }

  /*
  Resets Game and local stats
  */
  void resetGame() {
    setgameRunning(true);
    ksModel.stats.incResets();
    Map<String, int> saveStats = ksModel.getStats();
    ksModel = new KistenschiebenModel();
    ksModel.loadLvl(genLvl.getLevelList(), genLvl.getColumn(), genLvl.getRow());
    ksView.loadLvl(
        genLvl.getEndFormat(), genLvl.getColumn(), genLvl.getRow()).whenComplete(reactTouch); //.whenComplete(reactTouch)
    ksModel.stats.setGlobalMoves(saveStats['globalMoves']);
    ksModel.stats.setGlobalPushes(saveStats['globalPushes']);
    ksModel.stats.setResets(saveStats['resets']);
    querySelector("#resetbutton").style.visibility = "visible";
    updateStats();
  }

  /*
	Resets Game and all stats (local and global)
	*/
  void resetTotal() {
    ksModel.resetTotal();
  }

  /**
   * loads the Stats from the json via the gamekey
   */
  void loadStats() {
    List dummy = gamekey.getStates();
    Map test = dummy.last;
    ksModel.loadStats(test);
  }

  //TODO : TESTEN
  /**
   * stores the stats in the .json-file via the gamekey
   */
  bool storeStats() {
    String uId = gamekey.getUserId(username);
    bool works = gamekey.storeState(uId, ksModel.getStats());
    if (works) {
      return true;
    } else {
      return false;
    }
  }


}
