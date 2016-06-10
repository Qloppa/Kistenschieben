import 'dart:html';

class KistenschiebenView {

  //Bildelemente
  String crate = "<img src=\"../web/pictures/crate.png\">";
  String player = "<img src=\"../web/pictures/player.png\">";
  String wall = "<img src=\"../web/pictures/wall.png\">";
  String win = "<img src=\"../web/pictures/win.gif\" height=\" 200px\" width=\" 200px\">";

  int tableH;
  int tableW;
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
  logedinScreen() {
    querySelector('#logedin').innerHtml =
    "<div id=\"overlay\">"
        "<div id=\"b3\">"
        "<button id=\"newgame\">New Game</button>"
        "</div>"
        "<div id=\"b6\">"
        "<button id=\"edituser\">Edit User</button>"
        "</div>"
        "<div id=\"b4\">"
        "<button id=\"about\">About</button>"
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
        "<button id=\"changename\">Change Name</button>"
        "</div>"
        "<div id=\"b8\">"
        "<button id=\"changepassword\">Change Password</button>"
        "</div>"
        "<div id=\"b9\">"
        "<button id=\"delete\">Delete User</button>"
        "</div>"
        "<div id=\"b10\">"
        "<button id=\"getuser\">Get Username</button>"
        "</div>"
        "<div id=\"b11\">"
        "<button id=\"getuserid\">Get UserId</button>"
        "</div>"
        "</div>";

    // Future<bool> changeUserName(String oldName, String pwd,String newName)
    // Future<bool> changeUserPassword(String name, String oldPW,String newPW)
    //Future<bool> deleteUser(String name, String pwd)
    //Future<Map> getUser(String id, String pwd)
    //Future<String> getUserId(String name)
    //Future<List<Map>> listUsers()
    //Future<List<Map>> getStates()
    //Future<bool> storeState(String uid, Map state)

  }

  void scaling() {
    Window w = window;
    int resoWidth = w.screen.width - 200;
    int resoHeight = w.screen.height - 200;
    print(resoWidth.toString());
    print(resoHeight.toString());
    String oS;

    int px;
    if (tableH > tableW) {
      double size = resoWidth / tableW;
      px = size.toInt();
      print("Groesse: " + px.toString());
    } else {
      double size = resoHeight / tableH;
      px = size.toInt();
      print("Groesse: " + px.toString());
    }
    oS = px.toString() + "px";
    //String strH = resoHeight.toString() + "px";
    //String strW = resoWidth.toString() + "px";
    //querySelector("table").style.height = strH;
    //querySelector("table").style.width = strW;
    querySelectorAll("lvl").style.height = "100%";
    querySelectorAll("lvl").style.width = "100%";
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
    Generates the win-overlay and the button to access the next level
   */
  void showWin() {
    querySelector("#container").innerHtml =
    "<div id=\"overlay\"><button id=\"next\">Next Level</button></div>";
  }

  /*
  Creates the level in html from a String
  */
  String generateLevelFromString(String level, int row, int column) {
    this.tableH = row;
    this.tableW = column;
    scaling();
    level = level.toUpperCase();

    String type = "";
    String initObj = "";

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
    return formatlevel;
  }

  /*
    appends the generated Field in Dom-tree
  */
  loadLvl(String lvl, int row, int column) async {
    String level = generateLevelFromString(lvl, column, row);
    querySelector("level").innerHtml = level;
    scaling();

  }


  String touchListener() {
    querySelectorAll("td").onMouseDown.listen((MouseEvent ev) {
      String id = (ev.target as HtmlElement).id;
      if (id == "") {
        id = (ev.target as HtmlElement).parent.id;
      }
      return id;
    });
  }

  /*
  Gets the Name from UserInput
  */
  String get username =>
      (document.querySelector('#username') as InputElement).value;

  /*
  Gets the Password from UserInput
  */
  String get userpassword =>
      (document.querySelector('#userpassword') as InputElement).value;

  /*
  Updates the position of the player and the crates
  Receives old and new positions as Strings and updates the html
  */
  void updateView(String playerPosition_old,
      String playerPosition_new, List<String>cratePosition_new) {
    querySelector(playerPosition_old).innerHtml = "";
    querySelector(playerPosition_new).innerHtml = player;

    querySelectorAll("td").remove(crate);
    int dummy = 0;
    do {
      querySelector(cratePosition_new.removeLast()).innerHtml = crate;
    } while (dummy < cratePosition_new.length);
    scaling();
  }
}
