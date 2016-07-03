import 'FieldObject.dart';
import 'Statistics.dart';

/**
 * A Crate stays on a fieldObject of the type ground or target.
 */
class Crate {
  Statistics _stats = Statistics.getInstance();
  //The FieldObject on which the crate stays on
  var _staysOn = null;

  /**
   * Constructor
   */
  Crate(FieldObject _staysOn) {
    this._staysOn = _staysOn;
  }

  FieldObject getStaysOn() {
    return this._staysOn;
  }

  /*
   *
   */
  List move(FieldObject whereActorStaysOn, int pushPower) {
    List ret = new List();
    if (whereActorStaysOn == _staysOn.upPointer) {
      ret = moveDown(pushPower);
    } else if (whereActorStaysOn == _staysOn.rightPointer) {
      ret = moveLeft(pushPower);
    } else if (whereActorStaysOn == _staysOn.downPointer) {
      ret = moveUp(pushPower);
    } else if (whereActorStaysOn == _staysOn.leftPointer) {
      ret = moveRight(pushPower);
    }
    return ret;
  }

  List moveUp(int pushPower) {
    pushPower--;
    if (_staysOn.upPointer != null) {
      List changedPositions = _staysOn.upPointer.isPassable(
          _staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        _staysOn = _staysOn.upPointer;
        _staysOn.downPointer.crate = null;
        _staysOn.crate = this;
        if (_staysOn.runtimeType.toString().contains("Target")) {
          _staysOn.checkOutNeighbours();
        }
        if (_staysOn.downPointer.runtimeType.toString().contains("Target")) {
          _staysOn.downPointer.checkOutNeighbours();
        }
        _stats.incPushes();
        return changedPositions;
      } else {
        return new List();
      }
    } else {
      return new List();
    }
  }

  List moveRight(int pushPower) {
    pushPower--;
    if (_staysOn.rightPointer != null) {
      List changedPositions = _staysOn.rightPointer.isPassable(
          _staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        _staysOn = _staysOn.rightPointer;
        _staysOn.leftPointer.crate = null;
        _staysOn.crate = this;
        if (_staysOn.runtimeType.toString().contains("Target")) {
          _staysOn.checkOutNeighbours();
        }
        if (_staysOn.leftPointer.runtimeType.toString().contains("Target")) {
          _staysOn.leftPointer.checkOutNeighbours();
        }
        _stats.incPushes();
        return changedPositions;
      } else {
        return new List();
      }
    } else {
      return new List();
    }
  }

  List moveDown(int pushPower) {
    pushPower--;
    if (_staysOn.downPointer != null) {
      List changedPositions = _staysOn.downPointer.isPassable(
          _staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        _staysOn = _staysOn.downPointer;
        _staysOn.upPointer.crate = null;
        _staysOn.crate = this;
        if (_staysOn.runtimeType.toString().contains("Target")) {
          _staysOn.checkOutNeighbours();
        }
        if (_staysOn.upPointer.runtimeType.toString().contains("Target")) {
          _staysOn.upPointer.checkOutNeighbours();
        }
        _stats.incPushes();
        return changedPositions;
      } else {
        return new List();
      }
    } else {
      return new List();
    }
  }

  List moveLeft(int pushPower) {
    pushPower--;
    if (_staysOn.leftPointer != null) {
      List changedPositions = _staysOn.leftPointer.isPassable(
          _staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this._staysOn.getPositionAsString());
        _staysOn = _staysOn.leftPointer;
        _staysOn.rightPointer.crate = null;
        _staysOn.crate = this;
        if (_staysOn.runtimeType.toString().contains("Target")) {
          _staysOn.checkOutNeighbours();
        }
        if (_staysOn.rightPointer.runtimeType.toString().contains("Target")) {
          _staysOn.rightPointer.checkOutNeighbours();
        }
        _stats.incPushes();
        return changedPositions;
      } else {
        return new List();
      }
    } else {
      return new List();
    }
  }
}