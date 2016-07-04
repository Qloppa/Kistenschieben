import 'dart:async';
import 'dart:html';

/**
 * The View of Kistenschieben. Is used to display the game
 */
class KistenschiebenView {

  List<List<HtmlElement>> field;

  int tableH = 0;
  int tableW = 0;

  /*
  Constructor
  */
  KistenschiebenView() {
    print("running view...");
  }

  /*
  Generetes the Overlay with Startbuttons
  */
  void startScreen() {
    querySelector('#start').innerHtml =
    "<div id=\"overlay\">"
        "<div>"
        "<button id=\"registerbutton\" class=\"option\">Register(1)</button>"
        "</div>"
        "<div>"
        "<button id=\"loginbutton\" class=\"option\">Login(2)</button>"
        "</div>"
        "<div>"
        "<button id=\"wOLogin\" class=\"option\">Play without login(3)</button>"
        "</div>"
        "<div>"
        "<button id=\"aboutbutton\" class=\"option\">About(4)</button>"
        "</div>"
        "</div>";
  }

  /*
  Generates the Inputelements
  */
  void userDates(String fromLayer) {
    querySelector('#userinput').innerHtml =
    "<div id =\"overlay\" >"
        "<form id=\"inputdates\">"
        "<input type=\"text\" id=\"username\" placeholder=\"Username\">"
        "<input type=\"password\" id=\"userpassword\" placeholder=\"Password\">"
        "<button type =\"button\" id=\"submit\">$fromLayer</button>"
        "<button type =\"button\" id=\"back\">Back</button>"
        "</form>"
        "</div>";
  }

  /*
  Generates the buttons to access the Game
  */
  Future registeredScreen() async {
    querySelector('#registered').innerHtml =
    "<div id=\"overlay\">"
        "<div>"
        "<button id=\"newgame\" class=\"option\">New Game(1)</button>"
        "</div>"
        "<div>"
        "<button id=\"edituserbutton\" class=\"option\">Edit User(2)</button>"
        "</div>"
        "<div>"
        "<button id=\"levelcodebutton\" class=\"option\">Enter Levelcode(3)</button>"
        "</div>"
        "<div>"
        "<button id=\"aboutbutton\" class=\"option\">About(4)</button>"
        "</div>"
        "</div>";
  }

  /*
  Generates the button to edit the user data
  */
  void editUser() {
    querySelector('#edituser').innerHtml =
    "<div id=\"overlay\">"
        "<div>"
        "<button id=\"changename\" class=\"option\">Change Name</button>"
        "</div>"
        "<div>"
        "<button id=\"changepassword\" class=\"option\">Change Password</button>"
        "</div>"
        "<div>"
        "<button id=\"delete\" class=\"option\">Delete User</button>"
        "</div>"
        "<div>"
        "<button id=\"back\" class=\"option\">Back</button>"
        "</div>"
        "</div>";

    //Future<List<Map>> listUsers()
    //Future<List<Map>> getStates()
    //Future<bool> storeState(String uid, Map state)

  }

  /**
   * Shows the options to change the username
   */
  void changeUserName() {
    querySelector('#userinput').innerHtml =
    "<div id =\"overlay\" >"
        "<form id=\"inputdates\">"
        "<input type=\"text\" id=\"oldusername\" placeholder=\"old Username\">"
        "<input type=\"password\" id=\"userpassword\" placeholder=\"Password\">"
        "<input type=\"text\" id=\"username\" placeholder=\"new Username\">"
        "<button type =\"button\" id=\"submit\">Change Name</button>"
        "<button type =\"button\" id=\"back\">Back</button>"
        "</form>"
        "</div>";
  }

  /**
   * Shows the options to change the password
   */
  void changeUserPassword() {
    querySelector('#userinput').innerHtml =
    "<div id =\"overlay\" >"
        "<form id=\"inputdates\">"
        "<input type=\"text\" id=\"username\" placeholder=\"Username\">"
        "<input type=\"password\" id=\"olduserpassword\" placeholder=\"old Password\">"
        "<input type=\"password\" id=\"userpassword\" placeholder=\"new Password\">"
        "<button type =\"button\" id=\"submit\">Change Password</button>"
        "<button type =\"button\" id=\"back\">Back</button>"
        "</form>"
        "</div>";
  }

