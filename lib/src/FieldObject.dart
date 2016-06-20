import 'Crate.dart';
import 'Position.dart';

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

  /**
   * Constructor
   */
  FieldObject() {
    this.upPointer = null;
    this.rightPointer = null;
    this.downPointer = null;
    this.leftPointer = null;
    this.prevTarget = null;
    this.nextTarget = null;
  }

  /**
   * checks if the fieldObject is passable for the player
   */
  List isPassable(FieldObject whereActorStaysOn, int pushPower) {
    if (this.crate == null) {
      List changedPositions = new List();
      changedPositions.add(this.getPositionAsString());
      return changedPositions;
    } else if (pushPower > 0) {
      return crate.move(whereActorStaysOn, pushPower);
    } else {
      return new List();
    }
  }

  /**
   * Sets the crate
   */
  setCrate(Crate crate) {
    this.crate = crate;
  }

  /**
   * Returns the position as a String "#posX_Y"
   */
  String getPositionAsString() {
    String str = this.position.x.toString() + "_" +
        this.position.y.toString();
    return str;
  }
}