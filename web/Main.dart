import 'dart:html';
import '../lib/src/KistenschiebenController.dart';
import 'dart:convert';
import 'package:json/json.dart';



void main() {
  KistenschiebenController control = new KistenschiebenController();
    //control.registerUser("Peter Enis", "VeraAgina");

  querySelector('#b4').onMouseDown.listen((MouseEvent e) {

    control.newGame();
  });



  querySelector("#b1_3").onMouseDown.listen((MouseEvent e) {

     control.newGame();
  });





}






