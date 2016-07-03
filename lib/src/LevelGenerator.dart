import 'dart:async';
import 'dart:convert';
import 'dart:html';

/**
 * Is used to generate the level
 */
class LevelGenerator {
  //Anzahl der Gesamtlevel
  int lvlNumberSum = 0;

  //Aktuelles Level
  int currentLvl = 0;

  //levelnumber
  int lvlNumber = 0;

  int _column = 0;
  int _row = 0;
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
    if (level.values.elementAt(0) != null &&
        level.values.elementAt(1) != null &&
        level.values.elementAt(2) != null &&
        level.values.elementAt(3) != null && level.values.elementAt(4) != null) {
      this.currentLvl = level.values.elementAt(0);
      this._row = level.values.elementAt(1);
      this._column = level.values.elementAt(2);
      this._code = level.values.elementAt(3);
      levelList = level.values.elementAt(4);
    } else {
      print("The game was unable to load the level");
      //TODO fehlermeldung in View ausgeben (The game was unable to load the level)
    }
  }

  /**
   * returns the number of columns
   */
  int getColumn() {
    return this._column;
  }

  /**
   * returns the number of rows
   */
  int getRow() {
    return this._row;
  }

  /**
   * returns the levelList
   */
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
