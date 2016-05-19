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

}