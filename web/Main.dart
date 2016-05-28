import 'dart:html';
import '../lib/src/KistenschiebenController.dart';

  void main() {
    KistenschiebenController control = new KistenschiebenController();
    //control.gamekey.registerUser("ProfessorY", "passwort");
    //control.gamekey.deleteUser("ProfessorX");
    querySelector("button").onMouseDown.listen((MouseEvent e) {
      control.newGame();
    });
  }
