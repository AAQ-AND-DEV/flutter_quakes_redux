import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/quake.dart';
import 'package:intl/intl.dart' as intl;
import '../model/quakes.dart';
import '../routes/details_quake.dart' as detail;

//adapted from Diego Velasquez medium example https://github.com/diegoveloper/flutter-samples/blob/master/lib/fetch_data/main_fetch_data.dart
//helped (hopefully) by Pooja Bhaumik https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51

class QuakeFetchData extends StatefulWidget {
  @override
  _QuakeState createState() {
    // TODO: implement createState
    return _QuakeState._();
  }
}

class _QuakeState extends State<QuakeFetchData> {
  List<Quake> quakes;
  List quakesList;
  Map quakesMap = Map();
  var isLoading = false;

  _QuakeState._({this.quakesList}) : super();

  @override
  void initState() {
    super.initState();
    //Future localeFuture = initializeDateFormatting('en');
    _fetchQuakeData();
  }

  _fetchQuakeData() async {
    String quakes_url =
        "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";

    setState(() {
      isLoading = true;
    });
    final response = await http.get(quakes_url);

    if (response.statusCode == 200) {
      quakesMap = json.decode(response.body);

      quakesList = quakesMap['features'];
      quakes = quakesList.map((data) => new Quake.fromJson(data)).toList();
      //Quakes
      //.fromJson();
      //quakesList.quakesList = quakesList.map((data) => new Quake.fromJson(data))
      //   .toList();
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
        backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Text("Earthquakes!"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var date = new DateTime.fromMicrosecondsSinceEpoch(
                    quakes[index].time * 1000);
                return ListTile(
                    leading: CircleAvatar(
                      child: Text((quakes[index].mag).toStringAsFixed(1)),
                    ),
                    contentPadding: EdgeInsets.all(7.0),
                    title: new Text(quakes[index].title),
                    subtitle: Text(
                      date.toString(),
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    trailing: new FlatButton(
                      child: Icon(Icons.keyboard_arrow_right),
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) =>
                                detail.DetailQuake(quake: quakes[index]));

                        Navigator.push(context, route);
                      },
                    ));
              },
            ),
    );
  }
}
