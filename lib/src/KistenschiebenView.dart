import 'dart:html';

class KistenschiebenView {

  String crate = "<img src=\"../web/pictures/crate.png\">";
  String player = "<img src=\"../web/pictures/player.png\">";
  String win = "<img src=\"../web/pictures/win.gif\" height=\" 200px\" width=\" 200px\">";

  KistenschiebenView() {
    print("running view...");

  }

  void scaling() {
    //TODO gehört sowas nicht in die CSS? M&F
    querySelectorAll("img").style.height = "40px";
    querySelectorAll("img").style.width = "50px";
    querySelectorAll("td").style.height = "40px";
    querySelectorAll("td").style.width = "50px";
    querySelectorAll(".target").style.height = "40px";
    querySelectorAll(".target").style.width = "50px";
    querySelectorAll(".ground").style.height = "40px";
    querySelectorAll(".ground").style.width = "50px";
    querySelectorAll(".wall").style.height = "40px";
    querySelectorAll(".wall").style.width = "50px";
  }

  setGameKeyAvailable(bool value){
    if(value==true){
      querySelector("#gamekeystatus").style.color="green";
      querySelector("#gamekeystatus").innerHtml= "Gamekeystatus: Verbunden";
    } else {
      querySelector("#gamekeystatus").style.color = "red";
      querySelector("#gamekeystatus").innerHtml =
      "Gamekeystatus: nicht Verbunden";
    }
  }

  void showWin() {
    querySelector("level").innerHtml = "";
    querySelector("#win").innerHtml = win; //TODO 1 M&F
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
            formatlevel += "<td id=\"pos$i\_$j\" class=\"wall\" ></td>";
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
          //case 'S' :
          //"<td id=\"pos$i\_$j\" class=\"target\">$crate</td>";
          //break;
        }
      }
      formatlevel += "</tr>\n";
    }
    formatlevel = "<table>\n$formatlevel</table>";
    return formatlevel;
  }

  loadLevel(String lvl, int row, int column) {
    String level = generateLevelFromString(lvl, column, row);
    querySelector("level").innerHtml = level;
    scaling(); //TODO nochmal?? M&F
    querySelector("#win").innerHtml = ""; //TODO 2 M&F
  }

  void updateView(String playerPosition_old, List<String>cratePosition_old,
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
    }
    scaling(); // TODO NOCHMAL?? M&F
  }
}