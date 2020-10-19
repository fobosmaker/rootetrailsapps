import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter_maps/src/model/trail_model.dart';

class TrailProvider{

  Future<List<TrailCardModel>> getAllTrail() async{

    String url = 'https://rootetrails.com/rest/api/v1/allTrail';

    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      HttpClientRequest req = await clientReq.getUrl(Uri.parse(url));
      req.headers.set('content-type', 'application/json');
      HttpClientResponse response = await req.close().timeout(Duration(seconds: 5));
      print('getAllTrail response statusCode: ${response.statusCode}');
      if(response.statusCode == 200){
        print('getAllTrail ada data');
        String reply = await response.transform(utf8.decoder).join();
        final jsonData = jsonDecode(reply);
        print('getAllTrail response transform $jsonData');

        List<dynamic> data = jsonData['data'];
        List<TrailCardModel> result = [];
        data.forEach( (element) => result.add(new TrailCardModel(id: element['id'], name: element['name'], imageURL: element['cover'])) );
        //print(data.length);
        return result;

      } else if(response.statusCode == 404){
        print('getAllTrail tidak ada data');
      } else {
        print('getAllTrail bad request');
      }
    } on TimeoutException catch(_){
      print('getAllTrail response: timeout!');
      throw('Timeout');
    } catch(e){
      print('getAllTrail response: ERROR!');
      throw('error');
    }
  }

  Future<TrailAboutModel> getTrailAbout(String id) async {
    String url = 'https://rootetrails.com/rest/api/v1/trailAbout';
    Map map = {
      "id":id
    };
    var body = json.encode(map);
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      HttpClientRequest req = await clientReq.postUrl(Uri.parse(url));
      req.headers.set('content-type', 'application/json');
      req.add(utf8.encode(body));

      HttpClientResponse response = await req.close().timeout(Duration(seconds: 5));
      print('getTrailDetail response statusCode: ${response.statusCode}');
      if(response.statusCode == 200){
        print('getAllTrail ada data');
        String reply = await response.transform(utf8.decoder).join();
        final jsonData = jsonDecode(reply);
        return TrailAboutModel.fromJson(jsonData['data']);
      } else if(response.statusCode == 404){
        print('getTrailDetail tidak ada data');
      } else {
        print('getTrailDetail bad request');
      }
    } on TimeoutException catch(_){
      print('getTrailDetail response: timeout!');
      throw('Timeout');
    } catch(e){
      print('getTrailDetail response: ERROR!');
      throw('error');
    }
  }

  Future<List<TrailGeometryModel>> getTrailTrack(String url) async {
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      HttpClientRequest req = await clientReq.getUrl(Uri.parse(url));
      req.headers.set('content-type', 'application/json');
      HttpClientResponse response = await req.close().timeout(Duration(seconds: 5));
      print('getTrailTrack response statusCode: ${response.statusCode}');
      if(response.statusCode == 200){
        String reply = await response.transform(utf8.decoder).join();
        final jsonData = jsonDecode(reply);
        List<dynamic> features = jsonData['features'];
        List<TrailGeometryModel> trailGeometry = [];
        for(int i = 0; i < features.length; i++){
          List<TrailTrackLatLngModel> dataTrack = [];
          List<dynamic> coordinates= features[i]['geometry']['coordinates'];
          for(int j = 0; j < coordinates.length; j++){
            List<dynamic> detailCoordinates = coordinates[j];
            for(int k = 0; k < detailCoordinates.length; k++) {
              dataTrack.add(new TrailTrackLatLngModel(
                  longitude: detailCoordinates[k][0].toString(),
                  latitude: detailCoordinates[k][1].toString()));
            }
          }
          trailGeometry.add(new TrailGeometryModel(coordinates: dataTrack));
        }
        print('getTrailTrack ada ${trailGeometry.length} data');
        return trailGeometry;
      } else if(response.statusCode == 404){
        print('getAllTrail tidak ada data');
      } else {
        print('getAllTrail bad request');
      }
    } on TimeoutException catch(_){
      print('getAllTrail response: timeout!');
      throw('Timeout');
    } catch(e){
      print('getAllTrail response: ERROR!');
      throw(e);
    }
  }

  Future<List<TrailPlaceModel>> getTrailPlace(String id) async {
    String url = 'https://rootetrails.com/rest/api/v1/trailPlace';
    Map map = {
      "id":id
    };
    var body = json.encode(map);
    HttpClient clientReq = new HttpClient();
    clientReq.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try{
      HttpClientRequest req = await clientReq.postUrl(Uri.parse(url));
      req.headers.set('content-type', 'application/json');
      req.add(utf8.encode(body));

      HttpClientResponse response = await req.close().timeout(Duration(seconds: 5));
      print('getTrailPlace response statusCode: ${response.statusCode}');
      if(response.statusCode == 200){

        String reply = await response.transform(utf8.decoder).join();
        final jsonData = jsonDecode(reply);
        List<dynamic> list = jsonData['data'];
        List<TrailPlaceModel> dataPlace = [];
        list.forEach((element) {
          dataPlace.add(TrailPlaceModel.fromJson(element));
        });
        print('getTrailPlace ada data ${dataPlace.length}');
        return dataPlace;
      } else if(response.statusCode == 404){
        print('getTrailPlace tidak ada data');
      } else {
        print('getTrailPlace bad request');
      }
    } on TimeoutException catch(_){
      print('getTrailPlace response: timeout!');
      throw('Timeout');
    } catch(e){
      print('getTrailDetail response: ERROR!');
      throw('getTrailPlace');
    }
  }
}