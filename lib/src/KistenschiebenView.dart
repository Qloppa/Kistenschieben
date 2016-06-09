import 'dart:html';

class KistenschiebenView {

  //Bildelemente
  String crate = "<img src=\"../web/pictures/crate.png\">";
  String player = "<img src=\"../web/pictures/player.png\">";
  String wall = "<img src=\"../web/pictures/wall.png\">";
  String win = "<img src=\"../web/pictures/win.gif\" height=\" 200px\" width=\" 200px\">";

  /*
  Constructor
  */
  KistenschiebenView() {
    print("running view...");
  }

  startScreen() {
    querySelector('#start').innerHtml =
    "<div id=\"overlay\">"
        "<div id=\"b1\">"
        "  <button id=\"register\">Registrieren</button>"
        "</div>"
        "<div id=\"b2\">"
        "<button id=\"login\">Anmelden</button>"
        "</div>"
        "<div id=\"b3\">"
        "<button id=\"wOLogin\">Ohne Anmeldung spielen</button>"
        "</div>"
        "<div id=\"b4\">"
        "<button id=\"about\">Anleitung</button>"
        "</div>"
        "</div>";
  }

  userdates() {
    querySelector('#userinput').innerHtml =
    "<div id =\"overlay\" >"
        "<form id=\"inputdates\">"
        "<input type=\"text\" id=\"username\">"
        "<input type=\"password\" id=\"userpassword\">"
        "<button id=\"submit\">submit</button>"
        "</form>"
        "</div>";
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
    return formatlevel;
  }

  bool nextLevel() {
    querySelector("#next").style.visibility = "visible";
    return true;
  }

  loadLvl(String lvl, int row, int column) async {
    String level = generateLevelFromString(lvl, column, row);
    querySelector("level").innerHtml = level;
    scaling();

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
