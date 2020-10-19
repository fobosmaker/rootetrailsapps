class TrailCardModel{
  String id;
  String name;
  String imageURL;
  TrailCardModel({this.id, this.name, this.imageURL});
}

class TrailAboutModel{
  String id;
  String track;
  String latitude;
  String longitude;
  TrailDetailModel detail;
  TrailAccessModel access;
  TrailDurationModel duration;
  TrailAboutModel({this.id, this.track, this.latitude, this.longitude, this.detail, this.access, this.duration});

  factory TrailAboutModel.fromJson(Map<String, dynamic> jsonData) {
    return TrailAboutModel(
      id: jsonData['id'],
      track: jsonData['track'],
      latitude: jsonData['latitude'],
      longitude: jsonData['longitude'],
      detail: TrailDetailModel.fromJson(jsonData['detail']),
      access: TrailAccessModel.fromJson(jsonData['access']),
      duration: TrailDurationModel.fromJson(jsonData['duration']),
    );
  }
}

class TrailDetailModel{
  String name;
  String about;
  String car_park;
  String bike_park;
  String to_do;
  String not_to_do;
  String cash;
  TrailDetailModel({this.name, this.about, this.car_park, this.bike_park, this.to_do, this.not_to_do, this.cash});
  factory TrailDetailModel.fromJson(Map<String, dynamic> jsonData) {
    return TrailDetailModel(
        name: jsonData['id'],
        about: jsonData['about'],
        car_park: jsonData['name'],
        bike_park: jsonData['name'],
        to_do: jsonData['name'],
        not_to_do: jsonData['name'],
        cash: jsonData['name']
    );
  }
}

class TrailAccessModel {
  String id;
  String name;
  TrailAccessModel({this.id, this.name});
  factory TrailAccessModel.fromJson(Map<String, dynamic> jsonData) {
    return TrailAccessModel(
        id: jsonData['id'],
        name: jsonData['name']
    );
  }
}

class TrailDurationModel {
  String id;
  String name;
  TrailDurationModel({this.id, this.name});
  factory TrailDurationModel.fromJson(Map<String, dynamic> jsonData) {
    return TrailDurationModel(
        id: jsonData['id'],
        name: jsonData['name']
    );
  }
}

class TrailTrackLatLngModel{
  String latitude;
  String longitude;
  TrailTrackLatLngModel({this.latitude, this.longitude});
}

class TrailGeometryModel{
  List<TrailTrackLatLngModel> coordinates;
  TrailGeometryModel({this.coordinates});
}

class TrailPlaceModel{
  String id;
  String name;
  String latitude;
  String longitude;
  String id_place_type;
  String description;
  TrailPlaceModel({this.id, this.name, this.latitude, this.longitude, this.id_place_type, this.description});

  factory TrailPlaceModel.fromJson(Map<String, dynamic> jsonData) {
    return TrailPlaceModel(
        id: jsonData['id'],
        name: jsonData['name'],
        latitude: jsonData['latitude'],
        longitude: jsonData['longitude'],
        id_place_type: jsonData['id_place_type'],
        description: jsonData['description']
    );
  }
}