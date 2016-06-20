import 'dart:async';
import 'dart:html';

/**
 * The View of Kistenschieben. Is used to display the game
 */
class KistenschiebenView {

  List<List<HtmlElement>> field;

  //Bildelemente
  String crate = "<img src=\"../web/pictures/crate.png\">";
  String player = "<img src=\"../web/pictures/player.png\">";
  String wall = "<img src=\"../web/pictures/wall.png\">";
  String about = "<img src=\"../web/pictures/Anleitung_1.png\" height=\"80%\" width=\"100%\" >";

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
  startScreen() {
    querySelector('#start').innerHtml =
    "<div id=\"overlay\">"
        "<div>"
        "<button id=\"registerbutton\">Register</button>"
        "</div>"
        "<div>"
        "<button id=\"loginbutton\">Login</button>"
        "</div>"
        "<div>"
        "<button id=\"wOLogin\">Play without login</button>"
        "</div>"
        "<div>"
        "<button id=\"about\">About</button>"
        "</div>"
        "</div>";
  }

  /*
  Generates the Inputelements
  */
  userdates() {
    querySelector('#userinput').innerHtml =
    "<div id =\"overlay\" >"
        "<form id=\"inputdates\">"
        "<input type=\"text\" id=\"username\" placeholder=\"Username\">"
        "<input type=\"password\" id=\"userpassword\" placeholder=\"Password\">"
        "<button type =\"button\" id=\"submit\">Submit</button>"
        "<button type =\"button\" id=\"back\">Back</button>"
        "</form>"
        "</div>";
  }

  /*
  Generates the buttons to access the Game
  */
  registeredScreen() async {
    querySelector('#registered').innerHtml =
    "<div id=\"overlay\">"
        "<div>"
        "<button id=\"newgame\">New Game</button>"
        "</div>"
        "<div>"
        "<button id=\"edituserbutton\">Edit User</button>"
        "</div>"
        "<div>"
        "<button id=\"ab\">About</button>"
        "</div>"
        "</div>";
  }

  /*
  Generates the button to edit the user data
  */
  editUser() {
    querySelector('#edituser').innerHtml =
    "<div id=\"overlay\">"
        "<div>"
        "<button id=\"changename\">Change Name</button>"
        "</div>"
        "<div>"
        "<button id=\"changepassword\">Change Password</button>"
        "</div>"
        "<div>"
        "<button id=\"delete\">Delete User</button>"
        "</div>"
        "<div>"
        "<button id=\"back\">Back</button>"
        "</div>"
        "</div>";

    //Future<List<Map>> listUsers()
    //Future<List<Map>> getStates()
    //Future<bool> storeState(String uid, Map state)

  }

  /**
   * Shows the options to change the username
   */
  changeUserName() {
    querySelector('#userinput').innerHtml =
    "<div id =\"overlay\" >"
        "<form id=\"inputdates\">"
        "<input type=\"text\" id=\"oldusername\" placeholder=\"old Username\">"
        "<input type=\"password\" id=\"userpassword\" placeholder=\"Password\">"
        "<input type=\"text\" id=\"username\" placeholder=\"new Username\">"
        "<button type =\"button\" id=\"submit\">Submit</button>"
        "<button type =\"button\" id=\"back\">Back</button>"
        "</form>"
        "</div>";
  }

  /**
   * Shows the options to change the password
   */
  changeUserPassword() {
    querySelector('#userinput').innerHtml =
    "<div id =\"overlay\" >"
        "<form id=\"inputdates\">"
        "<input type=\"text\" id=\"username\" placeholder=\"Username\">"
        "<input type=\"password\" id=\"olduserpassword\" placeholder=\"old Password\">"
        "<input type=\"password\" id=\"userpassword\" placeholder=\"new Password\">"
        "<button type =\"button\" id=\"submit\">Submit</button>"
        "<button type =\"button\" id=\"back\">Back</button>"
        "</form>"
        "</div>";
  }

