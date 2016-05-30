import 'dart:core';
import 'FieldObject.dart';

class Player {
  //bool won = false;
  FieldObject staysOn;
  int pushPower = 1;

  //parametrisierung für die Endabgabe funktioniert noch nicht!

  Player(FieldObject staysOn) {
    this.staysOn = staysOn;
  }

  /*
  Moves the player to the upper position
  returns true if possible, false if not
   */
  bool moveUp() {
    if (staysOn.upPointer.isPassable(staysOn, pushPower) == true) {
      staysOn = staysOn.upPointer;
      //if(staysOn.upPointer.crate.won == true){this.won = true;}
      print("PlayerPosition: " + getPosition());
      return true;
    } else {
      print("PlayerPosition: " + getPosition());
      return false;
    }
  }

  /*
  Moves the player to the right position
  returns true if possible, false if not
   */
  bool moveRight() {
    if (staysOn.rightPointer.isPassable(staysOn, pushPower) == true) {
      staysOn = staysOn.rightPointer;
      //if(staysOn.rightPointer.crate.won == true){this.won = true;}
      print("PlayerPosition: " + getPosition());
      return true;
    } else {
      print("PlayerPosition: " + getPosition());
      return false;
    }
  }

  /*
  Moves the player to the position below
  returns true if possible, false if not
   */
  bool moveDown() {
    if (staysOn.downPointer.isPassable(staysOn, pushPower) == true) {
      staysOn = staysOn.downPointer;
      //if(staysOn.downPointer.crate.won == true){this.won = true;}
      print("PlayerPosition: " + getPosition());
      return true;
    } else {
      print("PlayerPosition: " + getPosition());
      return false;
    }
  }

  /*
  Moves the player to the left position
  returns true if possible, false if not
   */
  bool moveLeft() {
    if (staysOn.leftPointer.isPassable(staysOn, pushPower) == true) {
      staysOn = staysOn.leftPointer;
      //if(staysOn.leftPointer.crate.won == true){this.won = true;}
      print("PlayerPosition: " + getPosition());
      return true;
    } else {
      print("PlayerPosition: " + getPosition());
      return false;
    }
  }


  String getPosition() {
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