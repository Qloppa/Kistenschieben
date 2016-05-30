import 'dart:html';

class KistenschiebenView {

  String crate = "<img src=\"../web/pictures/crate.png\">";
  String player = "<img src=\"../web/pictures/player.png\">";

  KistenschiebenView() {
    print("running view...");


  }

 /* showWin(){
    //Anzeigen, dass gewonnen
  }
*/
  void levelrequest() {

  }

  String generateLevelFromString(List<List> levelString) {
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
    querySelectorAll("td").style.height="70px";
    querySelectorAll("td").style.width="70px";
    querySelectorAll(".target").style.height="70px";
    querySelectorAll(".target").style.width="70px";
    querySelectorAll(".wall").style.height="70px";
    querySelectorAll(".wall").style.width="70px";
    querySelectorAll("img").style.height="70px";
    querySelectorAll("img").style.width="70px";



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




  }


}


//void main(){
// KistenschiebenView view = new KistenschiebenView();
// String player = "#pos2_4";
// List<String> crates = ["#pos2_3","#pos3_4"];

//moveRight();
//view.keyHandler();
//querySelector("#pos2_4").appendHtml("player");

//}