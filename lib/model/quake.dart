class Quake {
  final String title;
  final num mag;
  final String place;
  final num time;
  final Geometry geo;

  Quake._({this.title, this.mag, this.place, this.time, this.geo});

  factory Quake.fromJson(Map<String,dynamic> json){
    return new Quake._(
        title: json['properties']['title'],
        mag: json['properties']['mag'],
        place: json['properties']['place'],
        time: json['properties']['time'],
        geo: Geometry.fromJson(json['geometry'])
    );
  }
}
//{"type":"Feature",
// "properties": {"mag":1.8,"place":"77km NW of Talkeetna, Alaska",
// "time":1554683560656,"updated":1554683928167,"tz":-540,
// "url":"https://earthquake.usgs.gov/earthquakes/eventpage/ak0194i2uyg2",
// "detail":"https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/ak0194i2uyg2.geojson",
// "felt":null, "cdi":null, "mmi":null, "alert":null, "status":"automatic",
// "tsunami":0,"sig":50,"net":"ak","code":"0194i2uyg2","ids":",ak0194i2uyg2,",
// "sources":",ak,","types":",geoserve,origin,","nst":null,
// "dmin":null,"rms":0.67,"gap":null,"magType":"ml","type":"earthquake",
// "title":"M 1.8 - 77km NW of Talkeetna, Alaska"},
// "geometry":{"type":"Point", "coordinates":[-151.0781,62.8577,99.7]},
// "id":"ak0194i2uyg2"},
class Geometry {
  final String type;
  final List coords;

  Geometry._({this.type, this.coords});

  factory Geometry.fromJson(Map<String, dynamic> parsedJson){
    return Geometry._(
      type: parsedJson['type'],
      coords: parsedJson['coordinates']
    );
  }
}


