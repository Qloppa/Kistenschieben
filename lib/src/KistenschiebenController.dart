import 'dart:html';
import 'KistenschiebenModel.dart';
import 'KistenschiebenView.dart';
//import 'dart:async';
import 'dart:convert';


class KistenschiebenController {

  KistenschiebenModel ksModel;
  KistenschiebenView ksView;
  List<List> level =[
    ["W", "W", "W", "W", "W", "W"],
    ['W', 'G', 'G', 'C', 'T', 'W'],
    ['W', 'G', 'G', 'G', 'G', 'W'],
    ['W', 'G', 'G', 'C', 'P', 'W'],
    ['W', 'G', 'G', 'G', 'T', 'W'],
    ['W', 'W', 'W', 'W', 'W', 'W']


  ];
  /*
  CONSTRUCTOR
   */
  KistenschiebenController() {

//    ksModel.playerPos_old = ksModel.playerPositionAsString();
//    ksModel.crates_old = ksModel.crateList();
    window.onKeyDown.listen((KeyboardEvent ev) {
      switch (ev.keyCode) {
        case KeyCode.UP:
          moveUp();
          break;
        case KeyCode.RIGHT:
          moveRight();
          break;
        case KeyCode.DOWN:
          moveDown();
          break;
        case KeyCode.LEFT:
          moveLeft();
          break;
      }
      return "";
    });
  }

  /*
  tells the Player to move up. updates the view if the model returns true
   */
  void moveUp() {
    List<String> crates_old = ksModel.crateList();
    print(crates_old);
    String playerPos_old = ksModel.playerPositionAsString();
    print(playerPos_old);
    //ksView.updateView(playerPos_old,crates_old,playerPos_old,crates_old);
    if (ksModel.moveUp() == true) {
      List<String> crates_new = ksModel.crateList();
      print(crates_new);
      String playerPos_new = ksModel.playerPositionAsString();
      print(playerPos_new);
      updateView(playerPos_old,crates_old,playerPos_new,crates_new);
      
    }
  }

  /*
  tells the Player to move right. updates the view if the model returns true
   */
  void moveRight() {
    List<String> crates_old = ksModel.crateList();
        print(crates_old);
        String playerPos_old = ksModel.playerPositionAsString();
        print(playerPos_old);
        //ksView.updateView(playerPos_old,crates_old,playerPos_old,crates_old);
        if (ksModel.moveRight() == true) {
          List<String> crates_new = ksModel.crateList();
          print(crates_new);
          String playerPos_new = ksModel.playerPositionAsString();
          print(playerPos_new);
          updateView(playerPos_old,crates_old,playerPos_new,crates_new);
          
    }
  }

  /*
  tells the Player to move down. updates the view if the model returns true
   */
  void moveDown() {
    List<String> crates_old = ksModel.crateList();
        print(crates_old);
        String playerPos_old = ksModel.playerPositionAsString();
        print(playerPos_old);
        //ksView.updateView(playerPos_old,crates_old,playerPos_old,crates_old);
        if (ksModel.moveDown() == true) {
          List<String> crates_new = ksModel.crateList();
          print(crates_new);
          String playerPos_new = ksModel.playerPositionAsString();
          print(playerPos_new);
          updateView(playerPos_old,crates_old,playerPos_new,crates_new);
          
    }
  }

  /*
  tells the Player to move left. updates the view if the model returns true
   */
  void moveLeft() {
    List<String> crates_old = ksModel.crateList();
        print(crates_old);
        String playerPos_old = ksModel.playerPositionAsString();
        print(playerPos_old);
       // ksView.updateView(playerPos_old,crates_old,playerPos_old,crates_old);
        if (ksModel.moveLeft() == true) {
          
          List<String> crates_new = ksModel.crateList();
          print(crates_new);
          String playerPos_new = ksModel.playerPositionAsString();
          print(playerPos_new);
          updateView(playerPos_old,crates_old,playerPos_new,crates_new);
          
    }
  }

  /*
  moves the player to a position when the touchscreen is used.
   */
  void moveTouch() {

  }

  /*
  takes the positions of the player and the crates
   */
  void updateView(String playerPos_old, List<String>crates_old, String playerPos_new, List<String> crates_new) {
//    List<String> cratePositions_new = ksModel.crateList(); //Liste von Positionen von Kisten;
//    String playerposition_new = ksModel.playerPositionAsString();
    
    ksView.updateView(playerPos_old,crates_old,playerPos_new,crates_new);
   // ksView.updateView(playerPos_old,crates_old,playerPos_new,crates_new);

  }

  /*
  creates the model, starts a new game and creates the map from a String (later from a xml)
   */
  void newGame() {
    ksModel = new KistenschiebenModel();
    ksView = new KistenschiebenView();
    int m = 6;
    int n = 6;
    ksModel.loadLvl(level, m, n);
    ksView.loadLevel(level);
  }

  void resetGame() {
    int m = 6;
    int n = 6;
    ksModel.reset(level, m, n);
  }



}


void main(){
  
  KistenschiebenController control = new KistenschiebenController();






  querySelector("button").onMouseDown.listen((MouseEvent e){

    control.newGame();


  }




  );











//HttpRequest request = new HttpRequest();





//print(decoded);
//  String player = "#pos2_4";
//  List<String> crates = ["#pos2_3","#pos3_4"];
//  view.updateView(player,crates);
 
}




