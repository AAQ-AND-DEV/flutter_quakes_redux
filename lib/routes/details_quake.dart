import 'package:flutter/material.dart';
import 'package:flutter_quakes_redux/model/quake.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/google_map.dart';
import 'package:intl/intl.dart';

class DetailQuake extends StatelessWidget {
  final Quake quake;
  List<String> coordsCut = new List();

  DetailQuake({Key key, @required this.quake}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for(var item in quake.geo.coords){
      String coord = item.toStringAsFixed(2);
      coordsCut.add(coord);
    }
    //also tried .map(), which didn't work
   //coordsCut = quake.geo.coords.forEach((data)=> data.toStringAsFixed(2).toList);
    var dateFormat = new DateFormat("y MMMM d 'at' HH:mm");
    var date = dateFormat.format(new DateTime.fromMicrosecondsSinceEpoch(
        quake.time * 1000));
    // TODO: implement build
    return Scaffold(

      backgroundColor: Colors.blue[100],
      appBar: AppBar(title: Text('Quake Details')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Text(
                quake.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(height: 4.0, color: Colors.orange),
              Text("Magnitude: ${quake.mag as double}",
                style: TextStyle(fontSize: 18),),

              new RaisedButton(onPressed: _launchURL,
                child: new Text('See more details'),),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                    Text("Coordinates: "
                        "${coordsCut.toString()}"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: new Text("see on Map"),
                        onPressed: () {
                              Route route =  MaterialPageRoute(
                              builder: (context) => MapSample(coordinates: quake.geo.coords));

                              Navigator.push(context, route);
                            },
                      ),
                    )
                  ],
                ),
              ),

              Text(
                  "occurred at: ${new DateTime.fromMicrosecondsSinceEpoch(quake.time * 1000)}"),
            ])),
      ),
    );

  }
  _launchURL() async{
    String url = quake.detail;
    if (await canLaunch(url)){
      await launch(url);
    } else{
      throw 'Url launch unsuccessful';
    }
  }
}
