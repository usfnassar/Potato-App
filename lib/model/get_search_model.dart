class GetSearch {
  String? status;
  List<RecentPlants>? recentPlants;

  GetSearch({this.status, this.recentPlants});

  GetSearch.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['recentPlants'] != null) {
      recentPlants = <RecentPlants>[];
      json['recentPlants'].forEach((v) {
        recentPlants!.add(new RecentPlants.fromJson(v));
      });
    }
  }

}

class RecentPlants {
  String? sId;
  String? plantName;
  String? plantDisease;
  String? image;
  bool? hasDisease;
  String? treatment;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RecentPlants(
      {this.sId,
        this.plantName,
        this.plantDisease,
        this.image,
        this.hasDisease,
        this.treatment,
        this.createdAt,
        this.updatedAt,
        this.iV});

  RecentPlants.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    plantName = json['plantName'];
    plantDisease = json['plantDisease'];
    image = json['image'];
    hasDisease = json['hasDisease'];
    treatment = json['treatment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

}