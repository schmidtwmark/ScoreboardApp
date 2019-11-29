import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'channel.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class ScreenId {
  static const NHL = 0;
  static const MLB = 1;
  static const CLOCK = 99;
  static const REFRESH = 100;
  static const HOTSPOT = 101;
  static const WIFIDETAILS = 102;
  static const SYNC = 103;
}

class Screen {
  Screen(
      {this.id,
      this.name,
      this.subtitle,
      this.alwaysRotate,
      this.rotationTime,
      this.focusTeams});
  int id;
  String name;
  String subtitle;

  bool alwaysRotate;
  int rotationTime;
  List<int> focusTeams;

  factory Screen.fromJson(Map<String, dynamic> json) {
    return Screen(
        id: json["id"],
        name: json['name'],
        subtitle: json['subtitle'],
        alwaysRotate: json['always_rotate'],
        rotationTime: json['rotation_time'],
        focusTeams: new List<int>.from(json['focus_teams']));
  }

  bool operator ==(other) {
    return this.id == other.id &&
        this.name == other.name &&
        this.subtitle == other.subtitle &&
        this.alwaysRotate == other.alwaysRotate &&
        this.rotationTime == other.rotationTime &&
        listEquals(this.focusTeams, other.focusTeams);
  }

  Screen clone() {
    List<int> focus = [];
    for (int i in focusTeams) {
      focus.add(i);
    }
    return new Screen(
        alwaysRotate: alwaysRotate,
        id: id,
        name: name,
        rotationTime: rotationTime,
        subtitle: subtitle,
        focusTeams: focus);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = {};
    ret["id"] = id;
    ret["name"] = name;
    ret["subtitle"] = subtitle;
    ret["always_rotate"] = alwaysRotate;
    ret["rotation_time"] = rotationTime;
    ret["focus_teams"] = focusTeams;
    return ret;
  }

  IconData getIcon() {
    switch (id) {
      case ScreenId.NHL:
        return FontAwesomeIcons.hockeyPuck;
      case ScreenId.MLB:
        return FontAwesomeIcons.baseballBall;
      case ScreenId.CLOCK:
        return FontAwesomeIcons.clock;
      default:
        return FontAwesomeIcons.footballBall;
    }
  }
}

class ScoreboardSettings {
  static final int clientVersion = 0;

  int activeScreen;
  bool screenOn;
  List<Screen> screens;
  String name;
  int version;

  ScoreboardSettings(
      {this.activeScreen,
      this.screenOn,
      this.name,
      this.screens,
      this.version});

  factory ScoreboardSettings.fromJson(Map<String, dynamic> json) {
    List<Screen> screens = [];
    for (var screen in json["screens"]) {
      screens.add(Screen.fromJson(screen));
    }
    return ScoreboardSettings(
        activeScreen: json["active_screen"],
        screenOn: json["screen_on"],
        name: json["name"] ?? "My New Scoreboard",
        screens: screens,
        version: json["version"]);
  }

  ScoreboardSettings clone() {
    List<Screen> screensCopy = [];
    for (Screen s in screens) {
      screensCopy.add(s.clone());
    }
    return new ScoreboardSettings(
        activeScreen: activeScreen,
        screenOn: screenOn,
        name: name,
        version: version,
        screens: new List<Screen>.from(screensCopy));
  }

  bool operator ==(other) {
    return this.activeScreen == other.activeScreen &&
        this.screenOn == other.screenOn &&
        this.name == other.name &&
        listEquals(this.screens, other.screens);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = {};
    ret["active_screen"] = activeScreen;
    ret["screen_on"] = screenOn;
    ret["screens"] = [];
    ret["name"] = name;
    ret["version"] = version;
    for (Screen s in screens) {
      ret["screens"].add(s.toJson());
    }
    return ret;
  }
}

enum SetupState {
  FACTORY,
  HOTSPOT,
  WIFI_CONNECT,
  SYNC,
  READY,
}

class AppState {
  List<String> scoreboardAddresses;
  List<SetupState> scoreboardSetupStates;
  List<String> scoreboardNames;
  int activeIndex;

  static const String ADDRESS_KEY = "addresses";
  static const String SETUP_STATE_KEY = "setup_states";
  static const String LAST_INDEX_KEY = "last_index";
  static const String NAMES_KEY = "names";

  static AppState _singleton;

  AppState._internal();
  AppState._default() {
    scoreboardAddresses = [""];
    scoreboardNames = ["My Scoreboard"];
    scoreboardSetupStates = [SetupState.FACTORY];
    activeIndex = 0;
  }

  static void resetState(AppState state) {
    state.scoreboardAddresses = [""];
    state.scoreboardNames = ["My Scoreboard"];
    state.scoreboardSetupStates = [SetupState.FACTORY];
    state.activeIndex = 0;
  }

