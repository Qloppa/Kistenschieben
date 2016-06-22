import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'Gamekey.dart';
import 'KistenschiebenModel.dart';
import 'KistenschiebenView.dart';
import 'LevelGenerator.dart';

const gamekeyCheck = const Duration(seconds: 10);
const gameSecret = "ad97258677ce8c26";
const gamekeySettings = 'gamekey.json';

/**
 * The Controller of the Game. Accepts input and converts it to commands for the model or view.
 */
class KistenschiebenController {
  //var gamekey = new GameKey('127.0.0.1', 8080, 'dac62aa0-9408-4b7d-abca-7104dd701230','2819b92f78114417');
  var gamekey = new GameKey('undefined', 8080, 'undefined', 'undefined');

  LevelGenerator genLvl;

  //The Levelgenerator
  KistenschiebenModel ksModel;

  //The Model
  KistenschiebenView ksView;

  //The View

  Timer gamekeyTrigger;

  //Periodic trigger controlling availability of gamekey service.
  bool gkAvailable = false;

  //Shows if the gamekey is available or not
  String username;

  //The username of the actual user
  String password;

  //The password of the actual user
  Map stats;

  //The actual statistics
  String userid = "";

  //The User-ID
  String user = "";

  //The User
  bool logedIn = false;

  //Shows if the user is logged in or not
  int pullAmount = 1;

  //Shows if the user activated the pull-ability for the next round
  bool isGameRunning = false;
  bool finishedGame = false;
  bool registered = false;
  bool authentication = false;

  /*
  CONSTRUCTOR
   */
  KistenschiebenController() {
    genLvl = new LevelGenerator();
    ksModel = new KistenschiebenModel();
    ksView = new KistenschiebenView();
    ksView.startScreen();

    //  [-======== GAMEKEY ========-]

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

        querySelector("#registerbutton").style.visibility = "hidden";
        querySelector("#loginbutton").style.visibility = "hidden";
        startscreenListener();
        // Check periodically if gamekey service is reachable. Display warning if not.
        this.gamekeyTrigger = new Timer.periodic(gamekeyCheck, (_) async {
          if (await this.gamekey.authenticate() == true) {
            print("Authentification succeded!");
            if (authentication == false && isGameRunning == false) {
              querySelector("#registerbutton").style.visibility = "visible";
              querySelector("#loginbutton").style.visibility = "visible";
              authentication = true;
              gkAvailable = true;
            }
            gkAvailable = true;
          } else {
            print("Authentification failed!");
            gkAvailable = false;
          }
          ksView.setGameKeyAvailable(gkAvailable);
        });
      });
    } catch (error, stacktrace) {
      print("KistenschiebenKontroller() caused following error: '$error'");
      print("$stacktrace");
    }

    //  [-======== KEYLISTENER ========-]

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
        case KeyCode.BACKSPACE:
          if (isGameRunning || finishedGame) {
            finishedGame = false;
            resetGame();
          }
          break;
        case KeyCode.ENTER:
          if (finishedGame) {
            finishedGame = false;
            querySelector("#container").innerHtml = "";
            querySelector("#resetbutton").style.position = "";
            updateStats();
            nextLvl();
          }
          break;
        case KeyCode.S:
          if (finishedGame && logedIn) {
            print("saved");
            gamekey
                .storeState(userid, ksModel.getStats())
                .whenComplete(getHighscores);
          }
          break;
      }
      return "";
    });
  }

