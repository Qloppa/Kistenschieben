import 'Crate.dart';
import 'Position.dart';

class FieldObject {
  Crate crate = null;
  //Position
  Position _position = new Position(0, 0);
  //pointer
  FieldObject rightPointer;
  FieldObject leftPointer;
  FieldObject upPointer;
  FieldObject downPointer;

  /**
   * Constructor
   */
  FieldObject() {
    this.upPointer = null;
    this.rightPointer = null;
    this.downPointer = null;
    this.leftPointer = null;
  }

  Position getPosition() {
   return _position;
  }

  Crate getCrate() {
    return this.crate;
  }

  /**
   * Sets the crate
   */
  void setCrate(Crate crate) {
    this.crate = crate;
  }

  bool hasCrate() {
    bool ret = false;
    if (this.crate != null) {
      ret = true;
    }
    return ret;
  }

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
   * Returns the position as a String "#posX_Y"
   */
  String getPositionAsString() {
    String str = this._position.getX().toString() + "_" +
        this._position.getY().toString();
    return str;
  }
}