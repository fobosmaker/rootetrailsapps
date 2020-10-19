import 'package:flutter/material.dart';
import 'package:flutter_maps/constant.dart';
import 'package:flutter_maps/constant.dart';

class CustomMarker extends StatefulWidget {

  final String name;
  final String idPlaceType;
  CustomMarker({this.name, this.idPlaceType});

  @override
  _CustomMarkerState createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  var infoWindowVisible = false;
  GlobalKey<State> key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _buildCustomMarker();
      InkWell(
        onTap: () {
        setState(() {
          infoWindowVisible = !infoWindowVisible;
        });
    },
    child: _buildCustomMarker());
  }
  Widget _buildCustomMarker() {
    return Container(
      child: Stack(
        children: <Widget>[popup(), marker()],
      ),
    );
  }

  Opacity popup() {
    return Opacity(
      opacity: infoWindowVisible ? 1.0 : 0.0,
      child: Container(
        decoration: BoxDecoration(
            color: defaultWhiteColor,
            borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.all(10),
        child: Text(widget.name, style: defaultBlackContentHeaderStyle,),
      ),
    );
  }

  Opacity marker() {
    return Opacity(
      child: InkWell(
        onTap: () => setState(() {
          infoWindowVisible = !infoWindowVisible;
        }),
        child: Container(
            alignment: Alignment.bottomCenter,
            child: new Icon(
              Icons.location_on,
              color: widget.idPlaceType == '1' ?
              defaultAccentColor : Colors.orangeAccent,
              size: 45,)
        ),
      ),
      opacity: infoWindowVisible ? 1.0 : 1.0,
    );
  }
}
