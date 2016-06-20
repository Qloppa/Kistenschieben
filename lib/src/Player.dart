import 'dart:core';

import 'FieldObject.dart';

class Player {
  FieldObject staysOn;
  int pushPower = 1;

  Player(FieldObject staysOn) {
    this.staysOn = staysOn;
  }

  /*
  Moves the player to the upper position
  returns true if possible, false if not
   */
  List<String> moveUp() {
    if (staysOn.upPointer != null) {
      List changedPositions = staysOn.upPointer.isPassable(staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        print(changedPositions);
        staysOn = staysOn.upPointer;
        return changedPositions;
      } else {
        return new List();
      }
    } else {
      return new List();
    }
  }

  /*
  Moves the player to the right position
  returns true if possible, false if not
   */
  List<String> moveRight() {
    if (staysOn.rightPointer != null) {
      List changedPositions = staysOn.rightPointer.isPassable(
          staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        print(changedPositions);
        staysOn = staysOn.rightPointer;
        return changedPositions;
      } else {
        return new List();
      }
    } else {
      return new List();
    }
  }

  /*
  Moves the player to the position below
  returns true if possible, false if not
   */
  List<String> moveDown() {
    if (staysOn.downPointer != null) {
      List changedPositions = staysOn.downPointer.isPassable(
          staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        print(changedPositions);
        staysOn = staysOn.downPointer;
        return changedPositions;
      } else {
        return new List();
      }
    } else {
      return new List();
    }
  }

  /*
  Moves the player to the left position
  returns true if possible, false if not
   */
  List<String> moveLeft() {
    if (staysOn.leftPointer != null) {
      List changedPositions = staysOn.leftPointer.isPassable(
          staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        print(changedPositions);
        staysOn = staysOn.leftPointer;
        return changedPositions;
      } else {
        return new List();
      }
    } else {
      return new List();
    }
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
}
