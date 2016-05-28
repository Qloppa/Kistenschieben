import 'dart:html';
import '../lib/src/KistenschiebenController.dart';

  void main() {
    KistenschiebenController control = new KistenschiebenController();
    control.registerUser("Hallo Welt", "passwort");
    //control.printUserId("Nane");
    querySelector("button").onMouseDown.listen((MouseEvent e) {
      control.newGame();
    });
  }
