import 'dart:html';

class KistenschiebenView{

String crate = "<img src=\"../web/pictures/crate.jpg\" height = \"80px\" weight=\"100px\" backgroundcolor=\"blue\">";
String player = "<img src=\"../web/pictures/player.png\" height = \"80px\" weight=\"100px\" backgroundcolor=\"blue\">";

KistenschiebenView(){
print("running view...");  
}

loadLevel(){
  
  String level = "<table>"
  "<tr>"
     "<td id=\"pos0_0 \" class=\"wall\"></td>"
     "<td id=\"pos1_0\" class=\"wall\"></td>"
    " <td id=\"pos2_0\" class=\"wall\"></td>"
     "<td id=\"pos3_0\" class=\"wall\"></td>"
     "<td id=\"pos4_0\" class=\"wall\"></td>"
     "<td id=\"pos5_0\" class=\"wall\"></td>"
  "</tr>" 
  "<tr>"
      "<tr>"
          "<td id=\"pos0_1 \" class=\"wall\"></td>"
          "<td id=\"pos1_1\" class=\"ground\"></td>"
         " <td id=\"pos2_1\" class=\"ground\"></td>"
          "<td id=\"pos3_1\" class=\"ground\">$crate</td>"
          "<td id=\"pos4_1\" class=\"target\"></td>"
          "<td id=\"pos5_1\" class=\"wall\"></td>"
       "</tr>" 
       "<tr>"
      "<tr>"
          "<td id=\"pos0_2 \" class=\"wall\"></td>"
          "<td id=\"pos1_2\" class=\"ground\"></td>"
         " <td id=\"pos2_2\" class=\"ground\"></td>"
          "<td id=\"pos3_2\" class=\"ground\"></td>"
          "<td id=\"pos4_2\" class=\"ground\"></td>"
          "<td id=\"pos5_2\" class=\"wall\"></td>"
       "</tr>" 
       "<tr>" 
      "<tr>"
      "<td id=\"pos0_3 \" class=\"wall\"></td>"
      "<td id=\"pos1_3\" class=\"ground\"></td>"
     " <td id=\"pos2_3\" class=\"ground\"></td>"
      "<td id=\"pos3_3\" class=\"ground\">$crate</td>"
      "<td id=\"pos4_3\" class=\"ground\">$player</td>"
      "<td id=\"pos5_3\" class=\"wall\"></td>"
   "</tr>" 
   "<tr>" 
      "<tr>"
      "<td id=\"pos0_4 \" class=\"wall\"></td>"
      "<td id=\"pos1_4\" class=\"ground\"></td>"
     " <td id=\"pos2_4\" class=\"ground\"></td>"
      "<td id=\"pos3_4\" class=\"ground\"></td>"
      "<td id=\"pos4_4\" class=\"target\"></td>"
      "<td id=\"pos5_4\" class=\"wall\"></td>"
   "</tr>" 
   "<tr>" 
      "<tr>"
      "<td id=\"pos0_5 \" class=\"wall\"></td>"
      "<td id=\"pos1_5\" class=\"wall\"></td>"
     " <td id=\"pos2_5\" class=\"wall\"></td>"
      "<td id=\"pos3_5\" class=\"wall\"></td>"
      "<td id=\"pos4_5\" class=\"wall\"></td>"
      "<td id=\"pos5_5\" class=\"wall\"></td>"
   "</tr>" 
 "</table>";
  
  
  querySelector("level").innerHtml = level;
  
  
 
}

void updateView(String playerPosition_old, List<String>cratePosition_old, String playerPosition_new, List<String>cratePosition_new){

  querySelector(playerPosition_old).innerHtml= "";
  querySelector(playerPosition_new).innerHtml= player;

  querySelectorAll("td").remove(crate);
  querySelector(cratePosition_new.removeLast()).innerHtml= crate;
  querySelector(cratePosition_new.removeLast()).innerHtml= crate;
  


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