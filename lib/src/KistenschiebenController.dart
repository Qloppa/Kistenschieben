import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'GameKey.dart';
import 'KistenschiebenModel.dart';
import 'KistenschiebenView.dart';

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
const gamekeyCheck = const Duration(seconds: 30);

const gameSecret = '2819b92f78114417';

const gamekeySettings = 'gamekey.json';

const levels = 'game.json';

const statistics = 'stats.json';
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

class KistenschiebenController {

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  //var gamekey = new GameKey('127.0.0.1', 8080, 'dac62aa0-9408-4b7d-abca-7104dd701230','2819b92f78114417');
  var gamekey = new GameKey('undefined', 8080, 'undefined', 'undefined');

  /**
   * Periodic trigger controlling availability of gamekey service.
   */
  Timer gamekeyTrigger;

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  int column = 6;
  int row = 5;
  KistenschiebenModel ksModel;
  KistenschiebenView ksView;
  List<List> level = [
    ['W', 'W', 'W', 'W', 'W', 'W'],
    ['W', 'G', 'G', 'T', 'T', 'W'],
    ['W', 'C', 'C', 'C', 'G', 'W'],
    ['W', 'T', 'G', 'G', 'P', 'W'],
    ['W', 'W', 'W', 'W', 'W', 'W']
  ];

  /*
  CONSTRUCTOR
   */
  KistenschiebenController() {
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    print("startGameKey");
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
          } else {
            print("Authentifizierung Fehlgeschlagen!");
          }
        });
      });
    } catch (error, stacktrace) {
      print("KistenschiebenKontroller() caused following error: '$error'");
      print("$stacktrace");
    }
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//    ksModel.playerPos_old = ksModel.playerPositionAsString();
//    ksModel.crates_old = ksModel.crateList();
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

    //Falls Buttons genutzt werden, nicht entfernen!
    querySelectorAll("Left").onMouseDown.listen((MouseEvent me){
      moveLeft();
    });

    querySelectorAll("Right").onMouseDown.listen((MouseEvent me){
      moveRight();
    });

    querySelectorAll("Up").onMouseDown.listen((MouseEvent me){
      moveUp();
    });

    querySelectorAll("Down").onMouseDown.listen((MouseEvent me){
      moveDown();
    });

    querySelectorAll("Reset").onMouseDown.listen((MouseEvent me){
      resetGame();
    });

    querySelectorAll("Ground").onMouseDown.listen((MouseEvent me){ //Herausfinden wie für Ground, Target und Crate
      moveTouch(ksModel.player.getPosition(), "");//Position noch aendern

    });
  }


  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
  loads the level with the given number from the game.json. Available: 1, 2, 3
   */
  loadLevel(int number){
    HttpRequest.getString(levels).then((json) {
      final levelMap = JSON.decode(json);
      switch(number){
        case 1 : level = levelMap["levelEins"];
        break;
        case 2 : level = levelMap["levelZwei"];
        break;
        case 3 : level = levelMap["levelDrei"];
        break;
      }
    });
  }

  saveProgress(){

  }

  /*
  tells the Player to move up. updates the view if the model returns true
   */
  void moveUp() {
    List<String> crates_old = ksModel.crateList();
    //print(crates_old);
    String playerPos_old = ksModel.playerPositionAsString();
    //print(playerPos_old);
    //ksView.updateView(playerPos_old,crates_old,playerPos_old,crates_old);
    if (ksModel.moveUp() == true) {
      List<String> crates_new = ksModel.crateList();
      //print(crates_new);
      String playerPos_new = ksModel.playerPositionAsString();
      //print(playerPos_new);
      updateView(playerPos_old, crates_old, playerPos_new, crates_new);
    }
  }

  /*
  tells the Player to move right. updates the view if the model returns true
   */
  void moveRight() {
    List<String> crates_old = ksModel.crateList();
    //print(crates_old);
    String playerPos_old = ksModel.playerPositionAsString();
    //print(playerPos_old);
    //ksView.updateView(playerPos_old,crates_old,playerPos_old,crates_old);
    if (ksModel.moveRight() == true) {
      List<String> crates_new = ksModel.crateList();
      //print(crates_new);
      String playerPos_new = ksModel.playerPositionAsString();
      //print(playerPos_new);
      updateView(playerPos_old, crates_old, playerPos_new, crates_new);
    }
  }

  /*
  tells the Player to move down. updates the view if the model returns true
   */
  void moveDown() {
    List<String> crates_old = ksModel.crateList();
    //print(crates_old);
    String playerPos_old = ksModel.playerPositionAsString();
    //print(playerPos_old);
    //ksView.updateView(playerPos_old,crates_old,playerPos_old,crates_old);
    if (ksModel.moveDown() == true) {
      List<String> crates_new = ksModel.crateList();
      //print(crates_new);
      String playerPos_new = ksModel.playerPositionAsString();
      //print(playerPos_new);
      updateView(playerPos_old, crates_old, playerPos_new, crates_new);
    }
  }

  /*
  tells the Player to move left. updates the view if the model returns true
   */
  void moveLeft() {
    List<String> crates_old = ksModel.crateList();
    //print(crates_old);
    String playerPos_old = ksModel.playerPositionAsString();
    //print(playerPos_old);
    // ksView.updateView(playerPos_old,crates_old,playerPos_old,crates_old);
    if (ksModel.moveLeft() == true) {
      List<String> crates_new = ksModel.crateList();
      //print(crates_new);
      String playerPos_new = ksModel.playerPositionAsString();
      //print(playerPos_new);
      updateView(playerPos_old, crates_old, playerPos_new, crates_new);
    }
  }

  /*
  moves the player to a position when the touchscreen is used.
   */
  void moveTouch(String posOld, String posNew) {
    //in x und y splitten, Richtung berechnen und dann weiter solange true;
  }

  /*
  takes the positions of the player and the crates
   */
  void updateView(String playerPos_old, List<String>crates_old,
      String playerPos_new, List<String> crates_new) {

    ksView.updateView(playerPos_old, crates_old, playerPos_new, crates_new);
    checkWin();
  }

  void checkWin(){
    if(ksModel.player.won == true){
      ksView.showWin();
    }
  }

  /*
  creates the model, starts a new game and creates the map from a String (later from a xml)
   */
  void newGame() {
    ksModel = new KistenschiebenModel();
    ksView = new KistenschiebenView();

    ksModel.loadLvl(level, column, row);
    ksView.loadLevel(level);
  }

  void resetGame() {
    ksModel.reset();
  }
}