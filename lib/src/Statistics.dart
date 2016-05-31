class Statistics {
  var localMoves;
  var globalMoves;
  var localPushes;
  var globalPushes;
  DateTime startTime;

  //not used yet
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

  loadStats(int lm, int gm, int lp, int gp, int lt, int gt) {
    this.localMoves = lm;
    this.globalMoves = gm;
    this.localPushes = lp;
    this.globalPushes = gp;
    this.localTime = lt;
    this.globalTime = gt;
  }

  List<int> getStats() {
    List<int> output = new List(5);
    output[0] = localMoves;
    output[1] = globalMoves;
    output[2] = localPushes;
    output[3] = globalPushes;
    output[4] = localTime;
    output[5] = globalTime;
    return output;
  }

  resetAll() {
    resetLocal();
    resetGlobal();
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