//region LISTENER AND QUERYSELECTORS


  /**
   * Listener for the Startscreen.
   * Has the following buttons:
   *    [REGISTER]
   *    [LOGIN]
   *    [WITHOUT LOGIN]
   *    [RESET]
   */
  dynamic startscreenListener() async {
    //REGISTER
    querySelector('#registerbutton').onMouseDown.listen((MouseEvent e) {
      ksView.userdates();
      document
          .querySelector('#submit')
          .onMouseDown
          .listen((MouseEvent ev) {
        String username = ksView.username;
        String password = ksView.userPassword;
        print("You are registered now");
        checkRegister(username, password);
        querySelector("#userinput").innerHtml = "";
      });
      querySelector("#back").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
        querySelector("#about").innerHtml = "";
        ksView.startScreen();
        startscreenListener();
      });
      hoverlistener();
    });

    //LOGIN
    querySelector('#loginbutton').onMouseDown.listen((MouseEvent e) {
      ksView.userdates();
      document
          .querySelector('#submit')
          .onMouseDown
          .listen((MouseEvent ev) {
        String username = ksView.username;
        String password = ksView.userPassword;
        this.user = username;
        querySelector("#userinput").innerHtml = "";
        checklogin(username, password);
        print("You are logged in now");
      });
      querySelector("#back").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
        ksView.startScreen();
        startscreenListener();
      });
      hoverlistener();
    });

    //WITHOUT LOGIN
    querySelector('#wOLogin').onMouseDown.listen((MouseEvent e) {
      querySelector('#start').innerHtml = "";
      querySelector("#resetbutton").style.visibility = "visible";
      querySelector("#skipbutton").style.visibility = "visible";
      newGame();
    });

    //ABOUT
    querySelector('#about').onMouseDown.listen((MouseEvent g) {
      querySelector('#start').innerHtml = "";
      ksView.getAbout();
      querySelector("#back").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
        querySelector("#about").innerHtml = "";
        ksView.startScreen();
        startscreenListener();
      });
      hoverlistener();
    });

    //RESET
    querySelector("#resetbutton").onMouseDown.listen((MouseEvent e) {
      //querySelector('#start').innerHtml = "";
      querySelector("#registered").innerHtml = "";
      querySelector("#container").innerHtml = "";
      querySelector("#resetbutton").style.position = "";
      resetGame();
    });

    //SKIP
    querySelector("#skipbutton").onMouseDown.listen((MouseEvent e) {
      nextLvl();
    });

    hoverlistener();
  }

  checkRegister(String name, String pw) async {
    Map answer = await gamekey.registerUser(name, pw);
    print("Answer:");
    print(answer);
    if (answer.isNotEmpty && answer != null) {
      querySelector("messagefield").className = "messageanimation";
      querySelector("messagefield").innerHtml = "Register succed";
      ksView.startScreen();
      startscreenListener();
    } else {
      querySelector("messagefield").className = "messageanimation";
      querySelector("messagefield").innerHtml = "Register failed";
    }
  }

  /**
   * Checks if user & password are valid and changes the userstatus
   */
  checklogin(String name, String pw) async {
    Map answer = await gamekey.loginUser(name, pw);
    print("Answer:");
    print(answer);
    if (answer.isNotEmpty) {
      registered = true;
      userid = answer.values.elementAt(2);
      username = answer.values.elementAt(3);
      querySelector("#start").innerHtml = "";
      querySelector("messagefield").className = "greetinganimation";
      querySelector("messagefield").innerHtml = "Hello $user";
      querySelector("#userstatus").innerHtml = "Registered as: $user";
      querySelector("#userstatus").style.color = "darkgreen";
      ksView.registeredScreen();
      registeredListener();
    } else {
      querySelector("messagefield").className = "greetinganimation";
      querySelector("messagefield").innerHtml = "Login failed!";
    }
  }

  /*
  listener to the buttons on the "registered" layout
  */
  registeredListener() async {
    //NEW GAME
    querySelector("#newgame").onMouseDown.listen((MouseEvent f) {
      newGame();
      querySelector("#registered").innerHtml = "";
      querySelector("#start").innerHtml = "";
      querySelector("#resetbutton").style.visibility = "visible";
      querySelector("#skipbutton").style.visibility = "visible";
    });

    //EDIT USER
    querySelector("#edituserbutton").onMouseDown.listen((MouseEvent g) {
      ksView.editUser();
      editUserListener();
    });

    //ABOUT
    querySelector('#ab').onMouseDown.listen((MouseEvent g) {
      ksView.getAbout();
      querySelector("#back").onMouseDown.listen((MouseEvent e) {
        querySelector("#about").innerHtml = "";
        ksView.registeredScreen();
        registeredListener();
      });
      hoverlistener();
    });

    hoverlistener();
  }

  /**
   * Listener for editing the user.
   * Has the following buttons:
   *    [GET USER]
   *    [GET USER ID]
   *    [CHANGE NAME]
   *    [CHANGE PASSWORD]
   *    [DELETE]
   *    [CLOSE]
   */
  dynamic editUserListener() async {
    //CHANGE NAME
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
      querySelector("#back").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
      });
      hoverlistener();
    });

    //CHANGE PASSWORD
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
      querySelector("#back").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
      });
      hoverlistener();
    });

    //DELETE
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
      querySelector("#back").onMouseDown.listen((MouseEvent e) {
        querySelector("#userinput").innerHtml = "";
      });
      hoverlistener();
    });

    //CLOSE
    querySelector("#back").onMouseDown.listen((MouseEvent e) {
      querySelector("#edituser").innerHtml = "";
    });

    hoverlistener();
  }

  /**
   * Listener for the hoverevent of the buttons
   */
  hoverlistener() async {
    querySelectorAll("button").onMouseEnter.listen((MouseEvent e) {
      (e.target as HtmlElement).className = "buttonhover";
    });

    querySelectorAll("button").onMouseLeave.listen((MouseEvent e) {
      (e.target as HtmlElement).className = "";
    });
  }


  /**
   * Listener for the Buttons which appear when the user has finished the level
   * [SAVE]
   * [NEXT]
   */
  nextListener() async {
    querySelector("#groundlayer").innerHtml = "";
    querySelector("#objectlayer").innerHtml = "";
    if (registered == true) {
      querySelector("#save").style.visibility = "visible";
    }

    //NEXT
    querySelector("#next").onMouseDown.listen((MouseEvent e) {
      querySelector("#container").innerHtml = "";
      querySelector("#resetbutton").style.position = "";
      updateStats();
      nextLvl();
    });

    //SAVE
    querySelector("#save").onMouseDown.listen((MouseEvent e) {
      print("saved");
      gamekey.storeState(userid, ksModel.getStats());
      updateStats();
    });
    hoverlistener();
  }

