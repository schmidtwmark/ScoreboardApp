import 'package:flutter/widgets.dart';

class Team {
  final String city;
  final String name;
  final String abbreviation; 
  final Color primaryColor;
  final Color secondaryColor;

  Team(this.city, this.name, this.abbreviation, this.primaryColor, this.secondaryColor);

  static Map<int, Team> mlbTeams = {
    108 : Team("Los Angeles", "Angels", "LAA", Color.fromRGBO(186, 0, 33, 1.0), Color.fromRGBO(196, 206, 212, 1.0)),
    109 : Team("Arizona", "D-backs", "ARI", Color.fromRGBO(167, 25, 48, 1.0), Color.fromRGBO(227, 212, 173, 1.0)),
    110 : Team("Baltimore", "Orioles", "BAL", Color.fromRGBO(223, 70, 1, 1.0), Color.fromRGBO(39, 37, 31, 1.0)),
    111 : Team("Boston", "Red Sox", "BOS", Color.fromRGBO(198, 1, 31, 1.0), Color.fromRGBO(255, 255, 255, 1.0)),
    112 : Team("Cubs", "Cubs", "CHC", Color.fromRGBO(14, 51, 134, 1.0), Color.fromRGBO(204, 52, 51, 1.0)),
    113 : Team("Cincinnati", "Reds", "CIN", Color.fromRGBO(198, 1, 31, 1.0), Color.fromRGBO(0, 0, 0, 1.0)),
    114 : Team("Cleveland", "Indians", "CLE", Color.fromRGBO(227, 25, 55, 1.0), Color.fromRGBO(12, 35, 64, 1.0)),
    115 : Team("Colorado", "Rockies", "COL", Color.fromRGBO(51, 0, 111, 1.0), Color.fromRGBO(196, 206, 212, 1.0)),
    116 : Team("Detroit", "Tigers", "DET", Color.fromRGBO(12, 35, 64, 1.0), Color.fromRGBO(250, 70, 22, 1.0)),
    117 : Team("Houston", "Astros", "HOU", Color.fromRGBO(0, 45, 98, 1.0), Color.fromRGBO(244, 145, 30, 1.0)),
    118 : Team("Kansas", "Royals", "KC", Color.fromRGBO(0, 70, 135, 1.0), Color.fromRGBO(189, 155, 96, 1.0)),
    119 : Team("Los Angeles", "Dodgers", "LAD", Color.fromRGBO(0, 90, 156, 1.0), Color.fromRGBO(239, 62, 66, 1.0)),
    120 : Team("Washington", "Nationals", "WSH", Color.fromRGBO(171, 0, 3, 1.0), Color.fromRGBO(20, 34, 90, 1.0)),
    121 : Team("New York", "Mets", "NYM", Color.fromRGBO(0, 45, 114, 1.0), Color.fromRGBO(252, 89, 16, 1.0)),
    133 : Team("Oakland", "Athletics", "OAK", Color.fromRGBO(0, 56, 49, 1.0), Color.fromRGBO(239, 178, 30, 1.0)),
    134 : Team("Pittsburgh", "Pirates", "PIT", Color.fromRGBO(253, 184, 39, 1.0), Color.fromRGBO(39, 37, 31, 1.0)),
    135 : Team("San Diego", "Padres", "SD", Color.fromRGBO(0, 45, 98, 1.0), Color.fromRGBO(162, 170, 173, 1.0)),
    136 : Team("Seattle", "Mariners", "SEA", Color.fromRGBO(0, 92, 92, 1.0), Color.fromRGBO(196, 206, 212, 1.0)),
    137 : Team("San Francisco", "Giants", "SF", Color.fromRGBO(39, 37, 31, 1.0), Color.fromRGBO(253, 90, 30, 1.0)),
    138 : Team("St. Louis", "Cardinals", "STL", Color.fromRGBO(196, 30, 58, 1.0), Color.fromRGBO(12, 35, 64, 1.0)),
    139 : Team("Tampa Bay", "Rays", "TB", Color.fromRGBO(214, 90, 36, 1.0), Color.fromRGBO(255, 255, 255, 1.0)),
    140 : Team("Texas", "Rangers", "TEX", Color.fromRGBO(0, 50, 120, 1.0), Color.fromRGBO(192, 17, 31, 1.0)),
    141 : Team("Toronto", "Blue Jays", "TOR", Color.fromRGBO(19, 74, 142, 1.0), Color.fromRGBO(177, 179, 179, 1.0)),
    142 : Team("Minnesota", "Twins", "MIN", Color.fromRGBO(0, 43, 92, 1.0), Color.fromRGBO(211, 17, 69, 1.0)),
    143 : Team("Philadelphia", "Phillies", "PHI", Color.fromRGBO(232, 24, 40, 1.0), Color.fromRGBO(0, 45, 114, 1.0)),
    144 : Team("Atlanta", "Braves", "ATL", Color.fromRGBO(19, 39, 79, 1.0), Color.fromRGBO(206, 17, 65, 1.0)),
    145 : Team("Chicago", "White Sox", "CWS", Color.fromRGBO(39, 37, 31, 1.0), Color.fromRGBO(196, 206, 212, 1.0)),
    146 : Team("Miami", "Marlins", "MIA", Color.fromRGBO(0, 0, 0, 1.0), Color.fromRGBO(0, 163, 224, 1.0)),
    147 : Team("New York", "Yankees", "NYY", Color.fromRGBO(12, 35, 64, 1.0), Color.fromRGBO(255, 255, 255, 1.0)),
    158 : Team("Milkwaukee", "Brewers", "MIL", Color.fromRGBO(19, 41, 75, 1.0), Color.fromRGBO(182, 146, 46, 1.0))
  };

