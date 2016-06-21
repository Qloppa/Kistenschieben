class Statistics {
  static var _localMoves;
  static var _globalMoves;
  static var _localPushes;
  static var _globalPushes;
  DateTime _startTime;
  static var _roundTime;
  static int _resets;
  static int _actualLevel;
  static Statistics _instance;

  //not used yet
  static var _localTime;
  static var _globalTime;

  /**
   * Constructor
   */
  Statistics() {
    _localMoves = 0;
    _globalMoves = 0;
    _localPushes = 0;
    _globalPushes = 0;
    _localTime = 0;
    _globalTime = 0;
    _startTime = new DateTime.now();
    _roundTime = 0;
    _resets = 0;
    _actualLevel = 0;
  }

  static Statistics getInstance() {
    if(_instance == null){
      _instance = new Statistics();
    }
    return _instance;
  }

  resetStatistics() {
    _localMoves = 0;
    _globalMoves = 0;
    _localPushes = 0;
    _globalPushes = 0;
    _localTime = 0;
    _globalTime = 0;
    _startTime = new DateTime.now();
    _roundTime = 0;
    _resets = 0;
    _actualLevel = 0;
  }

  /**
   * Sets the roundTime which is the used time in the last savegame
   */
  setRoundTime(int time){
    _roundTime = time;
  }

  /**
   * Sets the value of the total Moves used in this round
   */
  setGlobalMoves(int moves){
    _globalMoves = moves;
  }

  /**
   * Sets the value of the total Pushes used in this round
   */
  setGlobalPushes(int pushes){
    _globalPushes = pushes;
  }

  /**
   * Increments the resets
   */
  incResets(){
    _resets++;
  }

  /**
   * sets the resets to the value res
   */
  setResets(int res){
    _resets = res;
  }

  /**
   * returns the number of resets
   */
  int getResets(){
    return _resets;
  }


  /**
   * returns the local Moves
   */
  int getLocalMoves() {
    return _localMoves;
  }

  /**
   * returns the global Moves
   */
  int getGlobalMoves() {
    return _globalMoves;
  }

  /**
   * returns the local Pushes
   */
  int getLocalPushes() {
    return _localPushes;
  }

  /**
   * returns the global Pushes
   */
  int getGlobalPushes() {
    return _globalPushes;
  }

  /*
   *returns the used time of the actual game since start or last reset
   */
  int getLocalTime() {
    return _localTime;
  }

  /*
   *returns the used time of the actual game since start
   */
  int getGlobalTime() {
    DateTime dt = new DateTime.now();
    Duration out = dt.difference(_startTime);
    int diff = out.inSeconds;
    return _roundTime + diff;
  }

  /*
   *sets the statistics to the given values. Used when loading from a savegame
   */
  loadStats(Map<String, int> stats) {
    _actualLevel = stats.remove("actualLevel");
    _localMoves = stats.remove("localMoves");
    _globalMoves = stats.remove("globalMoves");
    _localPushes = stats.remove("localPushes");
    _globalPushes = stats.remove("globalPushes");
    _localTime = stats.remove("localTime");
    _globalTime = stats.remove("globalTime");
    _startTime = new DateTime.now();
    if (stats.containsKey("roundTime")) {
      _roundTime = stats.remove("roundTime");
    } else {
      _roundTime = 0;
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
    out['localMoves'] = _localMoves;
    out['globalMoves'] = _globalMoves;
    out['localPushes'] = _localPushes;
    out['globalPushes'] = _globalPushes;
    out['localTime'] = _localTime;
    out['globalTime'] = _globalTime;
    out['resets'] = _resets;
    out['actualLevel'] = _actualLevel;
    //benoetigt keine roundTime
    return out;
  }

  resetAll() {
    resetLocal();
    resetGlobal();
  }

  /*
  resets all "local" values, used if reset
   */
  resetLocal() {
    _localMoves = 0;
    _localPushes = 0;
    _localTime = 0;
  }

  /*
  resets all "global" values
   */
  resetGlobal() {
    _globalMoves = 0;
    _globalPushes = 0;
    _globalTime = 0;
  }

  /*
  Resets all values
   */
  /*
  resetAll() {
    resetLocal();
    resetGlobal();
  }

  /*
  resets all "local" values, used if reset
   */
  resetLocal() {
    _localMoves = 0;
    _localPushes = 0;
    _localTime = 0;
  }

  /*
  resets all "global" values
   */
  resetGlobal() {
    _globalMoves = 0;
    _globalPushes = 0;
    _globalTime = 0;
  }
*/
  /**
   * increments Pushes
   */
  incPushes() {
    _localPushes++;
    _globalPushes++;
  }

  /**
   * increments Moves
   */
  incMoves() {
    _localMoves++;
    _globalMoves++;
  }

  /**
   * sets the actual level
   */
  setActualLevel(int lvl){
    _actualLevel = lvl;
  }
}