//endregion

//region MOVES

  /*
  tells the Player to move up. updates the view if the model returns true
   */
  bool moveUp() {
    List<String> positions = ksModel.moveUp(pullAmount);
    pullAmount = 0;
    if (positions.isEmpty == false) {
      String playerPos_old = positions.removeLast();
      String playerPos_new = positions.removeLast();
      updateViewPush(playerPos_old, playerPos_new, positions);
      return true;
    }
    return false;
  }

  /*
  tells the Player to move right. updates the view if the model returns true
   */
  bool moveRight() {
    List<String> positions = ksModel.moveRight(pullAmount);
    pullAmount = 0;
    if (positions.isEmpty == false) {
      String playerPos_old = positions.removeLast();
      String playerPos_new = positions.removeLast();
      updateViewPush(playerPos_old, playerPos_new, positions);
      return true;
    }
    return false;
  }

  /*
  tells the Player to move down. updates the view if the model returns true
   */
  bool moveDown() {
    List<String> positions = ksModel.moveDown(pullAmount);
    pullAmount = 0;
    if (positions.isEmpty == false) {
      String playerPos_old = positions.removeLast();
      String playerPos_new = positions.removeLast();
      updateViewPush(playerPos_old, playerPos_new, positions);
      return true;
    }
    return false;
  }

  /*
  tells the Player to move left. updates the view if the model returns true
   */
  bool moveLeft() {
    List<String> positions = ksModel.moveLeft(pullAmount);
    pullAmount = 0;
    if (positions.isEmpty == false) {
      String playerPos_old = positions.removeLast();
      String playerPos_new = positions.removeLast();
      updateViewPush(playerPos_old, playerPos_new, positions);
      return true;
    }
    return false;
  }

//endregion

