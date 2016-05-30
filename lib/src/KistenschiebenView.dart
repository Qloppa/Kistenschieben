import 'dart:html';

class KistenschiebenView {

  String crate = "<img src=\"../web/pictures/crate.png\">";
  String player = "<img src=\"../web/pictures/player.png\">";
  String win = "<img src=\"../web/pictures/win.gif\" height=\" 200px\" width=\" 200px\">";


  KistenschiebenView() {
    print("running view...");
    scaling();


  }

  void scaling(){
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



  void showWin(){

  querySelector("level"). innerHtml = "";
  querySelector("#win").innerHtml = win;

  }

  void levelrequest() {

  }

  String generateLevelFromString(List<List> levelString) {
  scaling();
    int x = -1;
    int y = -1;
    String type = "";
    String initObj = "";

    String table = levelString.map((row) {
      y++;
      x = -1;
      String zeile = row.map((col) {
        x++;
        switch (col) {
          case "W":
            type = "wall";
            initObj = "";
            break;
          case "T":
            type = "target";
            initObj = "";
            break;
          case "G":
            type = "ground";
            initObj = "";
            break;
          case "C":
            type = "ground";
            initObj = this.crate;
            break;
          case "P":
            type = "ground";
            initObj = this.player;
            break;
        }
        return "<td id=\"pos$x\_$y\" class=\"$type\">$initObj</td>";
      }).join();
      return "<tr>$zeile</tr>\n";
    }).join();
    return "<table>\n $table</table>";
  }

  loadLevel(List<List> levelList) {

    String level = generateLevelFromString(levelList);
    querySelector("level").innerHtml = level;
    scaling();
    querySelector("#win").innerHtml="";


  }

  void updateView(String playerPosition_old, List<String>cratePosition_old,
      String playerPosition_new, List<String>cratePosition_new) {
    querySelector(playerPosition_old).innerHtml = "";
    querySelector(playerPosition_new).innerHtml = player;


    querySelectorAll("td").remove(crate);

    switch(cratePosition_new.length){
      case 1: querySelector(cratePosition_new.removeLast()).innerHtml = crate;break;

      case 2: querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;break;

      case 3: querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;break;

      case 4: querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;break;

      case 5: querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;break;

      case 6: querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;break;

      case 7: querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;break;

      case 8: querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;break;

      case 9: querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;break;

      case 10: querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;break;

    }

    scaling();



  }


}


