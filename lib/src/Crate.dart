import 'FieldObject.dart';

class Crate {
  var staysOn;

  Crate(FieldObject staysOn) {
    this.staysOn = staysOn;
    staysOn.passable = false;
  }

  List move(FieldObject whereActorStaysOn, pushPower) {
    List ret = new List();
    if (whereActorStaysOn == staysOn.upPointer) {
      ret = moveDown(pushPower);
    } else if (whereActorStaysOn == staysOn.rightPointer) {
      ret = moveLeft(pushPower);
    } else if (whereActorStaysOn == staysOn.downPointer) {
      ret = moveUp(pushPower);
    } else if (whereActorStaysOn == staysOn.leftPointer) {
      ret = moveRight(pushPower);
    }
    return ret;
  }

  List moveUp(int pushPower) {
    pushPower--;
    if (staysOn.upPointer != null) {
      List changedPositions = staysOn.upPointer.isPassable(staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        staysOn = staysOn.upPointer;
        staysOn.downPointer.crate = null;
        staysOn.crate = this;
        if (staysOn.runtimeType.toString().contains("Target")) {
          if (staysOn.checkOutNeighbours() == true) {
            print("You won!!!");
          }
        }
        print("CratePosition: " + getPosition());
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
    if (staysOn.rightPointer != null) {
      List changedPositions = staysOn.rightPointer.isPassable(
          staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        staysOn = staysOn.rightPointer;
        staysOn.leftPointer.crate = null;
        staysOn.crate = this;
        if (staysOn.runtimeType.toString().contains("Target")) {
          if (staysOn.checkOutNeighbours() == true) {
            print("You won!!!");
          }
        }
        print("CratePosition: " + getPosition());
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
    if (staysOn.downPointer != null) {
      List changedPositions = staysOn.downPointer.isPassable(
          staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        staysOn = staysOn.downPointer;
        staysOn.upPointer.crate = null;
        staysOn.crate = this;
        if (staysOn.runtimeType.toString().contains("Target")) {
          if (staysOn.checkOutNeighbours() == true) {
            print("You won!!!");
          }
        }
        print("CratePosition: " + getPosition());
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
    if (staysOn.leftPointer != null) {
      List changedPositions = staysOn.leftPointer.isPassable(
          staysOn, pushPower);
      if (changedPositions.isEmpty == false) {
        changedPositions.add(this.staysOn.getPositionAsString());
        staysOn = staysOn.leftPointer;
        staysOn.rightPointer.crate = null;
        staysOn.crate = this;
        if (staysOn.runtimeType.toString().contains("Target")) {
          if (staysOn.checkOutNeighbours() == true) {
            print("You won!!!");
          }
        }
        print("CratePosition: " + getPosition());
        return changedPositions;
      } else {
        return new List();
      }
    } else {
      return new List();
    }
  }

  getPosition() {
    return this.staysOn.position.x.toString() + "," +
        this.staysOn.position.y.toString();
  }

  /*
  Returns the position of the field as a String for the view
   */
  String getPositionAsString() {
    String str = "#pos" + this.staysOn.position.x.toString() + "_" +
        this.staysOn.position.y.toString();
    return str;
  }
}