import 'FieldObject.dart';

class QuattroLinkedList {
  FieldObject root = null;
  FieldObject lastAdded = null;
  FieldObject firstInRow = null;
  FieldObject nextPrint = null;
  FieldObject firstInRowPrint = null;
  List crateList = null;

  QuattroLinkedList() {
    crateList = new List();
  }

  /**
   * Adds a new Fieldobject in the actual row
   */
  addRight(FieldObject fieldObject) {
    if (root == null) {
      root = fieldObject;
      root.position.x = 0;
      root.position.y = 0;
      firstInRow = root;
    } else {
      fieldObject.leftPointer = lastAdded;
      lastAdded.rightPointer = fieldObject;

      //set position
      fieldObject.position.x = fieldObject.leftPointer.position.x + 1;
      fieldObject.position.y = fieldObject.leftPointer.position.y;
      if (fieldObject.leftPointer.upPointer != null &&
          fieldObject.leftPointer.upPointer.rightPointer != null) {
        fieldObject.upPointer = fieldObject.leftPointer.upPointer.rightPointer;
        fieldObject.leftPointer.upPointer.rightPointer.downPointer =
            fieldObject;
      } else {
        fieldObject.upPointer = null;
      }
    }
    lastAdded = fieldObject;
    return lastAdded;
  }

  /**
   * Adds a new Fieldobject at the first place in a new row
   */
  addDown(FieldObject fieldObject) {
    fieldObject.upPointer = firstInRow;
    firstInRow.downPointer = fieldObject;

    //set position
    fieldObject.position.x = fieldObject.upPointer.position.x;
    fieldObject.position.y = fieldObject.upPointer.position.y + 1;
    firstInRow = fieldObject;
    lastAdded = firstInRow;
  }
}
