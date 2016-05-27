class Statistics {
  var localMoves;
  var globalMoves;
  var localPushes;
  var globalPushes;
  DateTime startTime;
  var localTime;
  var globalTime;

  Statistics() {
    this.localMoves = 0;
    this.globalMoves = 0;
    this.localPushes = 0;
    this.globalPushes = 0;
    this.localTime = 0;
    this.globalTime = 0;
  }

  int getLocalMoves() {
    return this.localMoves;
  }

  int getGlobalMoves() {
    return this.globalMoves;
  }

  int getLocalPushes() {
    return this.localPushes;
  }

  int getGlobalPushes() {
    return this.globalPushes;
  }

  int getLocalTime() {
    return this.localTime;
  }

  int getGlobalTime() {
    return this.globalTime;
  }

  resetAll() {
    this.localMoves = 0;
    this.globalMoves = 0;
    this.localPushes = 0;
    this.globalPushes = 0;
    this.localTime = 0;
    this.globalTime = 0;
    this.startTime = new DateTime.now(); //Aendern
  }

  resetLocal() {
    this.localMoves = 0;
    this.localPushes = 0;
    this.localTime = 0;
  }

  resetGlobal() {
    this.globalMoves = 0;
    this.globalPushes = 0;
    this.globalTime = 0;
  }

  incPushes() {
    this.localPushes++;
    this.globalPushes++;
  }

  incMoves() {
    this.localMoves++;
    this.globalMoves++;
  }
}


