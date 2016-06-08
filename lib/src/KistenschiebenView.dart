import 'dart:async';
import 'dart:html';

class KistenschiebenView {

  //Bildelemente
  String crate = "<img src=\"../web/pictures/crate.png\">";
  String player = "<img src=\"../web/pictures/player.png\">";
  String wall = "<img src=\"../web/pictures/wall.png\">";
  String win = "<img src=\"../web/pictures/win.gif\" height=\" 200px\" width=\" 200px\">";


  KistenschiebenView() {
    print("running view...");
  }


  void scaling() {
    /*querySelectorAll("img").style.height = "10%";
    querySelectorAll("img").style.width = "10%";*/
    querySelectorAll("td").style.height = "100%";
    querySelectorAll("td").style.width = "100%";
    querySelectorAll(".target").style.height = "10%";
    querySelectorAll(".target").style.width = "10%";
    querySelectorAll(".ground").style.height = "10%";
    querySelectorAll(".ground").style.width = "10%";
    querySelectorAll(".wall").style.height = "10%";
    querySelectorAll(".wall").style.width = "10%";
  }

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

  String generateLevelFromString(String level, int row, int column) {
    scaling();
    level = level.toUpperCase();

    String type = "";
    String initObj = "";

    String formatlevel = "";
    for (int j = 0; j < row; j++) {
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
    print(formatlevel);
    return formatlevel;
  }

  bool nextLvl() {
    querySelector("#next").style.visibility = "visible";
    return true;
  }

  Future<bool> loadLvl(String lvl, int row, int column) async {
    String level = generateLevelFromString(lvl, column, row);
    querySelector("level").innerHtml = level;
    scaling();

  }

  String touchListener() {
    querySelectorAll("td").onMouseDown.listen((MouseEvent ev) {
      String id = (ev.target as HtmlElement).id;
      if (id == "") {
        id = (ev.target as HtmlElement).parent.id;
      } else {

      }
      return id;
    });
  }


  String get username =>
      (document.querySelector('#username') as InputElement).value;


  String get userpassword =>
      (document.querySelector('#userpassword') as InputElement).value;

  void updateView(String playerPosition_old,
      String playerPosition_new, List<String>cratePosition_new) {
    querySelector(playerPosition_old).innerHtml = "";
    querySelector(playerPosition_new).innerHtml = player;

    querySelectorAll("td").remove(crate);

    switch (cratePosition_new.length) {
    //TODO Das muss doch anders gehen!! (Parametrisieren) M&F
      case 1:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 2:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 3:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 4:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 5:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 6:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 7:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 8:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 9:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 10:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 11:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 12:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 13:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 14:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 15:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 16:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 17:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 18:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 19:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 20:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 21:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 22:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 23:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 24:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;

      case 25:
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        querySelector(cratePosition_new.removeLast()).innerHtml = crate;
        break;
    }
    scaling(); // TODO NOCHMAL?? M&F
  }
}