  /*
  /**
   * Shows the options if the user selects "get User"
   */
  void getUser() {
    querySelector('#userinput').innerHtml =
    "<div id =\"overlay\" >"
        "<form id=\"inputdates\">"
        "<input type=\"text\" id=\"userid\" placeholder=\"UserID\">"
        "<input type=\"password\" id=\"userpassword\" placeholder=\"Password\">"
        "<button type =\"button\" id=\"submit\">Submit</button>"
        "<button type =\"button\" id=\"back\">Back</button>"
        "</form>"
        "</div>";
  }
  */

  /*
  /**
   * Shows the options to get the User-ID by entering the Username
   */
  void getUserId() {
    querySelector('#userinput').innerHtml =
    "<div id =\"overlay\" >"
        "<form id=\"inputdates\">"
        "<input type=\"text\" id=\"username\" placeholder=\"Username\">"
        "<button type =\"button\" id=\"submit\">Submit</button>"
        "<button type =\"button\" id=\"back\">Back</button>"
        "</form>"
        "</div>";
  }
  */

  void enterLvlCode() {
    querySelector('#userinput').innerHtml =
    "<div id =\"overlay\" >"
        "<form id=\"inputdates\">"
        "<input type=\"text\" id=\"levelCode\" placeholder=\"Enter Code\">"
        "<button type =\"button\" id=\"submit\">Submit</button>"
        "<button type =\"button\" id=\"back\">Back</button>"
        "</form>"
        "</div>";
  }

  /*
  Gets the Name from UserInput
  */
  String get username =>
      (document.querySelector('#username') as InputElement).value;

  /*
  Gets the userPassword from UserInput
  */
  String get userPassword =>
      (document.querySelector('#userpassword') as InputElement).value;

  /*
  Gets the "ID" from UserInput
  */
  String get userId =>
      (document.querySelector('#userid') as InputElement).value;

  /*
  Gets the "oldname" from UserInput
  */
  String get oldUserName =>
      (document.querySelector('#oldusername') as InputElement).value;

  /**
   * gets the user's old password from userinput
   */
  String get oldUserPassword =>
      (document.querySelector('#olduserpassword') as InputElement).value;

  /**
   * is used for scaling the gamefield.
   */

  String get lvlCode =>
      (document.querySelector('#levelCode') as InputElement).value;

  void getAbout() {
    querySelector("#about").innerHtml = "<about id=\"overlay\"><about>";
  }


  void scaling() {
    Window w = window;
    int resoWidth = w.innerWidth;
    int resoHeight = w.innerHeight - 200;
    String oS;
    bool hoch = tableH > tableW;
    int px;
    if (hoch) {
      double size = resoHeight / tableH;
      px = size.toInt();
    } else {
      double size = resoHeight / tableW;
      px = size.toInt();
    }
    oS = px.toString() + "px";
    querySelectorAll("td").style.height = oS;
    querySelectorAll("td").style.width = oS;
  }


  /*
  Changes the status of the Gamekey to "Verbunden" in green if true or "nicht verbunden" in red if false
  */
  void setGameKeyAvailable(bool value) {
    if (value == true) {
      querySelector("#gamekeystatus").style.color = "green";
      querySelector("#gamekeystatus").innerHtml = "Gamekeystatus: Connected";
    } else {
      querySelector("#gamekeystatus").style.color = "red";
      querySelector("#gamekeystatus").innerHtml =
      "Gamekeystatus: Not connected";
    }
  }

