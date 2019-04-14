import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';


class MapSample extends StatefulWidget{
  List coordinates;

  MapSample({Key key, @required this.coordinates}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    State<MapSample> createState() => _MapSampleState._();
  }
}

class _MapSampleState extends State<MapSample>{
  List coords;
  static var lat;
  static var long;

  _MapSampleState._({this.coords}) : super();

  @override
  void initState(){
    super.initState();
    _loadCoords();
  }


  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(lat, long),
    zoom: 14.4746,
  );

  /*
  static final CameraPosition _kLake = CameraPosition(
    bearing:
  )
  */
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
  _loadCoords(){
    lat = coords[0];
    long = coords[1];
  }
}