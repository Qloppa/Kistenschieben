import 'dart:async';
import 'dart:convert';
import 'dart:html';

/**
 * Is used to generate the level
 */
class LevelGenerator {
  //Anzahl der Gesamtlevel
  int lvlNumberSum = 0;

  //Aktuelle Level
  int currentLvl = 0;

  //levelnumber
  int lvlNumber = 3;

  int column = 0;
  int row = 0;
  String _code = "";
  List<Map> lvls = new List<Map>();

  List<Map> levelList = new List<Map>();

  //Reading Level from Json
  LevelGenerator() {
    loadData();
  }

  Future loadData() async {
    // call the web server asynchronously
    await HttpRequest.getString("../web/level.json").then(onDataLoaded);
  }

// print the raw json response text from the server
  void onDataLoaded(String responseText) {
    var jsonString = JSON.decode(responseText);
    var lvl = jsonString.values.toList().elementAt(0);

    lvls = lvl; //Anzahl der Level
    Map str2 = lvl.elementAt(lvlNumber); // LevelIndex
    levelformatter(str2);
    this.lvlNumberSum = lvls.length; //Anzahl der Level
  }

  void setSelectlevel(int lvlValue) {
    this.lvlNumber = lvlValue;
  }

  /**
   * increments the number of the level
   */
  void nextLvl() {
    this.lvlNumber++;
  }

  /**
   * returns the number of the actual level
   */
  getLevelValue() {
    return this.lvlNumber;
  }

  /**
   * returns the total number of levels
   */
  getLevelAmount() {
    return this.lvlNumberSum;
  }

  levelformatter(Map level) {
    this.currentLvl = level.values.elementAt(0);
    this.row = level.values.elementAt(1);
    this.column = level.values.elementAt(2);
    this._code = level.values.elementAt(3);
    List<Map> levelFormatList = level.values.elementAt(4);
    levelList = levelFormatList;
  }

  int getColumn() {
    return this.column;
  }

  int getRow() {
    return this.row;
  }

  List<Map> getLevelList() {
    return this.levelList;
  }

  /**
   * returns the secret code for the actual level
   */
  String getlvlcode() {
    return this._code;
  }

  /**
   * Returns the level that matches the secret code. returns -1 if code not valid
   */
  int getLevelByCode(String str) {
    int lvlnr = -1;
    for (int i = 0; i < lvls.length; i++) {
      if (str == lvls.elementAt(i)['code']) {
        return lvls.elementAt(i)['level'];
      }
    }
    return lvlnr;
  }
}

