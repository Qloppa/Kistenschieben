import 'FieldObject.dart';

class QuattroLinkedList {
  FieldObject _root = null;
  FieldObject _lastAdded = null;
  FieldObject _firstInRow = null;

  QuattroLinkedList() {
  }

  /**
   * Adds a new Fieldobject in the actual row
   */
  FieldObject addRight(FieldObject fieldObject) {
    if (_root == null) {
      _root = fieldObject;
      _root.getPosition().setX(0);
      _root.getPosition().setY(0);
      _firstInRow = _root;
    } else {
      fieldObject.leftPointer = _lastAdded;
      _lastAdded.rightPointer = fieldObject;

      //set getPosition()
      fieldObject.getPosition().setX(
          fieldObject.leftPointer.getPosition().getX() + 1);
      fieldObject.getPosition().setY(
          fieldObject.leftPointer.getPosition().getY());
      if (fieldObject.leftPointer.upPointer != null &&
          fieldObject.leftPointer.upPointer.rightPointer != null) {
        fieldObject.upPointer = fieldObject.leftPointer.upPointer.rightPointer;
        fieldObject.leftPointer.upPointer.rightPointer.downPointer =
            fieldObject;
      } else {
        fieldObject.upPointer = null;
      }
    }
    _lastAdded = fieldObject;
    return _lastAdded;
  }

  /**
   * Adds a new Fieldobject at the first place in a new row
   */
  FieldObject addDown(FieldObject fieldObject) {
    fieldObject.upPointer = _firstInRow;
    _firstInRow.downPointer = fieldObject;

    //set getPosition()
    fieldObject.getPosition().setX(fieldObject.upPointer.getPosition().getX());
    fieldObject.getPosition().setY(
        fieldObject.upPointer.getPosition().getY() + 1);
    _firstInRow = fieldObject;
    _lastAdded = _firstInRow;
    return _lastAdded;
  }
}
