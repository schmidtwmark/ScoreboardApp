import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scoreboard',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran:"flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'My Scoreboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _settingsClicked() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: _settingsClicked,
          ),
        ],
      ),
      body: ScoreboardScreens(),
    );
  }
}

class ScoreboardScreens extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ScoreboardScreensState();
  }
}

Future<http.Response> configRequest() async {
  var url = 'http://192.168.0.197:5005/setSport'
}
Future<http.Response> sportRequest (ScreenId id) async {
  var url ='http://192.168.0.197:5005/setSport';

  Map data = {
    'sport': id.index
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}
class ScoreboardScreensState extends State<ScoreboardScreens> {

  List<Screen> _screenList = [
      Screen("NHL", ScreenId.nhl),
      Screen("MLB", ScreenId.mlb),
      //Screen("NCAA")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(    body: _fillScreens(),
    );
  }

  Widget _fillScreens() {
    return new ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: _screenList.length,
      itemBuilder: (context, i) {

        return _buildRow(_screenList[i]);
      },
    );
  }

  Widget _buildRow(Screen screen) {
    return new Card( 
      color: screen.enabled ? Colors.white : Colors.grey,
      
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () { 
          if(!screen.enabled) {
            setState(() {
              for (var s in _screenList) {
                s.enabled = false; 
              }
              sportRequest(screen.id);
              screen.enabled = true;
            });
          }
        },
        child: Column(children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(screen.title,
            style: TextStyle(fontSize: 24),),
            subtitle: Text(screen.subtitle),
          ),
        ],)
      ),
    );
  }
}
enum ScreenId { nhl, mlb }

class Screen {

  Screen(String title, ScreenId id) {
    this.title = title;
    this.subtitle = "Blah blah blah";
    this.enabled = false;
    this.id = id;
  }
  ScreenId id;
  String title;
  String subtitle;
  bool enabled;


}
