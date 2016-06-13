import 'FieldObject.dart';

class Target extends FieldObject {

  Target prevTarget = null;
  Target nextTarget = null;
  bool _won = false;


  Target(Target prevTarget) : super() {
    this.passable = true;
    this.isTarget = true;
    this.isWall = false;
    this.prevTarget = prevTarget;
    if (this.prevTarget != null) {
      this.prevTarget.nextTarget = this;
    }
  }

  bool getWon() {
    return this._won;
  }

  bool checkOutNeighbours() {
    bool ret = false;
    ret = checkOutNeighboursPrev() && checkOutNeighboursNext();
    if (ret == true) {
      setPrevWon();
      setNextWon();
    }
    return ret;
  }

  bool checkOutNeighboursPrev() {
    bool ret = false;
    if((this.prevTarget == null || this.prevTarget.checkOutNeighboursPrev()==true) && this.crate != null) {
      ret = true;
    } else {
      ret = false;
    }
    return ret;
  }

  bool checkOutNeighboursNext() {
    bool ret = false;
    if((this.nextTarget == null || this.nextTarget.checkOutNeighboursNext()==true) && this.crate != null) {
      ret = true;
    } else {
      ret = false;
    }
    return ret;
  }

  setPrevWon() {
    this._won = true;
    if (this.prevTarget != null) {
      this.prevTarget.setPrevWon();
    }
  }

  setNextWon() {
    this._won = true;
    if (this.nextTarget != null) {
      this.nextTarget.setNextWon();
    }
  }
}