import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'GameKey.dart';
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


  LevelGenerator genLvl = new LevelGenerator();
  KistenschiebenModel ksModel;
  KistenschiebenView ksView;

  /*
  CONSTRUCTOR
   */
  KistenschiebenController() {
    ksModel = new KistenschiebenModel();
    ksView = new KistenschiebenView();
    ksView.startScreen();
    startscreenListener();

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

  setgameRunning(bool e) {
    isGameRunning = e;
  }

  startscreenListener() async {
    querySelector('#register').onMouseDown.listen((MouseEvent e) {
      ksView.userdates();
      querySelector('#start').innerHtml = "";
      document
          .querySelector('#submit')
          .onMouseDown
          .listen((MouseEvent ev) {
        String username = ksView.username;
        String password = ksView.userpassword;
        print(username + " " + password);
        gamekey.registerUser(username, password);
        querySelector("#userinput").innerHtml = "";
        ksView.startScreen();
        startscreenListener();
      });
      querySelector("#close").onMouseDown.listen((MouseEvent e) {
        print("yeah");
        querySelector("#userinput").innerHtml = "";
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
        String password = ksView.userpassword;
        print(username + " " + password);
        querySelector("#userinput").innerHtml = "";
        checklogin(username, password);


      });
      querySelector("#close").onMouseDown.listen((MouseEvent e) {
        print("yeah");
        querySelector("#userinput").innerHtml = "";
        ksView.startScreen();
        startscreenListener();
      });
    });


    querySelector('#wOLogin').onMouseDown.listen((MouseEvent e) {
      querySelector('#start').innerHtml = "";
      querySelector("#resetbutton").style.visibility = "visible";
      newGame();
    });

    querySelector("#resetbutton").onMouseDown.listen((MouseEvent e) {
      querySelector('#start').innerHtml = "";
      querySelector("#logedin").innerHtml = "";
      querySelector("#container").innerHtml = "";
      newGame();
    });

  }


  Future<bool> checklogin(String name, String pw) async {
    final answer = await gamekey.loginUser(name, pw);

    if (answer == true) {
      querySelector("#start").innerHtml = "";
      querySelector("#userstatus").innerHtml = "Userstatus: Angemeldet";
      querySelector("#userstatus").style.color = "green";
      ksView.logedinScreen();
      logedinListener();
    }

  }

  dynamic logedinListener() async {
    querySelector("#newgame").onMouseDown.listen((MouseEvent f) {
      newGame();
      querySelector("#logedin").innerHtml = "";
    });

    querySelector("#edituserbutton").onMouseDown.listen((MouseEvent g) {
      ksView.editUser();
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
  void moveUp() {
    if (isGameRunning == true) {
      String playerPos_old = ksModel.playerPositionAsString();
      if (ksModel.moveUp() == true) {
        List<String> crates_new = ksModel.crateList();
        String playerPos_new = ksModel.playerPositionAsString();
        updateView(playerPos_old, playerPos_new, crates_new);
      }
    }
  }

  /*
  tells the Player to move right. updates the view if the model returns true
   */
  void moveRight() {
    if (isGameRunning == true) {
      String playerPos_old = ksModel.playerPositionAsString();
      if (ksModel.moveRight() == true) {
        List<String> crates_new = ksModel.crateList();
        String playerPos_new = ksModel.playerPositionAsString();
        updateView(playerPos_old, playerPos_new, crates_new);
      }
    }
  }

  /*
  tells the Player to move down. updates the view if the model returns true
   */
  void moveDown() {
    if (isGameRunning == true) {
      String playerPos_old = ksModel.playerPositionAsString();
      if (ksModel.moveDown() == true) {
        List<String> crates_new = ksModel.crateList();
        String playerPos_new = ksModel.playerPositionAsString();
        updateView(playerPos_old, playerPos_new, crates_new);
      }
    }
  }

  /*
  tells the Player to move left. updates the view if the model returns true
   */
  void moveLeft() {
    if (isGameRunning == true) {
      String playerPos_old = ksModel.playerPositionAsString();
      if (ksModel.moveLeft() == true) {
        List<String> crates_new = ksModel.crateList();
        String playerPos_new = ksModel.playerPositionAsString();
        updateView(playerPos_old, playerPos_new, crates_new);
      }
    }
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
      List<String> lol = id.split("_"); //TODO lol?
      int x = int.parse(lol[0]);
      int y = int.parse(lol[1]);
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
      moveUp();
      count--;
    }
  }

  /*
  moves the player to the right for a given number of fields.
   */
  void touchRight(int count) {
    while (count > 0) {
      moveRight();
      count--;
    }
  }

  /*
  moves the player down for a given number of fields.
   */
  void touchDown(int count) {
    while (count > 0) {
      moveDown();
      count--;
    }
  }

  /*
  moves the player to the left for a given number of fields.
   */
  void touchLeft(int count) {
    while (count > 0) {
      moveLeft();
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
    //TODO Die Liste der Kisten soll nur Positionen von geänderten Kisten enthalten
    ksView.updateView(playerPos_old, playerPos_new, crates_new);
    checkWin();
  }

  checkWin() {

    if (ksModel.checkWin() == true) {
      ksView.showWin();
      setgameRunning(false);
        querySelector("#next").onMouseDown.listen((MouseEvent e) {
          querySelector("#container").innerHtml = "";
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
  creates the model, starts a new game and creates the map from a String (later from a xml)
   */
  void newGame() {
    setgameRunning(true);
    ksModel = new KistenschiebenModel();
    ksModel.loadLvl(genLvl.getLevelList(), genLvl.getColumn(), genLvl.getRow());
    ksView.loadLvl(
        genLvl.getEndFormat(), genLvl.getColumn(), genLvl.getRow()).whenComplete(reactTouch); //.whenComplete(reactTouch)
    querySelector("#resetbutton").style.visibility = "visible";

  }

  /*
  Resets Game and local stats
  */
  void resetGame() {
    ksModel.reset();
  }

  /*
	Resets Game and all stats (local and global)
	*/
  void resetTotal() {
    ksModel.resetTotal();
  }
}