  /*
   *Generates the win-overlay and the button to access the next level
   */
  Future showWin(var highscores) async {
    String str = "<table border = 1; width=\"60%\">" +
        "<colgroup><col width=\"2*\"><col width=\"1*\"><col width=\"1*\"><col width=\"1*\"><col width=\"1*\"></colgroup>" +
        "<tr><th>Name</th><th>Pushes</th><th>Moves</th><th>Pushes Total</th><th>Moves Total</th></tr>";
    for (Map m in highscores) {
      String n = m['name'];
      int lp = m['LocalPushes'];
      int lm = m['LocalMoves'];
      int gp = m['GlobalPushes'];
      int gm = m['GlobalMoves'];
      str +=
      "<tr><td>$n</td><td>$lp</td><td>$lm</td><td>$gp</td><td>$gm</td></tr>";
    }
    str += "</table>";
    String ret = "<div id=\"highscore\"><dt>$str</dt><div>";
    querySelector("#container").innerHtml =
    "<div id=\"winoverlay\"><div><div><button id=\"next\">Next Level</button>$ret<button id=\"save\">Save Statistics</button></div></div></div>";
    querySelector("#resetbutton").style.position = "absolute";
  }

  setPullButton(int amount) {
    querySelector("#pullbutton").innerHtml = "pull gloves($amount)";
  }

  /*
   *Creates the level in html from a String
   */
  Future<String> generateLevelFromString(List<Map> levelList, int column,
      int row) async {
    this.tableH = row;
    this.tableW = column;
    List<Map>tempList = new List<Map>();
    tempList = levelList;
    String level = "";

    for (var map in tempList) {
      level += map["r"].toUpperCase();
    }
    print(level);
    String formatlevel = "";
    for (int j = 0; j < row; j++) {
      //Spalten
      formatlevel += "<tr>";
      for (int i = 0; i < column; i++) {
        //Zeilen
          String firstChar = level.substring(0, 1);
          level = level.substring(1);
          switch (firstChar) {
            case 'W' :
              formatlevel += "<td id=\"pos$i\_$j\" class=\"wall\" ></td>";
              break;
            case 'G' :
              formatlevel += "<td id=\"pos$i\_$j\" class=\"ground\" ></td>";
              break;
            case 'P' :
              formatlevel +=
              "<td id=\"pos$i\_$j\" class=\"player\"></td>";
              break;
            case 'C' :
              formatlevel +=
              "<td id=\"pos$i\_$j\" class=\"crate\"></td>";
              break;
            case 'T' :
              formatlevel += "<td id=\"pos$i\_$j\" class=\"target\"></td>";
              break;
            case 'S' :
              formatlevel +=
              "<td id=\"pos$i\_$j\" class=\"special\"></td>";
              break;
          }
      }
      formatlevel += "</tr>\n";
    }
    formatlevel = "<table><tbody>\n$formatlevel</tbody></table>";
    String objectlayer = formatlevel;
    String groundLayer = formatlevel;
    String groundlayer = groundLayer.replaceAll(
        "class=\"crate\"", "class=\"ground\"");
    groundlayer =
        groundlayer.replaceAll("class=\"player\"", "class=\"ground\"");
    groundlayer =
        groundlayer.replaceAll("class=\"special\"", "class=\"target\"");

    objectlayer = objectlayer.replaceAll("class=\"wall\"", "class=\"ground\"");
    objectlayer =
        objectlayer.replaceAll("class=\"target\"", "class=\"ground\"");
    objectlayer =
        objectlayer.replaceAll("class=\"special\"", "class=\"crate\"");

    querySelector("#groundlayer").innerHtml = groundlayer;
    querySelector("#objectlayer").innerHtml = objectlayer;
    field = new List<List<HtmlElement>>(row);
    for (int rows = 0; rows < row; rows++) {
      field[rows] = [];
      for (int col = 0; col < column; col++) {
        field[rows].add(querySelector("#pos${col}_${rows}"));
      }
    }

    await scaling();
    return formatlevel;
  }

  List<int> getPosition(String pos) {
    List<String> values = pos.split("_");
    List<int> positions = new List();
    positions.clear();
    positions.add(int.parse(values[0]));
    positions.add(int.parse(values[1]));
    return positions;
  }


