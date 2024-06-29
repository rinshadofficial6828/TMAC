class MainTrainingsResponse {
  int? id;
  String? name;
  List<SubTrainings>? subTrainings;

  MainTrainingsResponse({this.id, this.name, this.subTrainings});

  MainTrainingsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['sub_trainings'] != null) {
      subTrainings = <SubTrainings>[];
      json['sub_trainings'].forEach((v) {
        subTrainings!.add(new SubTrainings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.subTrainings != null) {
      data['sub_trainings'] =
          this.subTrainings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubTrainings {
  int? mainTraining;
  String? name;
  String? validityPeriod;

  SubTrainings({this.mainTraining, this.name, this.validityPeriod});

  SubTrainings.fromJson(Map<String, dynamic> json) {
    mainTraining = json['main_training'];
    name = json['name'];
    validityPeriod = json['validity_period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main_training'] = this.mainTraining;
    data['name'] = this.name;
    data['validity_period'] = this.validityPeriod;
    return data;
  }
}
