import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/weather.dart';
import '../utils/utils.dart' as util;
import '../utils/styles_util.dart' as styles;

class WeatherFetch extends StatefulWidget {
  @override
  _WeatherFetchState createState() => _WeatherFetchState._();
}

class _WeatherFetchState extends State<WeatherFetch> {
  WeatherData weather;
  //WeatherData weatherData;
  String city;
  var isLoading = false;

  _WeatherFetchState._({this.weather, this.city}) : super();

  //helpful for getting async to work
  // https://flutter.institute/run-async-operation-on-widget-creation/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    city = util.defaultCity;
    //weather = _fetchWeatherData(city);
    _fetchWeatherData(city).then((result) {
      setState(() {
        weather = result;
      });
    });

    //showWeather();
  }
/*
  void showWeather() async{
    city = util.defaultCity;
    weather = await _fetchWeatherData(city);

  }*/

  Future<WeatherData> _fetchWeatherData(String city) async {
    String weather_url =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appId=${util.appId}&units=imperial";

    setState(() {
      isLoading = true;
    });

    final http.Response response = await http.get(weather_url);
    if (response.statusCode == 200) {
      var weatherMap = json.decode(response.body);
      print(weatherMap);
      print(weatherMap.runtimeType);
      weather = WeatherData.fromJson(weatherMap);
      print("this is it" + weather.name);
      return weather;
    } else {
      throw Exception('failed to fetch weather ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _cityTextController = new TextEditingController();
    if (weather == null) {
      return new Container();
    } else {


      return new Stack(
        children: <Widget>[
          Container(
            width: 480.0,
            height: 1200.0,
            constraints: BoxConstraints.expand(),
            child: new Center(
              child: new Image.asset(
                'lib/assets/images/umbrella.png',
                width: 490.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0, 8.0, 20.0, 0),
            child: new Text(
              weather.name.toString(),
              style: styles.cityStyle(),
            ),
          ),
          new Container(
            alignment: Alignment.center,
            child: new Image.asset('lib/assets/images/light_rain.png'),
          ),
          new Container(
            margin: const EdgeInsets.fromLTRB(30.0, 290.0, 0, 0),
            alignment: Alignment.center,
            child: new Text(
              '${weather.temp}\u00b0 F',
              style: styles.tempStyle(),
            ),
          ),
          new Container(
            child: updateMinMax(),
          ),
          Column(
            children: <Widget>[
              new Container(
                child: TextFormField(
                  controller: _cityTextController,
                  autovalidate: false,
                  initialValue: null,
                  style: TextStyle(fontSize: 24.0,color: Colors.red ),

                ),
              ),
              new RaisedButton(onPressed: () {
                city = _cityTextController.text;
                _fetchWeatherData(city).then((result) {
                  setState(() {
                    weather = result;
                  });
                });
              }, child: new Text('Get Weather',
                  style: TextStyle(fontSize: 32.0, color: Colors.green)
              ))
            ],
          )
        ],
      );
    }
  }
/* sample of using futureBuilder to access weather
  Widget updateMinMax(String city) {
    return new FutureBuilder(
        future: _fetchWeatherData(city),
        builder: (BuildContext context, AsyncSnapshot<WeatherData> snapshot) {
          if (snapshot.hasData) {
            WeatherData content = snapshot.data;
            return new Container(
              alignment: Alignment.bottomCenter,
              child: new Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    child: new ListTile(
                      subtitle: new Text(
                        "Min/Max Temps",
                        style: new TextStyle(
                            fontSize: 34.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      title: new Text(
                        "${content.minTemp}\u00b0 F / ${content.maxTemp}\u00b0 F",

                      style: new TextStyle(fontSize: 48.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                    ),
                  )
                ],
              ),
            );
          } else return Container();
        });
  }
  */
  Widget updateMinMax() {
    if (weather != null){
      return Container(
              alignment: Alignment.bottomCenter,
              child: new Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    child: new ListTile(
                      subtitle: new Text(
                        "Min/Max Temps",
                        style: new TextStyle(
                            fontSize: 34.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      title: new Text(
                          "${weather.minTemp}\u00b0 F / ${weather.maxTemp}\u00b0 F",

                          style: new TextStyle(fontSize: 48.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                  )
                ],
              ),
            );
          } else return Container();
        }
  }


