import 'Position.dart';
import 'Crate.dart';

class FieldObject {
  Crate crate;

  //Position
  Position position = new Position(0, 0);

  //object Booleans
  bool passable;
  bool isTarget;
  bool isWall;

  //pointer
  FieldObject rightPointer;
  FieldObject leftPointer;
  FieldObject upPointer;
  FieldObject downPointer;
  FieldObject prevTarget;
  FieldObject nextTarget;

  FieldObject() {
    this.upPointer = null;
    this.rightPointer = null;
    this.downPointer = null;
    this.leftPointer = null;
  }

  isPassable(FieldObject wherePlayerStaysOn, int pushPower) {
    if (this.crate == null) {
      return true;
    } else if (pushPower > 0) {
      return crate.move(wherePlayerStaysOn, pushPower);
    } else {
      return false;
    }
  }

  setCrate(Crate crate) {
    this.crate = crate;
  }

}