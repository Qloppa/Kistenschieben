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
  String endformat;
  List<Map> levelList;

  //Reading Level from Json
  LevelGenerator() {
    loadData();
  }

  Future loadData() async {
    // call the web server asynchronously
    final request = await HttpRequest.getString("../web/level.json").then(
        onDataLoaded);
  }


// print the raw json response text from the server
  void onDataLoaded(String responseText) {
    var jsonString = JSON.decode(responseText);
    var lvl = jsonString.values.toList().elementAt(0);

    List str = lvl; //Anzahl der Level
    Map str2 = lvl.elementAt(lvlNumber); // LevelIndex
    Levelformatter(str2);
    this.lvlNumberSum = str.length; //Anzahl der Level
  }

  void setSelectlevel(int lvlValue) {
    this.lvlNumber = lvlValue;
  }

  void nextLvl() {
    this.lvlNumber++;
  }

  getLevelValue() {
    return this.lvlNumber;
  }

  getLevelAmount() {
    return this.lvlNumberSum;
  }

  Levelformatter(Map level) {
    this.currentLvl = level.values.elementAt(0);
    this.row = level.values.elementAt(1);
    this.column = level.values.elementAt(2);
    List<Map> levelFormatList = level.values.elementAt(3);
    levelList = levelFormatList;
    String levelformat = levelFormatList.join(",").replaceAll("{", "")
        .replaceAll("}", "").replaceAll("r: ", "")
        .replaceAll(",", "");
    this.endformat = levelformat;
  }

  int getColumn() {
    return this.column;
  }

  int getRow() {
    return this.row;
  }

  String getEndFormat() {
    return this.endformat;
  }
  List<Map> getLevelList() {
    return this.levelList;
  }
}