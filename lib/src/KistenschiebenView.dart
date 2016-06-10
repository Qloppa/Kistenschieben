import 'dart:html';
import 'dart:async';
import 'dart:js';

class KistenschiebenView {

  String crate = "<img src=\"../web/pictures/crate.png\">";
  String player = "<img src=\"../web/pictures/player.png\">";
  String wall = "<img src=\"../web/pictures/wall.png\">";
  String win = "<img src=\"../web/pictures/win.gif\" height=\" 200px\" width=\" 200px\">";

  //scaling
  int tableH = 10;
  int tableW = 6;
  double percentH;
  double percentW;
  int objectSize;

  /*
  Constructor
  */
  KistenschiebenView() {
    print("running view...");
    scaling(); //TODO warum hier obwohl im scaling nur objekte aus dem Level definiert werden? M&F
  }

  void scaling() {
    Window w = window;
    int resoWidth = w.screen.width - 200;
    int resoHeight = w.screen.height - 200;
    print(resoWidth.toString());
    print(resoHeight.toString());
    String oS;

    int px;
    if(tableH > tableW){
      double size = resoWidth / tableW;
      px = size.toInt();
      print("Groesse: " + px.toString());
    }else{
      double size = resoHeight / tableH;
      px = size.toInt();
      print("Groesse: " + px.toString());
    }
      oS = px.toString() + "px";
    String strH = resoHeight.toString() + "px";
    String strW = resoWidth.toString() + "px";
    //querySelector("table").style.height = strH;
    //querySelector("table").style.width = strW;
    querySelectorAll("lvl").style.height = "80%";
    querySelectorAll("lvl").style.width = "80%";
    querySelectorAll(".target").style.height = oS;
    querySelectorAll(".target").style.width = oS;
    querySelectorAll(".ground").style.height = oS;
    querySelectorAll(".ground").style.width = oS;
    querySelectorAll(".wall").style.height = oS;
    querySelectorAll(".wall").style.width = oS;
    querySelectorAll("img").style.height = oS;
    querySelectorAll("img").style.width = oS;
  }

  /*
  Changes the status of the Gamekey to "Verbunden" in green if true or "nicht verbunden" in red if false
  */
  setGameKeyAvailable(bool value) {
    if (value == true) {
      querySelector("#gamekeystatus").style.color = "green";
      querySelector("#gamekeystatus").innerHtml = "Gamekeystatus: Verbunden";
    } else {
      querySelector("#gamekeystatus").style.color = "red";
      querySelector("#gamekeystatus").innerHtml =
      "Gamekeystatus: nicht Verbunden";
    }
  }

  void showWin() {
    querySelector("#container").innerHtml =
    "<div id=\"overlay\"><h2>LEVEL ABGESCHLOSSEN!!!</h2><button id=\"next\">Next Level</button></div>";
  }

  /*
  Creates the level in html from a String
  */
  String generateLevelFromString(String level, int row, int column) {
    this.tableH = row;
    this.tableW = column;

    level = level.toUpperCase();

    String type = "";
    String initObj = "";

    String formatlevel = "";
    for (int j = 0; j < row; j++) {
      //TODO sind culmn und row in der richtigen reihenfolge? M&F
      //Spalten
      formatlevel += "<tr>";
      for (int i = 0; i < column; i++) {
        //Zeilen
        String firstChar = level.substring(0, 1);
        level = level.substring(1);
        switch (firstChar) {
          case 'W' :
            formatlevel += "<td id=\"pos$i\_$j\" class=\"wall\" >$wall</td>";
            break;
          case 'G' :
            formatlevel += "<td id=\"pos$i\_$j\" class=\"ground\" ></td>";
            break;
          case 'P' :
            formatlevel +=
            "<td id=\"pos$i\_$j\" class=\"ground\">$player</td>";
            break;
          case 'C' :
            formatlevel +=
            "<td id=\"pos$i\_$j\" class=\"ground\">$crate</td>";
            break;
          case 'T' :
            formatlevel += "<td id=\"pos$i\_$j\" class=\"target\"></td>";
            break;
          case 'S' :
            formatlevel +=
            "<td id=\"pos$i\_$j\" class=\"target\">$crate</td>";
            break;
        }
      }
      formatlevel += "</tr>\n";
    }
    formatlevel = "<table>\n$formatlevel</table>";
    scaling();
    return formatlevel;
  }

  loadLvl(String lvl, int row, int column) async {
    String level = generateLevelFromString(lvl, column, row);
    querySelector("level").innerHtml = level;
    scaling(); //TODO nochmal?? M&F
  }

  bool nextLvl() {
    querySelector("#next").style.visibility = "visible";
    return true;
  }

  String touchListener() {
    querySelectorAll("td").onMouseDown.listen((MouseEvent ev) {
      String id = (ev.target as HtmlElement).id;
      if (id == "") {
        id = (ev.target as HtmlElement).parent.id;
      }
      return id;
    });
  }

  String get username =>
      (document.querySelector('#username') as InputElement).value;


  String get userpassword =>
      (document.querySelector('#userpassword') as InputElement).value;

  /*
  Updates the position of the player and the crates
  Receives old and new positions as Strings and updates the html
  */
  void updateView(String playerPosition_old,
      String playerPosition_new, List<String>cratePosition_new) {
    querySelector(playerPosition_old).innerHtml = "";
    querySelector(playerPosition_new).innerHtml = player;

    querySelectorAll("td").remove(crate);
    int dummy = 0;
    do {
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
    } while (dummy < cratePosition_new.length);
    scaling();
  }
}