  static Future<AppState> load() async {
    if (_singleton != null) {
      return _singleton;
    } else {
      _singleton = AppState._internal();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        _singleton.scoreboardAddresses = prefs.getStringList(ADDRESS_KEY);
        _singleton.scoreboardSetupStates = prefs
            .getStringList(SETUP_STATE_KEY)
            .map((s) => SetupState.values[int.parse(s)])
            .toList();
        _singleton.scoreboardNames = prefs.getStringList(NAMES_KEY);
        _singleton.activeIndex = prefs.getInt(LAST_INDEX_KEY);
        if (_singleton.scoreboardAddresses.length !=
                _singleton.scoreboardSetupStates.length ||
            _singleton.scoreboardNames.length !=
                _singleton.scoreboardAddresses.length) {
          throw Exception("Invalid addresses, setup states, or names");
        } else if (_singleton.activeIndex >=
                _singleton.scoreboardAddresses.length ||
            _singleton.activeIndex < 0) {
          throw Exception("Invalid last index");
        }
        return _singleton;
      } catch (e) {
        //invalid string lists, set everything to basic values and return. This is an OK state if nothing has been done
        _singleton = AppState._internal();
        resetState(_singleton);

        return _singleton;
      }
    }
  }

  static Future store() async {
    if (_singleton == null) {
      throw Exception("Cannot store null AppState");
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(ADDRESS_KEY, _singleton.scoreboardAddresses);
      prefs.setStringList(
          SETUP_STATE_KEY,
          _singleton.scoreboardSetupStates
              .map((state) => state.index.toString())
              .toList());
      prefs.setStringList(NAMES_KEY, _singleton.scoreboardNames);
      prefs.setInt(LAST_INDEX_KEY, _singleton.activeIndex);
    }
  }

  static Future setState(SetupState state) async {
    AppState app = await AppState.load();
    app.scoreboardSetupStates[app.activeIndex] = state;
    await AppState.store();
  }

  static Future setName(String name) async {
    AppState app = await AppState.load();
    app.scoreboardNames[app.activeIndex] = name;
    await AppState.store();
  }

  static Future setAddress(String address) async {
    AppState app = await AppState.load();
    app.scoreboardAddresses[app.activeIndex] = address;
    await AppState.store();
  }

  static Future setActive(int index) async {
    AppState app = await AppState.load();
    app.activeIndex = index;
    await AppState.store();
  }

  static Future addScoreboard() async {
    AppState app = await AppState.load();
    bool foundMyScoreboard = false;
    String name = "My Scoreboard";
    for (String name in app.scoreboardNames) {
      if (name.startsWith("My Scoreboard")) {
        foundMyScoreboard = true;
        break;
      }
    }
    if (foundMyScoreboard) {
      //Find the highest numbered one
      int number = 1;
      for (String name in app.scoreboardNames) {
        RegExp exp = new RegExp(r"^My Scoreboard\s([0-9]+)");
        List<Match> matches = exp.allMatches(name).toList();
        if (matches.length > 0) {
          Match m = matches[0];
          if (m.groupCount == 1 && m.group(1) != null) {
            int candidate = int.tryParse(m.group(1));
            if (candidate != null && candidate > number) {
              number = candidate;
            }
          }
        }
      }
      name = "My Scoreboard ${number + 1}";
    }

    app.scoreboardAddresses.add("");
    app.scoreboardNames.add(name);
    app.scoreboardSetupStates.add(SetupState.FACTORY);
    app.activeIndex = app.scoreboardNames.length - 1;
    await AppState.store();
  }

  static Future removeScoreboard({int index}) async {
    AppState app = await AppState.load();
    if (index == null) {
      index = app.activeIndex;
    }
    app.scoreboardAddresses.removeAt(index);
    app.scoreboardNames.removeAt(index);
    app.scoreboardSetupStates.removeAt(index);
    app.activeIndex = 0;

    if (app.scoreboardAddresses.length == 0) {
      //Add a new default scoreboard so we don't crash
      resetState(app);
    }
    await AppState.store();
  }

  static Future<Channel> getChannel() async {
    AppState app = await AppState.load();
    return Channel(ipAddress: app.scoreboardAddresses[app.activeIndex]);
  }
}

String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

String ipFromCode(String code) {
  String out = "";
  RegExp regex = RegExp("..");
  for (RegExpMatch match in regex.allMatches(code)) {
    String matched = match.group(0);
    int mod = alphabet.indexOf(matched[0]);
    int rem = alphabet.indexOf(matched[1]);
    int octet = alphabet.length * mod + rem;
    out += octet.toString() + ".";
  }
  return out.substring(0, out.length - 1);
}

bool isValidIpCode(String candidate) {
  RegExp regex = RegExp("[A-Z][A-Z][A-Z][A-Z][A-Z][A-Z][A-Z][A-Z]");
  return regex.hasMatch(candidate);
}
