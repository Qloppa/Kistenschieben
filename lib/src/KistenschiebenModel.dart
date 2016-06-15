import 'Crate.dart';
import 'Ground.dart';
import 'Player.dart';
import 'QuattroLinkedList.dart';
import 'Statistics.dart';
import 'Target.dart';
import 'Wall.dart';

/**
 * The model of the Game. Manages the data, logic and rules of the application
 */
class KistenschiebenModel {

  QuattroLinkedList qlList = null;
  Player player = null;
  Crate crate = null;
  Target target = null;
  List<String> crates;
  String playerPos_old;
  Statistics stats;
  List<Map> actualLevel;
  int column;
  int row;

  /*
  constructor
   */
  KistenschiebenModel() {
    stats = new Statistics();
  }



//region LOAD AND BUILD LEVEL

  /**
   * loads the level from a list
   */
  loadLvl(List<Map> levelList, int row, int column) {
    bool firstLine = true;
    this.column = column;
    this.row = row;
    this.actualLevel = levelList;

    qlList = null;
    qlList = new QuattroLinkedList();

    for (var map in levelList) {
      firstLine = addNewLine(firstLine, map["r"].toUpperCase());
    }
  }

  /**
   * adds a new line of fieldobjects to the gamefield
   */
  bool addNewLine(bool firstLine, String line) {
    if (firstLine == true) {
      addRight(line);
      firstLine = false;
    } else {
      String firstChar = line.substring(0, 1);
      line = line.substring(1);
      addDown(firstChar);
      addRight(line);
    }
    return firstLine;
  }

  /**
   * Adds a new fieldobject right to the last one
   */
  addRight(String line) {
    int length = line.length;
    for (int i = 0; i < length; i++) {
      String firstChar = line.substring(0, 1);
      line = line.substring(1);
      switch (firstChar) {
        case 'W' :
          qlList.addRight(new Wall());
          break;
        case 'G' :
          qlList.addRight(new Ground());
          break;
        case 'P' :
          player = new Player(qlList.addRight(new Ground()));
          break;
        case 'C' :
          crate = new Crate(qlList.addRight(new Ground()));
          crate.staysOn.setCrate(crate);
          break;
        case 'T' :
          target = qlList.addRight(new Target(target));
          break;
        case 'S' :
          target = new Target(target);
          crate = new Crate(qlList.addRight(target));
          crate.staysOn.setCrate(crate);
          break;
      }
    }
  }

  /**
   * Adds a new fieldObject below another
   */
  addDown(String firstChar) {
    switch (firstChar) {
      case 'W' :
        qlList.addDown(new Wall());
        break;
      case 'G' :
        qlList.addDown(new Ground());
        break;
      case 'P' :
        player = new Player(qlList.addDown(new Ground()));
        break;
      case 'C' :
        crate = new Crate(qlList.addDown(new Ground()));
        crate.staysOn.setCrate(crate);
        break;
      case 'T' :
        target = qlList.addDown(new Target(target));
        break;
      case 'S' :
        target = new Target(target);
        crate = new Crate(qlList.addDown(target));
        crate.staysOn.setCrate(crate);
        break;
    }
  }

//endregion

//region MOVE

  /**
    * tells the player to go up. Returns true if possible, false if not
    */
  List<String> moveUp() {
    List<String> check = player.moveUp();
    if (check.length > 0) {
      stats.incMoves();
    }
    if (check.length > 2) {
      stats.incPushes();
    }
    return check;
  }

  /*
   * tells the player to go right. Returns true if possible, false if not
   */
  List<String> moveRight() {
    List<String> check = player.moveRight();
    if (check.length > 0) {
      stats.incMoves();
    }
    if (check.length > 2) {
      stats.incPushes();
    }
    return check;
  }

  /**
    *tells the player to go down. Returns true if possible, false if not
    */
  List<String> moveDown() {
    List<String> check = player.moveDown();
    if (check.length > 0) {
      stats.incMoves();
    }
    if (check.length > 2) {
      stats.incPushes();
    }
    return check;
  }

  /*
   * tells the player to go left. Returns true if possible, false if not
   */
  List<String> moveLeft() {
    List<String> check = player.moveLeft();
    if (check.length > 0) {
      stats.incMoves();
    }
    if (check.length > 2) {
      stats.incPushes();
    }
    return check;
  }

//endregion

//region PULL

  /*
   * tells the player to pull a crate up. Returns true if possible, false if not
   */
  List<String> pullUp() {
    List<String> check = player.moveUp(); //Hier aendern
    if (check.length > 0) {
      stats.incMoves();
    }
    if (check.length > 2) {
      stats.incPushes();
    }
    return check;
  }

  /*
   * tells the player to pull a crate up. Returns true if possible, false if not
   */
  List<String> pullRight() {
    List<String> check = player.moveRight(); //Hier aendern
    if (check.length > 0) {
      stats.incMoves();
    }
    if (check.length > 2) {
      stats.incPushes();
    }
    return check;
  }

  /*
   * tells the player to pull a crate up. Returns true if possible, false if not
   */
  List<String> pullDown() {
    List<String> check = player.moveDown(); //Hier aendern
    if (check.length > 0) {
      stats.incMoves();
    }
    if (check.length > 2) {
      stats.incPushes();
    }
    return check;
  }

  /*
   * tells the player to pull a crate up. Returns true if possible, false if not
   */
  List<String> pullLeft() {
    List<String> check = player.moveLeft(); //Hier aendern
    if (check.length > 0) {
      stats.incMoves();
    }
    if (check.length > 2) {
      stats.incPushes();
    }
    return check;
  }

//endregion

//region GETTER & SETTER

  /**
	  * returns the X value of the position of the player
	  */
  int getPlayerPosX() {
    return this.player.getPosX();
  }

  /**
		* returns the Y value of the position of the player
	  */
  int getPlayerPosY() {
    return this.player.getPosY();
  }

  /**
   * sets the actual level in the statistics to the new value
   */
  void setLevel(int i){
    this.stats.setActualLevel(i);
  }

//endregion

//region RESET

  /**
    * resets the local stats and the level by loading it again
    */
  reset() {
    loadLvl(actualLevel, row, column);
    stats.resetLocal();
  }

  /**
    * resets all stats and the game
    */
  resetTotal() {
    loadLvl(actualLevel, row, column);
    stats.resetAll();
  }

//endregion

//region STATS

  /**
    * sets the stats to the given values
    */
  loadStats(Map<String, int> save) {
    stats.loadStats(save);
  }

  /**
    * returns the statistics as a Map
    */
  Map<String, int> getStats() {
    return stats.getStats();
  }

//endregion

  /*
	*checks if the player has already won
	*/
  bool checkWin() {
    return target.getWon();
  }

}