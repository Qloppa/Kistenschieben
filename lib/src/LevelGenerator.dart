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
  int lvlNumber = 0;

  int column = 0;
  int row = 0;

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

    List str = lvl; //Anzahl der Level
    Map str2 = lvl.elementAt(lvlNumber); // LevelIndex
    levelformatter(str2);
    this.lvlNumberSum = str.length; //Anzahl der Level
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
        level.values.elementAt(3) != null) {
      this.currentLvl = level.values.elementAt(0);
      this.row = level.values.elementAt(1);
      this.column = level.values.elementAt(2);
      levelList = level.values.elementAt(3);
    } else {
      print("The game was unable to load the level");
      //TODO fehlermeldung in View ausgeben (The game was unable to load the level)
    }
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
}

