import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/quake.dart';
import 'package:intl/intl.dart';

//borrowed from Diego Velasquez medium example https://github.com/diegoveloper/flutter-samples/blob/master/lib/fetch_data/main_fetch_data.dart

class QuakeFetchData extends StatefulWidget{
  @override
  _QuakeState createState() {
    // TODO: implement createState
    return _QuakeState._();
  }


}

class _QuakeState extends State<QuakeFetchData>{
  Map quakes = Map();
  var isLoading = false;

  _QuakeState._({this.quakes }) :super();


  @override
  void initState() {
    super.initState();
    _fetchQuakeData();
  }

  _fetchQuakeData() async {
    String quakes_url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";

    setState(() {
      isLoading = true;
    });
    final response = await http.get(quakes_url);

    if (response.statusCode == 200) {
      quakes = (json.decode(response.body));
      .((data) => new Quake.fromJson(data))
          //.toList();
      print("${quakes.runtimeType} $quakes ");
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('failed to load photos');
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Earthquakes!"),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),
      )
          : ListView.builder(itemBuilder: (BuildContext context, int index){
            return ListTile(
              leading: CircleAvatar(
                child: Text(quakes[index].mag.toStringAsFixed(1)),
              ),
              contentPadding: EdgeInsets.all(7.0),
              title: new Text(quakes[index].title),
              subtitle: Text(new DateFormat.yMMMMd(quakes[index].time.toString()).toString()),

            );
      })
    );
  }
}