  /**
   * Shows the options if the user selects "get User"
   */
  getUser() {
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

  /**
   * Shows the options to get the User-ID by entering the Username
   */
  getUserId() {
    querySelector('#userinput').innerHtml =
    "<div id =\"overlay\" >"
        "<form id=\"inputdates\">"
        "<input type=\"text\" id=\"username\" placeholder=\"Username\">"
        "<button type =\"button\" id=\"submit\">Submit</button>"
        "<button type =\"button\" id=\"back\">Back</button>"
        "</form>"
        "</div>";
  }

  /**
   * When the user selects "about"
   */
  getAbout() {
    querySelector("#about").innerHtml =
    "<div id=\"overlay\">" "$about" "<div><button type =\"button\" id=\"back\">Back</button></div>" "</div>";
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
  String get oldUsername =>
      (document.querySelector('#oldusername') as InputElement).value;

  /**
   * gets the user's old password from userinput
   */
  String get oldUserpassword =>
      (document.querySelector('#olduserpassword') as InputElement).value;

  /**
   * is used for scaling the gamefield.
   */


  void scaling() {
    double scalingoprocent = 0.0;
    if (tableH >= tableW) {
      scalingoprocent = tableW.toDouble();
      print("on TableW" "$scalingoprocent");
    } else {
      print(scalingoprocent);
      scalingoprocent = tableH.toDouble();
      print("on TableH" "$scalingoprocent");
    }
    scalingoprocent = (-7 / 3) * scalingoprocent + (105 / 3);
    int scalingout = scalingoprocent.toInt();
    querySelector("table").style.zoom = "$scalingout" "%";
    //querySelector("table").style.zoom = "7%";
  }


  /*
  Changes the status of the Gamekey to "Verbunden" in green if true or "nicht verbunden" in red if false
  */
  setGameKeyAvailable(bool value) {
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
  showWin(var highscores) async {
    final list = highscores.map((s) => "<dd>User ${s['name']}:"
        " Level: ${s['level']},"
        "Localpushes: ${s['LocalPushes']},"
        "GlobalPushespushes: ${s['GlobalPushes']},"
        "LocalMoves: ${s['LocalMoves']},"
        "GlobalMoves: ${s['GlobalMoves']}</dd>").join("");
    String ret = "<div id=\"highscore\"><dt>$list</dt><div>";
    querySelector("#container").innerHtml =
    "<div id=\"winoverlay\"><div><div><button id=\"next\">Next Level</button>$ret<button id=\"save\">Save Statistics</button></div></div></div>";
    querySelector("#resetbutton").style.position = "absolute";
  }

  /*
   *Creates the level in html from a String
   */
  Future<String> generateLevelFromString(String level, int column,
      int row) async {
    //List<Map>levellist = new List<Map>();
    this.tableH = row;
    this.tableW = column;
    level = level.toUpperCase();
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
            formatlevel += "<td id=\"pos$i\_$j\" class=\"wall\" >$wall</td>";
            break;
          case 'G' :
            formatlevel += "<td id=\"pos$i\_$j\" class=\"ground\" ></td>";
            break;
          case 'P' :
            formatlevel +=
            "<td id=\"pos$i\_$j\" class=\"ground\">$player</td>";
            break;
          case 'C' :
            formatlevel +=
            "<td id=\"pos$i\_$j\" class=\"ground\">$crate</td>";
            break;
          case 'T' :
            formatlevel += "<td id=\"pos$i\_$j\" class=\"target\"></td>";
            break;
          case 'S' :
            formatlevel +=
            "<td id=\"pos$i\_$j\" class=\"target\">$crate</td>";
            break;
        }
      }
      formatlevel += "</tr>\n";
    }
    formatlevel = "<table><tbody>\n$formatlevel</tbody></table>";
    querySelector("level").innerHtml = formatlevel;
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
  void updateViewPush(String playerPosition_old, String playerPosition_new,
      List<String>cratePosition_new) {
    int pox = getPosition(playerPosition_old)[1];
    int poy = getPosition(playerPosition_old)[0];
    field[pox][poy].innerHtml = "";
    int pnx = getPosition(playerPosition_new)[1];
    int pny = getPosition(playerPosition_new)[0];
    field[pnx][pny].innerHtml = player;
    if (!cratePosition_new.isEmpty) {
      int dummy = 0;
      do {
        List<int> cratepos = getPosition(cratePosition_new.removeLast());
        int pcx = cratepos[1];
        int pcy = cratepos[0];
        field[pcx][pcy].innerHtml = crate;
      } while (dummy < cratePosition_new.length);
    }
    scaling();
  }


  /*
  Updates the position of the player and the crates
  Receives old and new positions as Strings and updates the html
  */
  void updateViewPull(String playerPosition_old, String playerPosition_new,
      List<String>cratePosition_old) {
    int pnx = getPosition(playerPosition_new)[1];
    int pny = getPosition(playerPosition_new)[0];
    field[pnx][pny].innerHtml = player; //set new position of player
    if (!cratePosition_old.isEmpty) {
      int dummy = 0;
      do {
        List<int> newCratePos = getPosition(playerPosition_old);
        int pcx = newCratePos[1];
        int pcy = newCratePos[0];
        field[pcx][pcy].innerHtml = crate; //crate on old playerposition

        List<int> oldCratePos = getPosition(cratePosition_old.removeLast());
        int ocx = oldCratePos[1];
        int ocy = oldCratePos[0];
        field[ocx][ocy].innerHtml = ""; //old crateposition to only ground
      } while (dummy < cratePosition_old.length);
    }
    scaling();
  }

  /**
   * used to update the stats
   */
  void updateStats(Map<String, int> stats, var actualLvl) {
    String localPushes = stats.remove("localPushes").toString();
    String globalPushes = stats.remove("globalPushes").toString();
    String localMoves = stats.remove("localMoves").toString();
    String globalMoves = stats.remove("globalMoves").toString();
    String resets = stats.remove("resets").toString();
    querySelector("#stat").innerHtml =
    "Level:<em>$actualLvl</em>&nbsp&nbsp&nbsp&nbsp" "Resets:<em>$resets</em>&nbsp&nbsp&nbsp&nbsp" "Local Pushes:<em>$localPushes</em>&nbsp&nbsp&nbsp&nbsp" "Global Pushes:<em>$globalPushes</em>&nbsp&nbsp&nbsp&nbsp" "Local Moves:<em>$localMoves</em>&nbsp&nbsp&nbsp&nbsp" "Global Moves:<em>$globalMoves</em>&nbsp&nbsp&nbsp&nbsp";
  }
}
