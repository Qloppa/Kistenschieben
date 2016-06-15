import 'FieldObject.dart';

/**
 * The Ground is a passable fieldobject in the game and can have a crate or the player on it
 */
class Ground extends FieldObject {

  /**
   * Constructor
   */
  Ground() : super() {
    this.passable = true;
    this.isTarget = false;
    this.isWall = false;
  }
}