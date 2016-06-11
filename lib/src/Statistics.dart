class Statistics {
  var localMoves;
  var globalMoves;
  var localPushes;
  var globalPushes;
  DateTime startTime;
  var roundTime;
  int resets;

  //not used yet
  var localTime;
  var globalTime;

  /**
   * Constructor
   */
  Statistics() {
    this.localMoves = 0;
    this.globalMoves = 0;
    this.localPushes = 0;
    this.globalPushes = 0;
    this.localTime = 0;
    this.globalTime = 0;
    this.startTime = new DateTime.now();
    this.roundTime = 0;
    this.resets = 0;
  }

  /*
   *Sets the roundTime which is the used time in the last savegame
   */
  setRoundTime(int time){
    this.roundTime = time;
  }

  setGlobalMoves(int moves){
    this.globalMoves = moves;
  }

  setGlobalPushes(int pushes){
    this.globalPushes = pushes;
  }

  incResets(){
    this.resets++;
  }

  setResets(int res){
    this.resets = res;
  }

  int getResets(){
    return this.resets;
  }


  /**
   * returns the local Moves
   */
  int getLocalMoves() {
    return this.localMoves;
  }

  /**
   * returns the global Moves
   */
  int getGlobalMoves() {
    return this.globalMoves;
  }

  /**
   * returns the local Pushes
   */
  int getLocalPushes() {
    return this.localPushes;
  }

  /**
   * returns the global Pushes
   */
  int getGlobalPushes() {
    return this.globalPushes;
  }

  /*
   *returns the used time of the actual game since start or last reset
   */
  int getLocalTime() {
    return this.localTime;
  }

  /*
   *returns the used time of the actual game since start
   */
  int getGlobalTime() {
    DateTime dt = new DateTime.now();
    Duration out = dt.difference(startTime);
    int diff = out.inSeconds;
    return roundTime + diff;
  }

  /*
   *sets the statistics to the given values. Used when loading from a savegame
   */
  loadStats(Map<String, int> stats) {
    this.localMoves = stats.remove("localMoves");
    this.globalMoves = stats.remove("globalMoves");
    this.localPushes = stats.remove("localPushes");
    this.globalPushes = stats.remove("globalPushes");
    this.localTime = stats.remove("localTime");
    this.globalTime = stats.remove("globalTime");
    this.startTime = new DateTime.now();
    if (stats.containsKey("roundTime")) {
      this.roundTime = stats.remove("roundTime");
    } else {
      this.roundTime = 0;
    }
  }
  /*
    Returns a Map with all stats
    1. local moves
    2. global moves
    3. local pushes
    4. global pushes
    5. local time
    6. global time
   */
  Map<String, int> getStats() {
    Map<String, int> out = new Map();
    out['localMoves'] = localMoves;
    out['globalMoves'] = globalMoves;
    out['localPushes'] = localPushes;
    out['globalPushes'] = globalPushes;
    out['localTime'] = localTime;
    out['globalTime'] = globalTime;
    out['resets'] = resets;
    //benoetigt keine roundTime
    return out;
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