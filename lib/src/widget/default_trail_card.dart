import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/constant.dart';
class DefaultTrailCardWidget extends StatelessWidget {

  final String title;
  final String imageURL;
  final Function onTap;
  DefaultTrailCardWidget({this.title, this.imageURL, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: 250,
        height: 215,
        child:  Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          clipBehavior: Clip.antiAlias,
          elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 125,
                  width: 250,
                  color: defaultUltraLightGreyColor,
                  child: Image.network("https://rootetrails.com/asset/image/trail_cover/$imageURL",fit: BoxFit.fill,),
                ),
                Container(
                  //color: Colors.orangeAccent,
                  child: ListTile(
                      title: Text(title, style: defaultBlackContentHeaderStyle),
                      subtitle: Text('Lorem ipsum dolor sir amet', style: defaultPrimaryContentDetailStyle),
                      //trailing: Icon(Icons.launch),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
