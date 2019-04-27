import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
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
    _fetchWeatherData(city).then((result){
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

  Future<WeatherData> _fetchWeatherData( String city) async {
    String weather_url = "http://api.openweathermap.org/data/2.5/weather?q=$city&appId=${util
        .appId}&units=imperial";

    setState(() {
      isLoading = true;
    });

    final http.Response response = await http.get(weather_url);
    if (response.statusCode == 200){
      var weatherMap = json.decode(response.body);
      print(weatherMap);
      print(weatherMap.runtimeType);
      weather = WeatherData.fromJson(weatherMap);
      print("this is it" + weather.name);
      return weather;
    } else {
      throw Exception('failed to fetch weather');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (weather == null){
      return new Container();
    }
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
        )
      ],
    );
  }
}
