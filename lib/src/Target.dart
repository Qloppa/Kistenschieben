import 'FieldObject.dart';

/**
 * A FieldObject of the type target. Each Crates must be on a target to win the game
 */
class Target extends FieldObject {

  Target prevTarget = null;
  Target nextTarget = null;
  bool _won = false;


  /**
   * Constructor
   */
  Target(Target prevTarget) : super() {
    this.passable = true;
    this.isTarget = true;
    this.isWall = false;
    this.prevTarget = prevTarget;
    if (this.prevTarget != null) {
      this.prevTarget.nextTarget = this;
    }
  }

  /**
   * returns if won
   */
  bool getWon() {
    return this._won;
  }

  //checks if the other targets have crates on them
  bool checkOutNeighbours() {
    bool ret = false;
    ret = checkOutNeighboursPrev() && checkOutNeighboursNext();
    setPrevWon(ret);
    setNextWon(ret);
    return ret;
  }

  /**
   * checks the previous neighbours
   */
  bool checkOutNeighboursPrev() {
    bool ret = false;
    if((this.prevTarget == null || this.prevTarget.checkOutNeighboursPrev()==true) && this.crate != null) {
      ret = true;
    } else {
      ret = false;
    }
    return ret;
  }

  /**
   * checks the next neighbours
   */
  bool checkOutNeighboursNext() {
    bool ret = false;
    if((this.nextTarget == null || this.nextTarget.checkOutNeighboursNext()==true) && this.crate != null) {
      ret = true;
    } else {
      ret = false;
    }
    return ret;
  }

  /**
   * sets the previous neighbour to "won"
   */
  setPrevWon(bool won) {
    this._won = won;
    if (this.prevTarget != null) {
      this.prevTarget.setPrevWon(_won);
    }
  }

  /**
   * sets the next neighbour to "won"
   */
  setNextWon(bool won) {
    this._won = won;
    if (this.nextTarget != null) {
      this.nextTarget.setNextWon(_won);
    }
  }
}
