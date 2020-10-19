import 'package:flutter/material.dart';
import 'package:flutter_maps/constant.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_maps/src/widget/custom_marker.dart';

class MapsResearchPage extends StatefulWidget {
  @override
  _MapsResearchPageState createState() => _MapsResearchPageState();
}

class _MapsResearchPageState extends State<MapsResearchPage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Trail'),
          centerTitle: true,
          backgroundColor: defaultPrimaryColor,
        ),
        body: FlutterMap(
            options: new MapOptions(
              center: LatLng(40.73, -74.00)
            ),
            layers: [
              new TileLayerOptions(
                urlTemplate: "https://api.mapbox.com/styles/v1/roote/ckgdqyb861zrw1amtf41khq5z/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoicm9vdGUiLCJhIjoiY2s3MG44aWV0MDBhazNtcGpvczd0dzhkbyJ9.IIEhLuEcCkL8xSUoBeLeow",
                additionalOptions: {
                  'accessToken': 'pk.eyJ1Ijoicm9vdGUiLCJhIjoiY2s3MG44aWV0MDBhazNtcGpvczd0dzhkbyJ9.IIEhLuEcCkL8xSUoBeLeow',
                  'id':'mapbox.mapbox-streets-v8'
                },
              ),
              new MarkerLayerOptions(markers: [
                new Marker(
                  width: 100.0,
                  height: 105.0,
                  point: new LatLng(40.73, -74.00),
                  builder: (ctx) => new CustomMarker(name: "yeaaay")
                ),
                new Marker(
                    width: 100.0,
                    height: 105.0,
                    point: new LatLng(40.731, -74.00),
                    builder: (ctx) => new CustomMarker(name: "wohoooo")
                ),
              ]),
            ]
        )

    );
  }
}
