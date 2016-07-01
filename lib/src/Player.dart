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
    List changedPositions = new List();
    pullPower = pullPower + pullAmount;
    bool cratePulled = false;
    if (staysOn.upPointer != null) {
      if (pullPower > 0 && staysOn.downPointer.crate != null &&
          staysOn.upPointer.crate == null) {
        changedPositions.add(staysOn.downPointer.getPositionAsString());
        staysOn.downPointer.crate.moveUp(pushPower);
        pullPower--;
        cratePulled = true;
      }
      changedPositions.addAll(staysOn.upPointer.isPassable(staysOn, pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        if (cratePulled == true) {
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[2];
          changedPositions[2] = temp;
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
    List changedPositions = new List();
    pullPower = pullPower + pullAmount;
    bool cratePulled = false;
    if (staysOn.rightPointer != null) {
      if (pullPower > 0 && staysOn.leftPointer.crate != null &&
          staysOn.rightPointer.crate == null) {
        changedPositions.add(staysOn.leftPointer.getPositionAsString());
        staysOn.leftPointer.crate.moveRight(pushPower);
        pullPower--;
        cratePulled = true;
      }
      changedPositions.addAll(staysOn.rightPointer.isPassable(staysOn, pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        if (cratePulled == true) {
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[2];
          changedPositions[2] = temp;
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
    List changedPositions = new List();
    pullPower = pullPower + pullAmount;
    bool cratePulled = false;
    if (staysOn.downPointer != null) {
      if (pullPower > 0 && staysOn.upPointer.crate != null &&
          staysOn.downPointer.crate == null) {
        changedPositions.add(staysOn.upPointer.getPositionAsString());
        staysOn.upPointer.crate.moveDown(pushPower);
        pullPower--;
        cratePulled = true;
      }
      changedPositions.addAll(staysOn.downPointer.isPassable(staysOn, pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        if (cratePulled == true) {
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[2];
          changedPositions[2] = temp;
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
    List changedPositions = new List();
    pullPower = pullPower + pullAmount;
    bool cratePulled = false;
    if (staysOn.leftPointer != null) {
      if (pullPower > 0 && staysOn.rightPointer.crate != null &&
          staysOn.leftPointer.crate == null) {
        changedPositions.add(staysOn.rightPointer.getPositionAsString());
        staysOn.rightPointer.crate.moveLeft(pushPower);
        pullPower--;
        cratePulled = true;
      }
      changedPositions.addAll(staysOn.leftPointer.isPassable(staysOn, pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        if (cratePulled == true) {
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[2];
          changedPositions[2] = temp;
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