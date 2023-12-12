class PlanetModel {
  late PredictedClassLabel predictedClassLabel;

  PlanetModel({required this.predictedClassLabel});

  PlanetModel.fromJson(Map<String, dynamic> json) {

    predictedClassLabel = PredictedClassLabel.fromJson(json['predicted_class_label']);

  }

}

class PredictedClassLabel {
  late String planetDisease;
  late String planetName;
  late int id;

  PredictedClassLabel({required this.planetDisease,required this.planetName});

  PredictedClassLabel.fromJson(Map<String, dynamic> json) {
     planetDisease = json['PlanetDisease'];
    planetName = json['PlanetName'];
    id = json['Id'];
  }

}