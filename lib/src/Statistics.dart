class Statistics {
  var localMoves;
  var globalMoves;
  var localPushes;
  var globalPushes;
  DateTime startTime;
  var roundTime;

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
    this.startTime = new DateTime.now();
    this.roundTime = 0;
  }

  /*
  Sets the roundTime which is the used time in the last savegame
   */
  setRoundTime(int time){
    this.roundTime = time;
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

  /*
  returns the used time of the actual game since start or last reset
   */
  int getLocalTime() {
    return this.localTime;
  }

  /*
  returns the used time of the actual game since start
   */
  int getGlobalTime() {
    DateTime dt = new DateTime.now();
    Duration out = dt.difference(startTime);
    int diff = out.inSeconds;
    return roundTime + diff;
  }

  /*
  sets the statistics to the given values. Used when opening a savegame
   */
  loadStats(int lm, int gm, int lp, int gp, int lt, int gt, int rt) {
    this.localMoves = lm;
    this.globalMoves = gm;
    this.localPushes = lp;
    this.globalPushes = gp;
    this.localTime = lt;
    this.globalTime = gt;
    this.startTime = new DateTime.now();
    this.roundTime = rt;
  }

  /*
    liefert Statistiken als Liste nach folgendem Schema:
    1. local moves
    2. global moves
    3. local pushes
    4. global pushes
    5. local time
    6. global time
   */
  List<int> getStats() {
    List<int> output = new List(5);
    output[0] = localMoves;
    output[1] = globalMoves;
    output[2] = localPushes;
    output[3] = globalPushes;
    output[4] = localTime;
    output[5] = globalTime;
    //benoetigt keine roundTime
    return output;
  }

  /*
  Resets all values
   */
  resetAll() {
    resetLocal();
    resetGlobal();
  }

  /*
  resets all "local" values, used if reset
   */
  resetLocal() {
    this.localMoves = 0;
    this.localPushes = 0;
    this.localTime = 0;
  }

  /*
  resets all "global" values
   */
  resetGlobal() {
    this.globalMoves = 0;
    this.globalPushes = 0;
    this.globalTime = 0;
  }

  /*
  increments Pushes
   */
  incPushes() {
    this.localPushes++;
    this.globalPushes++;
  }

  /*
  increments Moves
   */
  incMoves() {
    this.localMoves++;
    this.globalMoves++;
  }
}