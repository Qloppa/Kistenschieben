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

  QuattroLinkedList _qlList = null;
  Player _player = null;
  Target _target = null;
  Statistics _stats = null;
  bool _playerExists = false;
  int _countCrates = 0;
  int _countTargets = 0;

  /*
  constructor
   */
  KistenschiebenModel() {
    _stats = Statistics.getInstance();
  }

//region LOAD AND BUILD LEVEL

  /**
   * loads the level from a list
   */
  void loadLvl(List<Map> levelList, int row, int column) {
    bool firstLine = true;
    _target = null;
    _qlList = null;
    _qlList = new QuattroLinkedList();
    _playerExists = false;
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
      String firstChar = "";
      if (line.length > 0) {
        firstChar = line.substring(0, 1);
        line = line.substring(1);
      } else {
        firstChar = "G";
      }
      addDown(firstChar);
      addRight(line);
    }
    return firstLine;
  }

  /**
   * Adds a new fieldobject right to the last one
   */
  void addRight(String line) {
    Crate crate = null;
    int length = line.length;
    for (int i = 0; i < length; i++) {
      String firstChar = "";
      if (line.length > 0) {
        firstChar = line.substring(0, 1);
        line = line.substring(1);
      } else {
        firstChar = "G";
      }
      switch (firstChar) {
        case 'W' :
          _qlList.addRight(new Wall());
          break;
        case 'G' :
          _qlList.addRight(new Ground());
          break;
        case 'P' :
          if (_playerExists == false) {
            _player = new Player(_qlList.addRight(new Ground()));
            _playerExists = true;
          } else {
            _qlList.addRight(new Ground());
          }
          break;
        case 'C' :
          crate = new Crate(_qlList.addRight(new Ground()));
          crate.getStaysOn().setCrate(crate);
          _countCrates++;
          break;
        case 'T' :
          _target = _qlList.addRight(new Target(_target));
          _countTargets++;
          break;
        case 'S' :
          _target = new Target(_target);
          crate = new Crate(_qlList.addRight(_target));
          crate.getStaysOn().setCrate(crate);
          _countCrates++;
          _countTargets++;
          break;
        default:
          _qlList.addRight(new Ground());
          break;
      }
    }
  }

  /**
   * Adds a new fieldObject below another
   */
  void addDown(String firstChar) {
    Crate crate = null;
    switch (firstChar) {
      case 'W' :
        _qlList.addDown(new Wall());
        break;
      case 'G' :
        _qlList.addDown(new Ground());
        break;
      case 'P' :
        if (_playerExists == false) {
          _player = new Player(_qlList.addRight(new Ground()));
          _playerExists = true;
        } else {
          _qlList.addRight(new Ground());
        }
        break;
      case 'C' :
        crate = new Crate(_qlList.addDown(new Ground()));
        crate.getStaysOn().setCrate(crate);
        _countCrates++;
        break;
      case 'T' :
        _target = _qlList.addDown(new Target(_target));
        _countTargets++;
        break;
      case 'S' :
        _target = new Target(_target);
        crate = new Crate(_qlList.addDown(_target));
        crate.getStaysOn().setCrate(crate);
        _countCrates++;
        _countTargets++;
        break;
      default:
        _qlList.addRight(new Ground());
        break;
    }
  }

//endregion

//region MOVE

  /*
   * tells the player to go up. Returns true if possible, false if not
   */
  List<String> moveUp(int pullAmount, int pushAmount) {
    return _player.moveUp(pullAmount, pushAmount);
  }

  /*
   * tells the player to go right. Returns true if possible, false if not
   */
  List<String> moveRight(int pullAmount, int pushAmount) {
    return _player.moveRight(pullAmount, pushAmount);
  }

  /*
   *tells the player to go down. Returns true if possible, false if not
   */
  List<String> moveDown(int pullAmount, int pushAmount) {
    return _player.moveDown(pullAmount, pushAmount);
  }

  /*
   * tells the player to go left. Returns true if possible, false if not
   */
  List<String> moveLeft(int pullAmount, int pushAmount) {
    return _player.moveLeft(pullAmount, pushAmount);
  }

//endregion

//region GETTER & SETTER

  /**
   * returns the X value of the position of the player
   */
  int getPlayerPosX() {
    return this._player.getPosX();
  }

  /**
   * returns the Y value of the position of the player
   */
  int getPlayerPosY() {
    return this._player.getPosY();
  }

  /**
   * sets the actual level in the statistics to the new value
   */
  void setLvl(int lvlNr) {
    this._stats.setCurrentLvl(lvlNr);
  }

  /**
   * returns the amount of crates that can be pushed with one move by the player
   */
  int getSteroidAmount() {
    return _player.getSteroidAmount();
  }

  /**
   * returns the pull amount
   */
  int getStickyGloveAmount() {
    return _player.getStickyGloveAmount();
  }

//endregion

//region STATS

  /**
   * resets the local stats and the level by loading it again
   */
  void resetStats() {
    //loadLvl(actualLevel, row, column);
    _stats.resetLocal();
  }

  /**
   * resets all stats and the game
   */
  void resetStatsTotal() {
    int gloves = _stats.getGloves();
    _stats.resetAll();
    _stats.setGloves(gloves);
  }

  /**
   * sets the stats to the given values
   */
  void loadStats(Map<String, int> save) {
    _stats.loadStats(save);
  }

  /**
   * returns the statistics as a Map
   */
  Map<String, int> getStats() {
    return _stats.getStats();
  }

  /**
   * returns the number of left gloves
   */
  int getGloves() {
    return _stats.getGloves();
  }

  /**
   * Sets the number of gloves in the statistics to the value n
   */
  void setGloves(int gloves) {
    _stats.setGloves(gloves);
  }

  /**
   * returns the number of left steroids
   */
  int getSteroids() {
    return _stats.getSteroids();
  }

  /**
   * Sets the number of steroids in the statistics to the value n
   */
  void setSteroids(int steroids) {
    _stats.setSteroids(steroids);
  }

  /**
   * increments the number of resets
   */
  void incResets() {
    this._stats.incResets();
  }

//endregion

  /**
   * checks if the player has already won
   */
  bool checkWin() {
    bool ret = false;
    if (_countCrates < _countTargets) {
      ret = true;
    } else {
      ret = _target.getWon();
    }
    return ret;
  }
}
