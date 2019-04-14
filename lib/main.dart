import 'package:flutter/material.dart';
import 'data/quake_fetch.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

      body: QuakeFetchData(),
    );
  }
}