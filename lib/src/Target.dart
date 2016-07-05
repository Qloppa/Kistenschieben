import 'FieldObject.dart';

/**
 * A FieldObject of the type target. Each Crates must be on a target to win the game
 */
class Target extends FieldObject {
  Target _prevTarget = null;
  Target _nextTarget = null;
  bool _won = false;

  /**
   * Constructor
   */
  Target(Target prevTarget) {
    this._prevTarget = prevTarget;
    if (this._prevTarget != null) {
      this._prevTarget._nextTarget = this;
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
   * checks the previous neighbours out
   */
  bool checkOutNeighboursPrev() {
    bool ret = false;
    if ((this._prevTarget == null ||
        this._prevTarget.checkOutNeighboursPrev() == true) &&
        this.hasCrate()) {
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
    if ((this._nextTarget == null ||
        this._nextTarget.checkOutNeighboursNext() == true) &&
        this.hasCrate()) {
      ret = true;
    } else {
      ret = false;
    }
    return ret;
  }

  /**
   * sets the previous neighbour to "won"
   */
  void setPrevWon(bool won) {
    this._won = won;
    if (this._prevTarget != null) {
      this._prevTarget.setPrevWon(_won);
    }
  }

  /**
   * sets the next neighbour to "won"
   */
  void setNextWon(bool won) {
    this._won = won;
    if (this._nextTarget != null) {
      this._nextTarget.setNextWon(_won);
    }
  }
}