//region TOUCH

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
      case 0:
        break;
    //stay
      case 1:
      //up
        touchUp(py - targetY);
        break;
      case 2:
      //right
        touchRight(targetX - px);
        break;
      case 3:
      //down
        touchDown(targetY - py);
        break;
      case 4:
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
      if (!moveUp()) count = 1;
      count--;
    }
  }

  /*
  moves the player to the right for a given number of fields.
   */
  void touchRight(int count) {
    while (count > 0) {
      if (!moveRight()) count = 1;
      count--;
    }
  }

  /*
  moves the player down for a given number of fields.
   */
  void touchDown(int count) {
    while (count > 0) {
      if (!moveDown()) count = 1;
      count--;
    }
  }

  /*
  moves the player to the left for a given number of fields.
   */
  void touchLeft(int count) {
    while (count > 0) {
      if (!moveLeft()) count = 1;
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

//endregion

//region UPDATE

  /*
  takes the positions of the player and the crates
   */
  void updateViewPush(String playerPos_old, String playerPos_new,
      List<String> crates_new) {
    updateStats();
    ksView.updateViewPush(playerPos_old, playerPos_new, crates_new);
    checkWin();
  }

  /*//TODO vielleicht bearbeiten
  takes the positions of the player and the crates
   */
  void updateViewPull(String playerPos_old, String playerPos_new,
      List<String> crates_new) {
    updateStats();
    ksView.updateViewPush(playerPos_old, playerPos_new, crates_new);
    checkWin();
  }

  /**
   * Updates the stats in the view
   */
  void updateStats() {
    var actualLvl = genLvl.getLevelValue() + 1;
    ksView.updateStats(ksModel.getStats(), actualLvl.toString());
  }

//endregion

//region STATISTICS

  /**
   * loads the Stats from the json via the gamekey
   */
  void loadStats() {
    List dummy = gamekey.getStates();
    Map test = dummy.last;
    ksModel.loadStats(test);
  }

  /**
   * Sets the actual level in the statistics to the value i
   */
  void setActualLevel(int i) {
    this.ksModel.setLevel(i);
  }

  /**
   * Retrieves TOP 10 highscore from Gamekey service.
   * - Returns List of max. 10 highscore entries. { 'name': STRING, 'score': INT }
   * - Returns [] if gamekey service is not available.
   * - Returns [] if no highscores are present.
   */
  Future<List<Map>> getHighscores() async {
    var scores = [];
    int amount = 10;
    try {
      final states = await gamekey.getStates();
      scores = states
          .map((entry) => {
        'name': "${entry['username']}",
        'level': entry['state']['actualLevel'],
        'LocalPushes': entry['state']['localPushes'],
        'GlobalPushes': entry['state']['globalPushes'],
        'LocalMoves': entry['state']['localMoves'],
        'GlobalMoves': entry['state']['globalMoves']
      })
          .toList();
      for (int i = 0; i < scores.length; i++)
        scores.sort((a, b) =>
        a['level']['LocalPushes'] -
            b['level']['LocalPushes']); //die niedrigsten localPushes

    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }
    List<Map<String, int>> lvlOnly = new List();
    for (Map m in scores) {
      if (m['level'] == genLvl.currentLvl) {
        lvlOnly.add(m);
      }
    }
    return lvlOnly.take(amount);
  }

//endregion

//region RESET AND NEW GAME

  /*
  Starts the next Level
  */
  nextLvl() {
    if (genLvl.getLevelValue() <= genLvl.getLevelAmount()) {
      genLvl.nextLvl();
      ksModel.stats.resetAll(); //TODO Bugfix resetAll
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
    ksView
        .generateLevelFromString(
        genLvl.getEndFormat(), genLvl.getColumn(), genLvl.getRow())
        .whenComplete(reactTouch);
    setActualLevel(genLvl.currentLvl + 1);
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
    ksView
        .generateLevelFromString(
        genLvl.getEndFormat(), genLvl.getColumn(), genLvl.getRow())
        .whenComplete(reactTouch); //.whenComplete(reactTouch)
    ksModel.stats.setGlobalMoves(saveStats['globalMoves']);
    ksModel.stats.setGlobalPushes(saveStats['globalPushes']);
    ksModel.stats.setResets(saveStats['resets']);
    ksModel.stats.resetLocal(); //TODO Bugfix resetLocal
    setActualLevel(genLvl.currentLvl + 1);
    querySelector("#resetbutton").style.visibility = "visible";
    updateStats();
  }

  /**
   * Checks if the User has already won
   */
  checkWin() async {
    if (ksModel.checkWin() == true) {
      finishedGame = true;
      final highscores = await getHighscores();
      ksView.showWin(highscores);
      setgameRunning(false);
      nextListener();
    }
  }

  /**
   * sets the status of the game to running or not
   */
  setgameRunning(bool value) {
    isGameRunning = value;
  }

//endregion

  /**
   * gets the username from the gamekey  //TODO entfernen
   */
  getUserId(String user) async {
    final username = await gamekey.getUserId(user);
  }
}