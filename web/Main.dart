import 'dart:html';
import '../lib/src/KistenschiebenController.dart';




void main() {
  KistenschiebenController control = new KistenschiebenController();
    //control.registerUser("Peter Enis", "VeraAgina");

  querySelector("#b1_3").onMouseDown.listen((MouseEvent e) {

     control.newGame();
  });


  querySelector("b1_1").onMouseDown.listen((MouseEvent e)async{

    //await control.registerUser("name","passwort");


  });



}
