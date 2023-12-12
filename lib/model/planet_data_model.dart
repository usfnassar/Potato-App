class PlanetDataModel {
  late List<Data> data;

  PlanetDataModel({required this.data});

  PlanetDataModel.fromJson(Map<String, dynamic> json) {

      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });

  }

}

class Data {
  late int id;
  late String planetDisease;
  late String planetName;

  Data({required this.id, required this.planetDisease,required this.planetName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    planetDisease = json['PlanetDisease'];
    planetName = json['PlanetName'];
  }

}