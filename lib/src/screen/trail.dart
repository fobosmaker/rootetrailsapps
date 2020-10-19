import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_maps/constant.dart';
import 'package:flutter_maps/src/model/trail_model.dart';
import 'package:flutter_maps/src/provider/trail_provider.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_maps/src/widget/custom_marker.dart';

class TrailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TrailCardModel args = ModalRoute.of(context).settings.arguments;
    return TrailScreenView(id:args.id);
  }
}

class TrailScreenView extends StatefulWidget {

  final String id;
  TrailScreenView({this.id});

  @override
  _TrailScreenViewState createState() => _TrailScreenViewState();
}

class _TrailScreenViewState extends State<TrailScreenView> {

  TrailProvider api = new TrailProvider();
  List<TrailGeometryModel> dataTrack = [];
  List<TrailPlaceModel> dataPlace = new List<TrailPlaceModel>();
  LatLng initPosition;
  double minLat = 0.0;
  double minLong = 0.0;
  double maxLat = 0.0;
  double maxLong = 0.0;
  double paddingCoordinate = 0.002;
  bool isLoad = false;

  @override
  void initState() {
    super.initState();
    api.getTrailAbout(widget.id).then((value){
      initPosition = new LatLng(double.parse(value.latitude) ,double.parse(value.longitude));
      String url = value.track;
      api.getTrailPlace(widget.id).then((value){
        dataPlace.addAll(value);

        api.getTrailTrack(url).then((value){
          dataTrack.addAll(value);
          setState(() {});
        });

        setState(() => isLoad = true);
      });
    });

  }

  void filterBounds(double lat, double long){
    if(minLat == 0.0 && minLong == 0.0 && maxLat == 0.0 && maxLong == 0.0){
      minLat = lat;
      minLong = long;
      maxLat = lat;
      maxLong = long;
    } else {
      if(lat < minLat) minLat = lat;
      if(lat > maxLat) maxLat = lat;
      if(long < minLong) minLong = long;
      if(long > maxLong) maxLong = long;
    }
  }

  @override
  Widget build(BuildContext context) {

    List<Marker> listMarker = [];

    if(dataPlace.length > 0){
      dataPlace.forEach((element) {
        //komparasi bound dari marker koordinat
        double parseLatitude = double.parse(element.latitude);
        double parseLongitude = double.parse(element.longitude);
        filterBounds(parseLatitude, parseLongitude);

        listMarker.add(
            new Marker(
              width: 105.0,
              height: 105.0,
              point: new LatLng(parseLatitude, parseLongitude),
              builder: (ctx) => new CustomMarker(name: element.name, idPlaceType: element.id_place_type,)
            )
        );
      });
    }

    List<Polyline> listPolyline = [];
    if(dataTrack.length > 0){
      dataTrack.forEach((element) {
        List<LatLng> coord = [];
        for(int i = 0; i < element.coordinates.length; i++){
          //komparasi dengan track koordinat
          double parseLatitude = double.parse(element.coordinates[i].latitude);
          double parseLongitude = double.parse(element.coordinates[i].longitude);
          filterBounds(parseLatitude, parseLongitude);

          coord.add(LatLng(parseLatitude, parseLongitude));
        }
        listPolyline.add(new Polyline( points: coord, color: defaultPrimaryColor, strokeWidth: 5));
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Trail'),
          centerTitle: true,
          backgroundColor: defaultPrimaryColor,
        ),
        body: isLoad ? Column(
            children: <Widget>[
              SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: FlutterMap(
                      options: new MapOptions(
                        bounds: LatLngBounds(LatLng(minLat-paddingCoordinate,minLong-paddingCoordinate), LatLng(maxLat+paddingCoordinate, maxLong+paddingCoordinate)),
                        boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(16.0)),
                      ),
                      layers: [
                        new TileLayerOptions(
                          urlTemplate: "https://api.mapbox.com/styles/v1/roote/ckgdqyb861zrw1amtf41khq5z/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoicm9vdGUiLCJhIjoiY2s3MG44aWV0MDBhazNtcGpvczd0dzhkbyJ9.IIEhLuEcCkL8xSUoBeLeow",
                          additionalOptions: {
                            'accessToken': 'pk.eyJ1Ijoicm9vdGUiLCJhIjoiY2s3MG44aWV0MDBhazNtcGpvczd0dzhkbyJ9.IIEhLuEcCkL8xSUoBeLeow',
                            'id':'mapbox.mapbox-streets-v8'
                          },
                        ),
                        new PolylineLayerOptions(polylines: listPolyline),
                        new MarkerLayerOptions(markers: listMarker),
                      ]
                  )
              )
            ]
        ) : Center(child: CircularProgressIndicator())
    );
  }
}
