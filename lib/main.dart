import 'package:flutter/material.dart';
import 'data/quake_fetch.dart';

void  main(){
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Quakes!")
      ),
      body: QuakeFetchData(),
    );
  }
}