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

  addRight(FieldObject fieldObject) {
    if (root == null) {
      root = fieldObject;
      root.position.x = 0;
      root.position.y = 0;
      firstInRow = root;
    } else {
      fieldObject.leftPointer = lastAdded;
      lastAdded.rightPointer = fieldObject;

      //Position setzen
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

  // neues erstes Element in neuer Zeile
  addDown(FieldObject fieldObject) {
    fieldObject.upPointer = firstInRow;
    firstInRow.downPointer = fieldObject;

    //Position setzen
    fieldObject.position.x = fieldObject.upPointer.position.x;
    fieldObject.position.y = fieldObject.upPointer.position.y + 1;
    firstInRow = fieldObject;
    lastAdded = firstInRow;
  }
}
