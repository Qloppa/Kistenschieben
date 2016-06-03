import 'FieldObject.dart';
import 'Wall.dart';

class QuattroLinkedList {
  FieldObject root;
  FieldObject lastAdded;
  FieldObject firstInRow;
  FieldObject nextPrint;
  FieldObject firstInRowPrint;
  List crateList = null;

  QuattroLinkedList() {
    root = new Wall(); // jetzt schon notwendig?
    root.position.x = 0;
    root.position.y = 0;
    root.upPointer = null;
    root.rightPointer = null;
    root.downPointer = null;
    root.leftPointer = null;
    lastAdded = root;
    firstInRow = root;
    nextPrint = root;
    firstInRowPrint = root;
  }

  addRight(FieldObject fieldObject) {
    fieldObject.leftPointer = lastAdded;
    lastAdded.rightPointer = fieldObject;

    //Position setzen
    fieldObject.position.x = fieldObject.leftPointer.position.x + 1;
    fieldObject.position.y = fieldObject.leftPointer.position.y;
    if (fieldObject.leftPointer.upPointer != null &&
        fieldObject.leftPointer.upPointer.rightPointer != null) {
      fieldObject.upPointer = fieldObject.leftPointer.upPointer.rightPointer;
      fieldObject.leftPointer.upPointer.rightPointer.downPointer = fieldObject;
    } else {
      fieldObject.upPointer = null;
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

  searchRight() {
    if (nextPrint.rightPointer != null) {
      if (nextPrint.crate != null) {
        crateList.add(nextPrint.crate.getPositionAsString());
      }
      nextPrint = nextPrint.rightPointer;
    }
  }

  searchDown() {
    if (firstInRowPrint.downPointer != null) {
      if (firstInRowPrint.crate != null) {
        crateList.add(nextPrint.crate.getPositionAsString());
      }
      firstInRowPrint = firstInRowPrint.downPointer;
    }
    nextPrint = firstInRowPrint;
  }

  createCrateList(m, n) {
    crateList = new List();
    nextPrint = root;
    firstInRowPrint = root;
    for (int i = 0; i < m; i++) {
      for (int j = 1; j < n; j++) {
        searchRight();
      }
      searchDown();
    }
    return crateList;
  }
}