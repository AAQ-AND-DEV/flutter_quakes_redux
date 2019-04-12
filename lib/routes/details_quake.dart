import 'package:flutter/material.dart';
import 'package:flutter_quakes_redux/model/quake.dart';
import 'package:intl/intl.dart';

class DetailQuake extends StatelessWidget {
  final Quake quake;

  DetailQuake({Key key, @required this.quake}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Quake Details')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Text(
                quake.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text("Magnitude: ${quake.mag as double}", style: TextStyle(fontSize: 18),),
              Row(
                children: <Widget>[
                  Text("Coordinates: "
                      "${quake.geo.coords.toString()}"),
                  RaisedButton(
                    onPressed: ()=> print("map requested"),
                    child: Text("see on Map"),
                  )
                ],
              ),
              Text(
                  "occurred at: ${new DateTime.fromMicrosecondsSinceEpoch(quake.time * 1000)}"),
            ])),
      ),
    );
  }
}
