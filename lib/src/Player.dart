import 'dart:core';

import 'FieldObject.dart';
import 'Statistics.dart';

class Player {
  FieldObject staysOn;
  int pushPower = 1;
  int pullPower = 0;
  Statistics stats = Statistics.getInstance();

  Player(FieldObject staysOn) {
    this.staysOn = staysOn;
  }

  int getPullAmount() {
    return pullPower;
  }

  /*
  Moves the player to the upper position
  returns true if possible, false if not
   */
  List<String> moveUp(int pullAmount) {
    pullPower = pullPower + pullAmount;
    if (staysOn.upPointer != null) {
      List changedPositions = staysOn.upPointer.isPassable(staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        if (pullPower > 0 && staysOn.downPointer.crate != null) {
          changedPositions.add(staysOn.downPointer.getPositionAsString());
          staysOn.downPointer.crate.moveUp(pushPower);
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[1];
          changedPositions[1] = temp;
          pullPower--;
        }
        staysOn = staysOn.upPointer;
        stats.incMoves();
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
  List<String> moveRight(int pullAmount) {
    pullPower = pullPower + pullAmount;
    if (staysOn.rightPointer != null) {
      List changedPositions = staysOn.rightPointer.isPassable(
          staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        if (pullPower > 0 && staysOn.leftPointer.crate != null) {
          changedPositions.add(staysOn.leftPointer.getPositionAsString());
          staysOn.leftPointer.crate.moveRight(pushPower);
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[1];
          changedPositions[1] = temp;
          pullPower--;
        }
        staysOn = staysOn.rightPointer;
        stats.incMoves();
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
  List<String> moveDown(int pullAmount) {
    pullPower = pullPower + pullAmount;
    if (staysOn.downPointer != null) {
      List changedPositions = staysOn.downPointer.isPassable(
          staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        if (pullPower > 0 && staysOn.upPointer.crate != null) {
          changedPositions.add(staysOn.upPointer.getPositionAsString());
          staysOn.upPointer.crate.moveDown(pushPower);
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[1];
          changedPositions[1] = temp;
          pullPower--;
        }
        staysOn = staysOn.downPointer;
        stats.incMoves();
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
  List<String> moveLeft(int pullAmount) {
    pullPower = pullPower + pullAmount;
    if (staysOn.leftPointer != null) {
      List changedPositions = staysOn.leftPointer.isPassable(
          staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        if (pullPower > 0 && staysOn.rightPointer.crate != null) {
          changedPositions.add(staysOn.rightPointer.getPositionAsString());
          staysOn.rightPointer.crate.moveLeft(pushPower);
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[1];
          changedPositions[1] = temp;
          pullPower--;
        }
        staysOn = staysOn.leftPointer;
        stats.incMoves();
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

  int getPushPower() {
    return pushPower;
  }

  void setPushPower(int pushpower) {
    this.pushPower = pushpower;
  }
}