class Statistics {
  static var _localMoves;       //moves this round, 0 after reset
  static var _globalMoves;      //moves this round total
  static var _localPushes;      //pushes this round, 0 after reset
  static var _globalPushes;     //pushes this round total
  DateTime _startTime;          //time when the user started the game, not used yet
  static var _roundTime;        //used time in this round
  static int _resets;           //number of resets
  static int _actualLevel;      //the actual level
  static Statistics _instance;  //an instance of the static Statistics
  static int _gloves;           //number of sticky gloves, used to pull a crate
  static int _usedGloves;       //number of used sticky gloves

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
    _usedGloves = 0;
    _gloves = 2;
  }


  //region GETTER

  /**
   * returns an instance of the statistics
   */
  static Statistics getInstance() {
    if(_instance == null){
      _instance = new Statistics();
    }
    return _instance;
  }

  /**
   * returns the number of resets
   */
  int getResets() {
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
   * returns the used time of the actual game since start or last reset
   */
  int getLocalTime() {
    return _localTime;
  }

  /*
   * returns the used time of the actual game since start
   */
  int getGlobalTime() {
    DateTime dt = new DateTime.now();
    Duration out = dt.difference(_startTime);
    int diff = out.inSeconds;
    return _roundTime + diff;
  }

  /**
   * returns the number of used gloves
   */
  int getUsedGloves() {
    return _usedGloves;
  }

  /**
   * returns the number of gloves
   */
  int getGloves() {
    return _gloves;
  }

  //endregion

  //region SETTER

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
   * sets the resets to the value res
   */
  setResets(int res) {
    _resets = res;
  }

  /**
   * sets the actual level
   */
  setCurrentLevel(int lvl) {
    _actualLevel = lvl;
  }

  /**
   * sets the number of gloves to the new value
   */
  setGloves(int val) {
    _gloves = val;
  }

  //endregion

  //region INC & DEC

  /**
   * Increments the resets
   */
  incResets() {
    _resets++;
  }

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
   * increments the number of gloves
   */
  incGloves() {
    _gloves++;
  }

  incUsedGloves() {
    _usedGloves++;
  }

  /**
   * decrements the number of gloves if possible and returns true. Returns false if not
   */
  bool decGloves() {
    if (_gloves > 0) {
      _gloves--;
      return true;
    } else {
      return false;
    }
  }

  //endregion

  //region RESET

  /**
   *  Resets all values
   */
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
    _resets = 0;
    _usedGloves = 0;
  }

  /**
   * sets the number of gloves to 0
   */
  resetGloves() {
    _gloves = 0;
  }

  //endregion

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
    _gloves = stats.remove("gloves");
    _usedGloves = stats.remove("usedGloves");
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
    7. resets
    8. actual level
    9. gloves
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
    out['gloves'] = _gloves;
    out['usedGloves'] = _usedGloves;
    //benoetigt keine roundTime
    return out;
  }
}