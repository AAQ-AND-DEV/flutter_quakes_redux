import 'package:flutter/material.dart';
import '../utils/utils.dart';
import '../utils/weather_fetch.dart';

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text(
          "Klimatic",
          style: new TextStyle(color: Colors.black45),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu), onPressed: () => debugPrint("what?"))
        ],
      ),
      body: WeatherFetch(),
    );
  }
}




//snowy Photo by Craig Whitehead on Unsplash
//foggy Photo by George Gvasalia on Unsplash
//lightning Photo by Mélody P on Unsplash
//umbrella Photo by Bangkit Ristant on Unsplash
//sunshine Photo by Patrick Tomasso on Unsplash
