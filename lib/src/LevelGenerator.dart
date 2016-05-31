import 'dart:html';
import 'dart:convert';

class LevelGenerator {

  int levels = 0; //Anzahl der Gesamtlevel
  int aktuelesLevel = 0; //Aktuelle Level
  int levelValue = 0; //levelnumber
  int column = 0;
  int row = 0;
  String endformat;

  //Reading Level from Json
  LevelGenerator() {
    loadData();
  }

  void loadData() {
    // call the web server asynchronously
    var request = HttpRequest.getString("../web/level.json").then(onDataLoaded);
  }


// print the raw json response text from the server
  void onDataLoaded(String responseText) {
    var jsonString = JSON.decode(responseText);
    var lvl = jsonString.values.toList().elementAt(0);

    List str = lvl; //Anzahl der Level
    Map str2 = lvl.elementAt(levelValue); // LevelIndex
    Levelformatter(str2);
    this.levels = str.length; //Anzahl der Level
  }


  void setSelectlevel(int lvlValue) {
    this.levelValue = lvlValue;
  }
  void nextLvl() {
    this.levelValue++;
  }


  Levelformatter(Map level) {
    this.aktuelesLevel = level.values.elementAt(0);
    this.row = level.values.elementAt(1);
    this.column = level.values.elementAt(2);
    List<Map> levelFormatList = level.values.elementAt(3);
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
}