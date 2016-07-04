import 'dart:core';

import 'FieldObject.dart';
import 'Statistics.dart';

class Player {
  FieldObject _staysOn = null;
  static const _stdPushPower = 1;
  int _pushPower = _stdPushPower;
  int _stickyGloveAmount = 0;
  int _steroidAmount = 0;

  Statistics _stats = Statistics.getInstance();
  List<String> _noPositionChanges = new List();

  Player(FieldObject staysOn) {
    this._staysOn = staysOn;
  }

  int getStickyGloveAmount() {
    return _stickyGloveAmount;
  }

  int getSteroidAmount() {
    return _steroidAmount;
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

  /*
  Moves the player to the upper position
  returns true if possible, false if not
   */
  List<String> moveUp(int stickyGloveAmount, int steroidAmount) {
    List changedPositions = new List();
    _stickyGloveAmount = _stickyGloveAmount + stickyGloveAmount;
    _steroidAmount = steroidAmount;
    _pushPower = _pushPower + _steroidAmount;
    bool cratePulled = false;
    if (_staysOn.upPointer != null) {
      if (_stickyGloveAmount > 0 && _staysOn.downPointer.hasCrate() &&
          _staysOn.upPointer.hasCrate() == false && _staysOn.upPointer
          .isPassable(_staysOn, _pushPower)
          .isEmpty == false) {
        changedPositions.add(_staysOn.downPointer.getPositionAsString());
        _staysOn.downPointer.crate.moveUp(_pushPower);
        _stickyGloveAmount--;
        _stats.decGloves();
        _stats.incUsedGloves();
        cratePulled = true;
      }
      changedPositions.addAll(
          _staysOn.upPointer.isPassable(_staysOn, _pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        if (cratePulled == true) {
          sortList(changedPositions);
        }
        _staysOn = _staysOn.upPointer;
        _stats.incMoves();
        if (steroidAmount > 0) {
          _stats.decSteroids(steroidAmount);
          _stats.incUsedSteroids(steroidAmount);
        }
        _pushPower = _stdPushPower;
        _steroidAmount = 0;
        print(changedPositions);
        return changedPositions;
      } else {
        return _noPositionChanges;
      }
    } else {
      return _noPositionChanges;
    }
  }

  /*
  Moves the player to the right position
  returns true if possible, false if not
   */
  List<String> moveRight(int stickyGloveAmount, int steroidAmount) {
    List changedPositions = new List();
    _stickyGloveAmount = _stickyGloveAmount + stickyGloveAmount;
    _steroidAmount = steroidAmount;
    _pushPower = _pushPower + _steroidAmount;
    bool cratePulled = false;
    if (_staysOn.rightPointer != null) {
      if (_stickyGloveAmount > 0 && _staysOn.leftPointer.hasCrate() &&
          _staysOn.rightPointer.hasCrate() == false && _staysOn.rightPointer
          .isPassable(_staysOn, _pushPower)
          .isEmpty == false) {
        changedPositions.add(_staysOn.leftPointer.getPositionAsString());
        _staysOn.leftPointer.crate.moveRight(_pushPower);
        _stickyGloveAmount--;
        _stats.decGloves();
        _stats.incUsedGloves();
        cratePulled = true;
      }
      changedPositions.addAll(
          _staysOn.rightPointer.isPassable(_staysOn, _pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        if (cratePulled == true) {
          sortList(changedPositions);
        }
        _staysOn = _staysOn.rightPointer;
        _stats.incMoves();
        if (steroidAmount > 0) {
          _stats.decSteroids(steroidAmount);
          _stats.incUsedSteroids(steroidAmount);
        }
        _pushPower = _stdPushPower;
        _steroidAmount = 0;
        return changedPositions;
      } else {
        return _noPositionChanges;
      }
    } else {
      return _noPositionChanges;
    }
  }

  /*
  Moves the player to the position below
  returns true if possible, false if not
   */
  List<String> moveDown(int stickyGloveAmount, int steroidAmount) {
    List changedPositions = new List();
    _stickyGloveAmount = _stickyGloveAmount + stickyGloveAmount;
    _steroidAmount = steroidAmount;
    _pushPower = _pushPower + _steroidAmount;
    bool cratePulled = false;
    if (_staysOn.downPointer != null) {
      if (_stickyGloveAmount > 0 && _staysOn.upPointer.hasCrate() &&
          _staysOn.downPointer.hasCrate() == false && _staysOn.downPointer
          .isPassable(_staysOn, _pushPower)
          .isEmpty == false) {
        changedPositions.add(_staysOn.upPointer.getPositionAsString());
        _staysOn.upPointer.crate.moveDown(_pushPower);
        _stickyGloveAmount--;
        _stats.decGloves();
        _stats.incUsedGloves();
        cratePulled = true;
      }
      changedPositions.addAll(
          _staysOn.downPointer.isPassable(_staysOn, _pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        if (cratePulled == true) {
          sortList(changedPositions);
        }
        _staysOn = _staysOn.downPointer;
        _stats.incMoves();
        if (steroidAmount > 0) {
          _stats.decSteroids(steroidAmount);
          _stats.incUsedSteroids(steroidAmount);
        }
        _pushPower = _stdPushPower;
        _steroidAmount = 0;
        return changedPositions;
      } else {
        return _noPositionChanges;
      }
    } else {
      return _noPositionChanges;
    }
  }

  /*
  Moves the player to the left position
  returns true if possible, false if not
   */
  List<String> moveLeft(int stickyGloveAmount, int steroidAmount) {
    List changedPositions = new List();
    _stickyGloveAmount = _stickyGloveAmount + stickyGloveAmount;
    _steroidAmount = steroidAmount;
    _pushPower = _pushPower + _steroidAmount;
    bool cratePulled = false;
    if (_staysOn.leftPointer != null) {
      if (_stickyGloveAmount > 0 && _staysOn.rightPointer.hasCrate() &&
          _staysOn.leftPointer.hasCrate() == false && _staysOn.leftPointer
          .isPassable(_staysOn, _pushPower)
          .isEmpty == false) {
        changedPositions.add(_staysOn.rightPointer.getPositionAsString());
        _staysOn.rightPointer.crate.moveLeft(_pushPower);
        _stickyGloveAmount--;
        _stats.decGloves();
        _stats.incUsedGloves();
        cratePulled = true;
      }
      changedPositions.addAll(
          _staysOn.leftPointer.isPassable(_staysOn, _pushPower));
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        if (cratePulled == true) {
          sortList(changedPositions);
        }
        _staysOn = _staysOn.leftPointer;
        _stats.incMoves();
        if (steroidAmount > 0) {
          _stats.decSteroids(steroidAmount);
          _stats.incUsedSteroids(steroidAmount);
        }
        _pushPower = _stdPushPower;
        _steroidAmount = 0;
        return changedPositions;
      } else {
        return _noPositionChanges;
      }
    } else {
      return _noPositionChanges;
    }
  }

  /*
  sorts the List for the view,
  because the order after pull is different to the order after push
   */
  List<String> sortList(List<String> changedPositions) {
    String temp = changedPositions[0];
    changedPositions[0] = changedPositions[2];
    changedPositions[2] = temp;
    return changedPositions;
  }
}