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
    //stats = new Statistics();
    stats = Statistics.getInstance();
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
    target = null;
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
    Crate crate = null;
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
    Crate crate = null;
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
  List<String> moveUp(int pullAmount) {
    return player.moveUp(pullAmount);
  }

  /*
   * tells the player to go right. Returns true if possible, false if not
   */
  List<String> moveRight(int pullAmount) {
    return player.moveRight(pullAmount);
  }

  /**
    *tells the player to go down. Returns true if possible, false if not
    */
  List<String> moveDown(int pullAmount) {
    return player.moveDown(pullAmount);
  }

  /*
   * tells the player to go left. Returns true if possible, false if not
   */
  List<String> moveLeft(int pullAmount) {
    return player.moveLeft(pullAmount);
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

  /**
   * sets the amount of crates that can be pushed with one move by the player to the value i
   */
  void setPushPower(int i){
    player.setPushPower(i);
  }

  /**
   * returns the amount of crates that can be pushed with one move by the player
   */
  int getPushPower(){
    return player.getPushPower();
  }

  /**
   * returns the pull amount
   */
  int getPullAmount(){
    return player.getPullAmount();
  }

//endregion

//region STATS

  /**
   * resets the local stats and the level by loading it again
   */
  resetStats() {
    //loadLvl(actualLevel, row, column);
    stats.resetLocal();
  }

  /**
   * resets all stats and the game
   */
  resetStatsTotal() {
    int gloves = stats.getGloves();
    stats.resetAll();
    stats.setGloves(gloves);
  }

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

  /**
   * returns the number of left gloves
   */
  int getGloves() {
    return stats.getGloves();
  }

  /**
   * Sets the number of gloves in the statistics to the value n
   */
  int setGloves(int n){
    stats.setGloves(n);
  }

  /**
   * returns the number of used gloves
   */
  int getUsedGloves() {
    return stats.getUsedGloves();
  }

  /**
   * increments used gloves and decrements the left gloves
   */
  pull() {
    stats.decGloves();
    stats.incUsedGloves();
  }

  /**
   * increments the number of resets
   */
  incResets(){
    this.stats.incResets();
  }

//endregion

  /*
	*checks if the player has already won
	*/
  bool checkWin() {
    print("Target: " + target.getWon().toString());
    return target.getWon();
  }
}
