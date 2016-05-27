import 'dart:html';
import '../lib/src/KistenschiebenController.dart';

void main() {
  KistenschiebenController control = new KistenschiebenController();
    control.registerUser("Peter Enis", "VeraAgina");
    querySelector("button").onMouseDown.listen((MouseEvent e) {
    control.newGame();
  });
}
