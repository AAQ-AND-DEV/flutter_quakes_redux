class WeatherData {
//  {"coord":{"lon":-0.13,"lat":51.51},
//  "weather":[{"id":300,"main":"Drizzle",
//  "description":"light intensity drizzle",
//  "icon":"09d"}],
//  "base":"stations",
//  "main":{"temp":280.32,"pressure":1012,"humidity":81,
//  "temp_min":279.15,"temp_max":281.15},

//  "visibility":10000,
//  "wind":{"speed":4.1,"deg":80},
//  "clouds":{"all":90},
//  "dt":1485789600,
//  "sys":{"type":1,"id":5091,"message":0.0103,
//  "country":"GB","sunrise":1485762037,"sunset":1485794875},
//  "id":2643743,"name":"London","cod":200}
  final String name;
  final num temp;
  final num pressure;
  final num humidity;
  final num minTemp;
  final num maxTemp;
  final Forecast weather;

  WeatherData._({this.name, this.weather, this.temp, this.pressure, this.humidity, this.minTemp, this.maxTemp});

  factory WeatherData.fromJson(Map<String, dynamic> parsedJson){
    WeatherData weatherData = WeatherData._(
      name: parsedJson['name'],
      temp: parsedJson['main']['temp'],
      pressure: parsedJson['main']['pressure'],
      humidity: parsedJson['main']['humidity'],
      minTemp: parsedJson['main']['temp_min'],
      maxTemp: parsedJson['main']['temp_max'],
      weather: Forecast.fromJson(parsedJson['weather']),
    );
    print("${weatherData.name} maxTemp ${weatherData.maxTemp}");
    return weatherData;
  }
}

class Forecast {
  final String forecast;
  final String desc;

  Forecast._({this.desc, this.forecast});

  factory Forecast.fromJson(List<dynamic> parsedJson){
    Forecast test = Forecast._(
      forecast: parsedJson[0]['main'],
      desc: parsedJson[0]['description']
    );
    print(test.forecast + " description:" + test.desc );
    return test;

  }

}