  static Map<int, Team> nhlTeams = {
    1 : Team("New Jersey", "Devils", "NJD", Color.fromRGBO(200, 16, 46, 1.0), Color.fromRGBO(0, 0, 0, 1.0)),
    2 : Team("New York", "Islanders", "NYI", Color.fromRGBO(0, 48, 135, 1.0), Color.fromRGBO(252, 76, 2, 1.0)),
    3 : Team("New York", "Rangers", "NYR", Color.fromRGBO(0, 51, 160, 1.0), Color.fromRGBO(200, 16, 46, 1.0)),
    4 : Team("Philadelphia", "Flyers", "PHI", Color.fromRGBO(250, 70, 22, 1.0), Color.fromRGBO(0, 0, 0, 1.0)),
    5 : Team("Pittsburgh", "Penguins", "PIT", Color.fromRGBO(255, 184, 28, 1.0), Color.fromRGBO(0, 0, 0, 1.0)),
    6 : Team("Boston", "Bruins", "BOS", Color.fromRGBO(252, 181, 20, 1.0), Color.fromRGBO(0, 0, 0, 1.0)),
    7 : Team("Buffalo", "Sabres", "BUF", Color.fromRGBO(0, 38, 84, 1.0), Color.fromRGBO(252, 181, 20, 1.0)),
    8 : Team("Montréal", "Canadiens", "MTL", Color.fromRGBO(166, 25, 46, 1.0), Color.fromRGBO(0, 30, 98, 1.0)),
    9 : Team("Ottawa", "Senators", "OTT", Color.fromRGBO(200, 16, 46, 1.0), Color.fromRGBO(198, 146, 20, 1.0)),
    10 : Team("Toronto", "Maple Leafs", "TOR", Color.fromRGBO(0, 32, 91, 1.0), Color.fromRGBO(255, 255, 255, 1.0)),
    12 : Team("Carolina", "Hurricanes", "CAR", Color.fromRGBO(204, 0, 0, 1.0), Color.fromRGBO(162, 169, 175, 1.0)),
    13 : Team("Florida", "Panthers", "FLA", Color.fromRGBO(200, 16, 46, 1.0), Color.fromRGBO(185, 151, 91, 1.0)),
    14 : Team("Tampa Bay", "Lightning", "TBL", Color.fromRGBO(0, 32, 91, 1.0), Color.fromRGBO(255, 255, 255, 1.0)),
    15 : Team("Washington", "Capitals", "WSH", Color.fromRGBO(4, 30, 66, 1.0), Color.fromRGBO(200, 16, 46, 1.0)),
    16 : Team("Chicago", "Blackhawks", "CHI", Color.fromRGBO(206, 17, 38, 1.0), Color.fromRGBO(204, 138, 0, 1.0)),
    17 : Team("Detroit", "Red Wings", "DET", Color.fromRGBO(200, 16, 46, 1.0), Color.fromRGBO(255, 255, 255, 1.0)),
    18 : Team("Nashville", "Predators", "NSH", Color.fromRGBO(255, 184, 28, 1.0), Color.fromRGBO(4, 30, 66, 1.0)),
    19 : Team("St. Louis", "Blues", "STL", Color.fromRGBO(0, 47, 135, 1.0), Color.fromRGBO(255, 184, 28, 1.0)),
    20 : Team("Calgary", "Flames", "CGY", Color.fromRGBO(206, 17, 38, 1.0), Color.fromRGBO(243, 188, 82, 1.0)),
    21 : Team("Colorado", "Avalanche", "COL", Color.fromRGBO(35, 97, 146, 1.0), Color.fromRGBO(111, 38, 61, 1.0)),
    22 : Team("Edmonton", "Oilers", "EDM", Color.fromRGBO(252, 76, 2, 1.0), Color.fromRGBO(4, 30, 66, 1.0)),
    23 : Team("Vancouver", "Canucks", "VAN", Color.fromRGBO(0, 136, 82, 1.0), Color.fromRGBO(0, 32, 91, 1.0)),
    24 : Team("Anaheim", "Ducks", "ANA", Color.fromRGBO(181, 152, 90, 1.0), Color.fromRGBO(249, 86, 2, 1.0)),
    25 : Team("Dallas", "Stars", "DAL", Color.fromRGBO(0, 99, 65, 1.0), Color.fromRGBO(162, 170, 173, 1.0)),
    26 : Team("Los Angeles", "Kings", "LAK", Color.fromRGBO(162, 170, 173, 1.0), Color.fromRGBO(0, 0, 0, 1.0)),
    28 : Team("San Jose", "Sharks", "SJS", Color.fromRGBO(0, 98, 114, 1.0), Color.fromRGBO(229, 114, 0, 1.0)),
    29 : Team("Columbus", "Blue Jackets", "CBJ", Color.fromRGBO(4, 30, 66, 1.0), Color.fromRGBO(200, 16, 46, 1.0)),
    30 : Team("Minnesota", "Wild", "MIN", Color.fromRGBO(21, 71, 52, 1.0), Color.fromRGBO(166, 25, 46, 1.0)),
    52 : Team("Winnipeg", "Jets", "WPG", Color.fromRGBO(4, 30, 66, 1.0), Color.fromRGBO(162, 170, 173, 1.0)),
    53 : Team("Arizona", "Coyotes", "ARI", Color.fromRGBO(140, 38, 51, 1.0), Color.fromRGBO(226, 214, 181, 1.0)),
    54 : Team("Vegas", "Golden Knights", "VGK", Color.fromRGBO(185, 151, 91, 1.0), Color.fromRGBO(0, 0, 0, 1.0))
  };

}