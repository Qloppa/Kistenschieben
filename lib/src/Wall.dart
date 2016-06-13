import 'FieldObject.dart';

class Wall extends FieldObject {

  //Wall benötigt eigentlich keine Pointer...möglicherweise super konstruktor entfernen
  Wall() : super() {
    this.passable = false;
    this.isTarget = false;
    this.isWall = true;
  }

  List isPassable(FieldObject player, pushPower) {
    return new List();
  }

  setCrate(crate) {
    return false;
  }
}