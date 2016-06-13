import 'dart:html';
import 'dart:async';

/**
 * The View of Kistenschieben. Is used to display the game
 */
class KistenschiebenView {

  List<List<HtmlElement>> field;

  //Bildelemente
  String crate = "<img src=\"../web/pictures/crate.png\">";
  String player = "<img src=\"../web/pictures/player.png\">";
  String wall = "<img src=\"../web/pictures/wall.png\">";
  String win = "<img src=\"../web/pictures/win.gif\" height=\" 200px\" width=\" 200px\">";
  String about = "<img src=\"../web/pictures/win.png\">";

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
        "<div id=\"b1\">"
        "  <button id=\"register\">Registrieren</button>"
        "</div>"
        "<div id=\"b2\">"
        "<button id=\"login\">Anmelden</button>"
        "</div>"
        "<div id=\"b3\">"
        "<button id=\"wOLogin\">Ohne Anmeldung spielen</button>"
        "</div>"
        "<div id=\"b4\">"
        "<button id=\"about\">Anleitung</button>"
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
        "<input type=\"text\" id=\"username\" placeholder=\"username\">"
        "<input type=\"password\" id=\"userpassword\" placeholder=\"Password\">"
        "<button type =\"button\" id=\"submit\">submit</button>"
        "<button type =\"button\" id=\"close\">Close</button>"
        "</form>"
        "</div>";
  }

  /*
  Generates the buttons to access the Game
  */
  registeredScreen() async {
    querySelector('#registered').innerHtml =
    "<div id=\"overlay\">"
        "<div id=\"b3\">"
        "<button id=\"newgame\">New Game</button>"
        "</div>"
        "<div id=\"b6\">"
        "<button id=\"edituserbutton\">Edit User</button>"
        "</div>"
        "<div id=\"b4\">"
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
        "<div id=\"b7\">"
        "<button id=\"getuser\">Get Username</button>"
        "</div>"
        "<div id=\"b8\">"
        "<button id=\"getuserid\">Get UserId</button>"
        "</div>"
        "<div id=\"b9\">"
        "<button id=\"changename\">Change Name</button>"
        "</div>"
        "<div id=\"b10\">"
        "<button id=\"changepassword\">Change Password</button>"
        "</div>"
        "<div id=\"b11\">"
        "<button id=\"delete\">Delete User</button>"
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
        "<button type =\"button\" id=\"submit\">submit</button>"
        "<button type =\"button\" id=\"close\">Close</button>"
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
        "<button type =\"button\" id=\"submit\">submit</button>"
        "<button type =\"button\" id=\"close\">Close</button>"
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
        "<input type=\"text\" id=\"userid\" placeholder=\"userID\">"
        "<input type=\"password\" id=\"userpassword\" placeholder=\"Password\">"
        "<button type =\"button\" id=\"submit\">submit</button>"
        "<button type =\"button\" id=\"close\">Close</button>"
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
        "<input type=\"text\" id=\"username\" placeholder=\"username\">"
        "<button type =\"button\" id=\"submit\">submit</button>"
        "<button type =\"button\" id=\"close\">Close</button>"
        "</form>"
        "</div>";
  }

  /**
   * When the user selects "about"
   */
  getAbout() {
    querySelector("#about").innerHtml =
    "<div id=\"overlay\">" "$win" "<div><button type =\"button\" id=\"close\">Close</button></div>" "</div>";
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
   * is used for scaling the gamefield. Uses the resolution of the Browser
   */
  void scaling() {
    Window w = window;
    int resoWidth = w.innerWidth - 200;
    int resoHeight = w.innerHeight - 200;
    String oS;
    bool hoch = tableH > tableW;
    int px;
    print(hoch.toString());
    if (resoWidth > resoHeight) {
      if (hoch) {
        double size = resoHeight / tableH;
        px = size.toInt();
      } else {
        double size = resoHeight / tableW;
        px = size.toInt();
      }
    } else {
      if (hoch) {
        double size = resoWidth / tableH;
        px = size.toInt();
      } else {
        double size = resoWidth / tableW;
        px = size.toInt();
      }
    }
    oS = px.toString() + "px";
    querySelectorAll("#lvl").style.height = "100%";
    querySelectorAll("#lvl").style.width = "100%";
    querySelectorAll(".target").style.height = oS;
    querySelectorAll(".target").style.width = oS;
    querySelectorAll(".ground").style.height = oS;
    querySelectorAll(".ground").style.width = oS;
    querySelectorAll(".wall").style.height = oS;
    querySelectorAll(".wall").style.width = oS;
    querySelectorAll("img").style.height = oS;
    querySelectorAll("img").style.width = oS;
  }

  /*
  Changes the status of the Gamekey to "Verbunden" in green if true or "nicht verbunden" in red if false
  */
  setGameKeyAvailable(bool value) {
    if (value == true) {
      querySelector("#gamekeystatus").style.color = "green";
      querySelector("#gamekeystatus").innerHtml = "Gamekeystatus: Verbunden";
    } else {
      querySelector("#gamekeystatus").style.color = "red";
      querySelector("#gamekeystatus").innerHtml =
      "Gamekeystatus: nicht Verbunden";
    }
  }

  /*
   *Generates the win-overlay and the button to access the next level
   */
  void showWin() {
    querySelector("#container").innerHtml =
    "<div id=\"overlay\"><button id=\"next\">Next Level</button></div>";
    /* querySelector("#reset").style.position = "absolute";
			    querySelector("#reset").style.top = "75%";
			    querySelector("#reset").style.right = "50%";
			    querySelector("#left").style.left = "50";
			    querySelector("#resetbutton").style.background = "url(pictures/win.gif)";*/
  }

  /*
   *Creates the level in html from a String
   */
  Future<String> generateLevelFromString(String level, int column,
      int row) async {
    this.tableH = row;
    this.tableW = column;
    scaling();
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
    formatlevel = "<table>\n$formatlevel</table>";
    querySelector("level").innerHtml = formatlevel;
    field = new List<List<HtmlElement>>(row);
    for (int rows = 0; rows < row; rows++) {
      field[rows] = [];
      for (int col = 0; col < column; col++) {
        field[rows].add(querySelector("#pos${col}_${rows}"));
      }
    }
    scaling();
    return formatlevel;
  }

  /**
   *  makes the gamefield clickable
   */
  String touchListener() {
    querySelectorAll("td").onMouseDown.listen((MouseEvent ev) {
      String id = (ev.target as HtmlElement).id;
      if (id == "") {
        id = (ev.target as HtmlElement).parent.id;
      }
      return id;
    });
    return "";
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
  void updateView(String playerPosition_old, String playerPosition_new,
      List<String>cratePosition_new) {
    int pox = getPosition(playerPosition_old)[1];
    int poy = getPosition(playerPosition_old)[0];
    print(pox);
    print(poy);
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

  /**
   * used to update the stats
   */
  void updateStats(Map<String, int> stats, var actualLvl) {
    String localPushes = stats.remove("localPushes").toString();
    String globalPushes = stats.remove("globalPushes").toString();
    String localMoves = stats.remove("localMoves").toString();
    String globalMoves = stats.remove("globalMoves").toString();
    String resets = stats.remove("resets").toString();
    String time = "0"; //stats.remove("time").toString();
    //String level = actualLvl;
    querySelector("stat").innerHtml =
    "Level:<em>$actualLvl</em>&nbsp&nbsp&nbsp&nbsp" "Resets:<em>$resets</em>&nbsp&nbsp&nbsp&nbsp" "Local Pushes:<em>$localPushes</em>&nbsp&nbsp&nbsp&nbsp" "Global Pushes:<em>$globalPushes</em>&nbsp&nbsp&nbsp&nbsp" "Local Moves:<em>$localMoves</em>&nbsp&nbsp&nbsp&nbsp" "Global Moves:<em>$globalMoves</em>&nbsp&nbsp&nbsp&nbsp" "Time:<em>$time</em>&nbsp&nbsp&nbsp&nbsp"; //TODO cool ein String :) funktioniert das auch mit berechneten Werten?
  }
}