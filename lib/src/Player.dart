import 'dart:core';

import 'FieldObject.dart';
import 'Statistics.dart';

class Player {
  FieldObject _staysOn = null;
  int _pushPower = 1;
  int _pullPower = 0;
  Statistics _stats = Statistics.getInstance();

  Player(FieldObject staysOn) {
    this._staysOn = staysOn;
  }

  int getPullAmount() {
    return _pullPower;
  }

  /*
  Moves the player to the upper position
  returns true if possible, false if not
   */
  List<String> moveUp(int pullAmount) {
    List changedPositions = new List();
    _pullPower = _pullPower + pullAmount;
    bool cratePulled = false;
    if (_staysOn.upPointer != null) {
      if (_pullPower > 0 && _staysOn.downPointer.hasCrate() &&
          _staysOn.upPointer.hasCrate() == false) {
        changedPositions.add(_staysOn.downPointer.getPositionAsString());
        _staysOn.downPointer.crate.moveUp(_pushPower);
        _pullPower--;
        cratePulled = true;
      }
      changedPositions.addAll(_staysOn.upPointer.isPassable(_staysOn, _pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        if (cratePulled == true) {
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[2];
          changedPositions[2] = temp;
        }
        _staysOn = _staysOn.upPointer;
        _stats.incMoves();
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
    _pullPower = _pullPower + pullAmount;
    bool cratePulled = false;
    if (_staysOn.rightPointer != null) {
      if (_pullPower > 0 && _staysOn.leftPointer.hasCrate() &&
          _staysOn.rightPointer.hasCrate() == false) {
        changedPositions.add(_staysOn.leftPointer.getPositionAsString());
        _staysOn.leftPointer.crate.moveRight(_pushPower);
        _pullPower--;
        cratePulled = true;
      }
      changedPositions.addAll(_staysOn.rightPointer.isPassable(_staysOn, _pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        if (cratePulled == true) {
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[2];
          changedPositions[2] = temp;
        }
        _staysOn = _staysOn.rightPointer;
        _stats.incMoves();
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
    _pullPower = _pullPower + pullAmount;
    bool cratePulled = false;
    if (_staysOn.downPointer != null) {
      if (_pullPower > 0 && _staysOn.upPointer.hasCrate() &&
          _staysOn.downPointer.hasCrate() == false) {
        changedPositions.add(_staysOn.upPointer.getPositionAsString());
        _staysOn.upPointer.crate.moveDown(_pushPower);
        _pullPower--;
        cratePulled = true;
      }
      changedPositions.addAll(_staysOn.downPointer.isPassable(_staysOn, _pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        if (cratePulled == true) {
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[2];
          changedPositions[2] = temp;
        }
        _staysOn = _staysOn.downPointer;
        _stats.incMoves();
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
    _pullPower = _pullPower + pullAmount;
    bool cratePulled = false;
    if (_staysOn.leftPointer != null) {
      if (_pullPower > 0 && _staysOn.rightPointer.hasCrate() &&
          _staysOn.leftPointer.hasCrate() == false) {
        changedPositions.add(_staysOn.rightPointer.getPositionAsString());
        _staysOn.rightPointer.crate.moveLeft(_pushPower);
        _pullPower--;
        cratePulled = true;
      }
      changedPositions.addAll(_staysOn.leftPointer.isPassable(_staysOn, _pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        if (cratePulled == true) {
          String temp = changedPositions[0];
          changedPositions[0] = changedPositions[2];
          changedPositions[2] = temp;
        }
        _staysOn = _staysOn.leftPointer;
        _stats.incMoves();
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
    return this._staysOn.getPosition().getX();
  }

  /*
		Returns the y value of the position
	*/
  int getPosY() {
    return this._staysOn.getPosition().getY();
  }

  int getPushPower() {
    return _pushPower;
  }

  void setPushPower(int pushPower) {
    this._pushPower = pushPower;
  }
}