  /*
  Updates the position of the player and the crates
  Receives old and new positions as Strings and updates the html
  */
  void updateViewPush(String playerPositionOld, String playerPositionNew,
      List<String>cratePositionNew) {
    int pox = getPosition(playerPositionOld)[1];
    int poy = getPosition(playerPositionOld)[0];
    field[pox][poy].className = "";
    int pnx = getPosition(playerPositionNew)[1];
    int pny = getPosition(playerPositionNew)[0];
    field[pnx][pny].className = "player";
    if (!cratePositionNew.isEmpty) {
      int dummy = 0;
      do {
        List<int> cratepos = getPosition(cratePositionNew.removeLast());
        int pcx = cratepos[1];
        int pcy = cratepos[0];
        field[pcx][pcy].className = "crate";
      } while (dummy < cratePositionNew.length);
    }
    scaling();
  }

/*
  /*
  Updates the position of the player and the crates
  Receives old and new positions as Strings and updates the html
  */
  void updateViewPull(String playerPositionOld, String playerPositionNew,
      List<String>cratePositionOld) {
    int pnx = getPosition(playerPositionNew)[1];
    int pny = getPosition(playerPositionNew)[0];
    field[pnx][pny].className = "player"; //set new position of player
    if (!cratePositionOld.isEmpty) {
      int dummy = 0;
      do {
        List<int> newCratePos = getPosition(playerPositionOld);
        int pcx = newCratePos[1];
        int pcy = newCratePos[0];
        field[pcx][pcy].className = "crate"; //crate on old playerposition

        List<int> oldCratePos = getPosition(cratePositionOld.removeLast());
        int ocx = oldCratePos[1];
        int ocy = oldCratePos[0];
        field[ocx][ocy].className = ""; //old crateposition to only ground
      } while (dummy < cratePositionOld.length);
    }
    scaling();
  }
  */

  /**
   * used to update the stats
   */
  void updateStats(Map<String, int> stats, var actualLvl) {
    String localPushes = stats.remove("localPushes").toString();
    String globalPushes = stats.remove("globalPushes").toString();
    String localMoves = stats.remove("localMoves").toString();
    String globalMoves = stats.remove("globalMoves").toString();
    String resets = stats.remove("resets").toString();
    String usedGloves = stats.remove("usedGloves").toString();
    String gloves = stats.remove("gloves").toString();
    querySelector("#stat").innerHtml =
    "Level:<em>$actualLvl</em>&nbsp&nbsp&nbsp&nbsp"
        "Resets:<em>$resets</em>&nbsp&nbsp&nbsp&nbsp"
        "Local Pushes:<em>$localPushes</em>&nbsp&nbsp&nbsp&nbsp"
        "Global Pushes:<em>$globalPushes</em>&nbsp&nbsp&nbsp&nbsp"
        "Local Moves:<em>$localMoves</em>&nbsp&nbsp&nbsp&nbsp"
        "Global Moves:<em>$globalMoves</em>&nbsp&nbsp&nbsp&nbsp"
        "Used Gloves: <em>$usedGloves</em>&nbsp&nbsp&nbsp&nbsp"
        "Left Gloves:<em>$gloves</em>&nbsp&nbsp&nbsp&nbsp ";

  /*ySelector("#stat").innerHtml = "<table border = 1; width=\"60%\">" +
        "<colgroup><col width=\"1*\"><col width=\"1*\"><col width=\"1*\"><col width=\"1*\"><col width=\"1*\"></colgroup>" +
        "<tr align = center><td>Level: $actualLvl</td><td>Pushes: $localPushes</td><td>Moves: $localMoves</td><td>Left Gloves: $usedGloves</td></tr>" +
        "<tr align = center><td>Resets: $resets</td><td>Pushes Total: $globalPushes</td><td>Moves Total: $globalMoves</td><td>Used Gloves: $gloves</tr>" +
        "</table>";*/
  }

  /**
   * Displays the Code for the actual level
   */
  void showLvlCode(String code) {
    querySelector("#header").innerHtml = code;
  }
}
