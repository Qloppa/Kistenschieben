import 'FieldObject.dart';

class Target extends FieldObject {

  Target prevTarget = null;
  Target nextTarget = null;


  Target(Target prevTarget) : super() {
    this.passable = true;
    this.isTarget = true;
    this.isWall = false;
    this.prevTarget = prevTarget;
    if (this.prevTarget != null) {
      this.prevTarget.nextTarget = this;
    }
  }

  bool checkOutNeighbours() {
    return checkOutNeighboursPrev() && checkOutNeighboursNext();
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
}
