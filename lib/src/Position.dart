/**
 * The position of a fieldObject. Contains the values x and y
 */
class Position {
  int x;
  int y;

  /**
   * Constructor
   */
  Position(x, y) {
    this.x = x;
    this.y = y;
  }

  /**
   * returns the x-value
   */
  int getX() {
    return this.x;
  }

  /**
   * returns the y-value
   */
  int getY() {
    return this.y;
  }
}
