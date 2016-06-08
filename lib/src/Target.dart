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
    print("checkOutNeightboursPrev: "+ (this.crate != null).toString());
    if((this.prevTarget == null || this.prevTarget.checkOutNeighboursPrev()==true) && this.crate != null) {
      ret = true;
      print("Prev: true");
    } else {
      ret = false;
      print("Prev: false");
    }
    return ret;
  }

  bool checkOutNeighboursNext() {
    bool ret = false;
    if((this.nextTarget == null || this.nextTarget.checkOutNeighboursNext()==true) && this.crate != null) {
      ret = true;
      print("Next: true");
    } else {
      ret = false;
      print("Next: false");
    }
    return ret;
  }


  /*
  checkOutNeighbours() {
    return checkOutNeighboursL() && checkOutNeighboursR();
  }

  checkOutNeighboursL() {
    if (this.prevTarget == null) {
      return true;
    } else if (this.prevTarget.crate != null) {
      return this.prevTarget.checkOutNeighboursL();
    }
    return false;
  }

  checkOutNeighboursR() {
    if (this.nextTarget == null) {
      return true;
    } else if (this.nextTarget.crate != null) {
      return this.nextTarget.checkOutNeighboursR();
    }
    return false;
  }
  */
}