import 'package:flutter/material.dart';
import 'package:flutter_quakes_redux/model/quake.dart';

class DetailQuake extends StatelessWidget{
  final Quake quake;

  DetailQuake({this.quake});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title:Text('Quake Details')),
      body: new Center(
        child: new Column(
          children: <Widget>[Text(quake.title)] ,
        )

      ),
    );
  }
}