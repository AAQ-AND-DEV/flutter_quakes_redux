import 'quake.dart';

class Quakes {
  final List<Quake> quakesList;

  Quakes._({this.quakesList});

  factory Quakes.fromJson(Map<String, dynamic> json){
    quakesList : json['features'] as List;
  }

}