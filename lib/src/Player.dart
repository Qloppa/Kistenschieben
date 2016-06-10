import 'dart:core';
import 'FieldObject.dart';

class Player {
  FieldObject staysOn;
  int pushPower = 62;

  //parametrisierung für die Endabgabe funktioniert noch nicht!

  Player(FieldObject staysOn) {
    this.staysOn = staysOn;
  }

  /*
  Moves the player to the upper position
  returns true if possible, false if not
   */
  bool moveUp() {
    if (staysOn.upPointer != null) {
      List changedPositions = staysOn.upPointer.isPassable(staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        print(changedPositions);
        staysOn = staysOn.upPointer;
        print("PlayerPosition: " + getPosition());
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /*
  Moves the player to the right position
  returns true if possible, false if not
   */
  bool moveRight() {
    if (staysOn.rightPointer != null) {
      List changedPositions = staysOn.rightPointer.isPassable(staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        print(changedPositions);
        staysOn = staysOn.rightPointer;
        print("PlayerPosition: " + getPosition());
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /*
  Moves the player to the position below
  returns true if possible, false if not
   */
  bool moveDown() {
    if (staysOn.downPointer != null) {
      List changedPositions = staysOn.downPointer.isPassable(staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        print(changedPositions);
        staysOn = staysOn.downPointer;
        print("PlayerPosition: " + getPosition());
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /*
  Moves the player to the left position
  returns true if possible, false if not
   */
  bool moveLeft() {
    if (staysOn.leftPointer != null) {
      List changedPositions = staysOn.leftPointer.isPassable(staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        print(changedPositions);
        staysOn = staysOn.leftPointer;
        print("PlayerPosition: " + getPosition());
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /*
  Returns the position of the actual field of the player as a String of two numbers separated by a ","
  */
  String getPosition() {
    return this.staysOn.position.x.toString() + "," +
        this.staysOn.position.y.toString();
  }

  /*
		Returns the x value of the position
	*/
  int getPosX() {
    return this.staysOn.position.getX();
  }

  /*
		Returns the y value of the position
	*/
  int getPosY() {
    return this.staysOn.position.getY();
  }

  /*
  Returns the position of the field as a String for the view
   */
  String getPositionAsString() {
    //TODO fällt wohl weg, wenn CrateList neu implementiert
    String str = "#pos" + this.staysOn.position.x.toString() + "_" +
        this.staysOn.position.y.toString();
    return str;
  }
}