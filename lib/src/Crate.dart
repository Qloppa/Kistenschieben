import 'FieldObject.dart';

class Crate {
  var staysOn;

  Crate(FieldObject staysOn) {
    this.staysOn = staysOn;
    staysOn.passable = false;
  }

  move(FieldObject whereActorStaysOn, pushPower) {
    if (whereActorStaysOn == staysOn.upPointer) {
      return moveDown(pushPower);
    } else if (whereActorStaysOn == staysOn.rightPointer) {
      return moveLeft(pushPower);
    } else if (whereActorStaysOn == staysOn.downPointer) {
      return moveUp(pushPower);
    } else if (whereActorStaysOn == staysOn.leftPointer) {
      return moveRight(pushPower);
    }
  }

  moveUp(int pushPower) {
    pushPower--;
    if (staysOn.upPointer != null &&
        staysOn.upPointer.isPassable(staysOn, pushPower) == true) {
      //upPointer gelöscht
      staysOn = staysOn.upPointer;
      staysOn.downPointer.crate = null;
      staysOn.crate = this;
      if (staysOn.runtimeType.toString().contains("Target")) {
        if (staysOn.checkOutNeighbours() == true) {
          print("You won!!!");
        }
      }
      print("CratePosition: " + getPosition());
      return true;
    } else {
      print("CratePosition: " + getPosition());
      return false;
    }
  }

  moveRight(int pushPower) {
    pushPower--;
    if (staysOn.rightPointer != null &&
        staysOn.rightPointer.isPassable(staysOn, pushPower) == true) {
      staysOn = staysOn.rightPointer;
      staysOn.leftPointer.crate = null;
      staysOn.crate = this;
      if (staysOn.runtimeType.toString().contains("Target")) {
        if (staysOn.checkOutNeighbours() == true) {
          print("You won!!!");
        }
      }
      print("CratePosition: " + getPosition());
      return true;
    } else {
      print("CratePosition: " + getPosition());
      return false;
    }
  }

  moveDown(int pushPower) {
    pushPower--;
    if (staysOn.downPointer != null &&
        staysOn.downPointer.isPassable(staysOn, pushPower) == true) {
      staysOn = staysOn.downPointer;
      staysOn.upPointer.crate = null;
      staysOn.crate = this;
      if (staysOn.runtimeType.toString().contains("Target")) {
        if (staysOn.checkOutNeighbours() == true) {
          print("You won!!!");
        }
      }
      print("CratePosition: " + getPosition());
      return true;
    } else {
      print("CratePosition: " + getPosition());
      return false;
    }
  }

  moveLeft(int pushPower) {
    pushPower--;
    if (staysOn.leftPointer != null &&
        staysOn.leftPointer.isPassable(staysOn, pushPower) == true) {
      staysOn = staysOn.leftPointer;
      staysOn.rightPointer.crate = null;
      staysOn.crate = this;
      if (staysOn.runtimeType.toString().contains("Target")) {
        if (staysOn.checkOutNeighbours() == true) {
          print("You won!!!");
        }
      }
      print("CratePosition: " + getPosition());
      return true;
    } else {
      print("CratePosition: " + getPosition());
      return false;
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