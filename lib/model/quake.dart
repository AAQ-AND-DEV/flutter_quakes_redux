class Quake {
  final String title;
  final double mag;
  final String place;
  final num time;
  final List<double> coords;

  Quake._({this.title, this.mag, this.place, this.time, this.coords});

  factory Quake.fromJson(Map<String, dynamic> json){
    return new Quake._(
        title: json['properties']['title'],
        mag: json['properties']['mag'],
        place: json['properties']['place'],
        time: json['properties']['time'],
        coords: json['properties']['coordinates']
    );
  }
}