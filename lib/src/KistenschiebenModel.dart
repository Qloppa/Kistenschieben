import 'Wall.dart';
import 'Ground.dart';
import 'Target.dart';
import 'QuattroLinkedList.dart';
import 'Player.dart';
import 'Crate.dart';
import 'Statistics.dart';

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
  }

  /*
		checks if the player has already won
	*/
  bool checkWin() {
    return target.checkOutNeighbours();
  }

  loadLvl(List<Map> levelList, int row, int column) {
    //TODO row und column eigentlich nicht mehr benötigt...in anderen Methoden anpassen
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

  /*
  tells the player to go up. Returns true if possible, false if not
   */
  bool moveUp() {
    if (player.moveUp() == true) {
      return true;
    } else {
      return false;
    }
  }

  /*
  tells the player to go right. Returns true if possible, false if not
   */
  bool moveRight() {
    if (player.moveRight() == true) {
      return true;
    } else {
      return false;
    }
  }

  /*
  tells the player to go down. Returns true if possible, false if not
   */
  bool moveDown() {
    if (player.moveDown() == true) {
      return true;
    } else {
      return false;
    }
  }

  /*
  tells the player to go left. Returns true if possible, false if not
   */
  bool moveLeft() {
    if (player.moveLeft() == true) {
      return true;
    } else {
      return false;
    }
  }

  /*
  returns a List of all crates
   */
  List<String> crateList() {
    return qlList.createCrateList(row, column);
  }

  /*
  returns the position of the player as String
   */
  String playerPositionAsString() {
    return player.getPositionAsString();
  }

  /*
	  returns the X value of the position of the player
	*/
  int getPlayerPosX() {
    return this.player.getPosX();
  }

  /*
		returns the Y value of the position of the player
	*/
  int getPlayerPosY() {
    return this.player.getPosY();
  }

  /*
  resets the local stats and the level by loading it again
  */
  reset() {
    loadLvl(actualLevel, row, column);
    stats.resetLocal();
  }

  /*
  resets all stats and the game
  */
  resetTotal() {
    loadLvl(actualLevel, row, column);
    stats.resetAll();
  }

  /*
  sets the stats to the given values
  */
  loadStats(int lm, int gm, int lp, int gp, int lt, int gt, int rt) {
    stats.loadStats(lm, gm, lp, gp, lt, gt, rt);
  }

  /*
			  returns the statistics as a list with the order
			  1. local moves
			  2. global moves
			  3. local pushes
			  4. global pushes
			  5. local time
			  6. global time
	*/
  List<int> getStatistics() {
    return stats.getStats();
  }

  printErrorMessage() {

  }

  changeView() {

  }

  exit() {

  }
}