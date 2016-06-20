class Statistics {
  var _localMoves;
  var _globalMoves;
  var _localPushes;
  var _globalPushes;
  DateTime _startTime;
  var _roundTime;
  int _resets;
  int _actualLevel;

  //not used yet
  var _localTime;
  var _globalTime;

//region CONSTRUCTOR

  /**
   * Constructor
   */
  Statistics() {
    this._localMoves = 0;
    this._globalMoves = 0;
    this._localPushes = 0;
    this._globalPushes = 0;
    this._localTime = 0;
    this._globalTime = 0;
    this._startTime = new DateTime.now();
    this._roundTime = 0;
    this._resets = 0;
    this._actualLevel = 0;
  }

//endregion  

//region SETTER

  /**
   * Sets the roundTime which is the used time in the last savegame
   */
  setRoundTime(int time){
    this._roundTime = time;
  }

  /**
   * Sets the value of the total Moves used in this round
   */
  setGlobalMoves(int moves){
    this._globalMoves = moves;
  }

  /**
   * Sets the value of the total Pushes used in this round
   */
  setGlobalPushes(int pushes){
    this._globalPushes = pushes;
  }

  /**
   * sets the resets to the value res
   */
  setResets(int res){
    this._resets = res;
  }

  /*
   *sets the statistics to the given values. Used when loading from a savegame
   */
  loadStats(Map<String, int> stats) {
    this._actualLevel = stats.remove("actualLevel");
    this._localMoves = stats.remove("localMoves");
    this._globalMoves = stats.remove("globalMoves");
    this._localPushes = stats.remove("localPushes");
    this._globalPushes = stats.remove("globalPushes");
    this._localTime = stats.remove("localTime");
    this._globalTime = stats.remove("globalTime");
    this._startTime = new DateTime.now();
    if (stats.containsKey("roundTime")) {
      this._roundTime = stats.remove("roundTime");
    } else {
      this._roundTime = 0;
    }
  }

//endregion

//region GETTER

  /**
   * returns the number of resets
   */
  int getResets(){
    return this._resets;
  }


  /**
   * returns the local Moves
   */
  int getLocalMoves() {
    return this._localMoves;
  }

  /**
   * returns the global Moves
   */
  int getGlobalMoves() {
    return this._globalMoves;
  }

  /**
   * returns the local Pushes
   */
  int getLocalPushes() {
    return this._localPushes;
  }

  /**
   * returns the global Pushes
   */
  int getGlobalPushes() {
    return this._globalPushes;
  }

  /*
   *returns the used time of the actual game since start or last reset
   */
  int getLocalTime() {
    return this._localTime;
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

//endregion

//region RESETS

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
    this._localMoves = 0;
    this._localPushes = 0;
    this._localTime = 0;
  }

  /*
  resets all "global" values
   */
  resetGlobal() {
    this._globalMoves = 0;
    this._globalPushes = 0;
    this._globalTime = 0;
  }

//endregion

//region INCREMENTS

  /**
   * increments Pushes
   */
  incPushes() {
    this._localPushes++;
    this._globalPushes++;
  }

  /**
   * increments Moves
   */
  incMoves() {
    this._localMoves++;
    this._globalMoves++;
  }

  /**
   * Increments the resets
   */
  incResets(){
    this._resets++;
  }

//endregion

  /**
   * sets the actual level
   */
  setActualLevel(int lvl){
    _actualLevel = lvl;
  }
}

