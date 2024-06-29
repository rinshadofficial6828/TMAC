class SubTrainingresponseModel {
  String? employeeName;
  String? subTrainingName;
  String? mainTrainingName;
  String? startDate;
  String? expirationDate;
  bool? warning;
  dynamic completionPercentage;

  SubTrainingresponseModel(
      {this.employeeName,
      this.subTrainingName,
      this.mainTrainingName,
      this.startDate,
      this.expirationDate,
      this.warning,
      this.completionPercentage});

  SubTrainingresponseModel.fromJson(Map<String, dynamic> json) {
    employeeName = json['employee_name'];
    subTrainingName = json['sub_training_name'];
    mainTrainingName = json['main_training_name'];
    startDate = json['start_date'];
    expirationDate = json['expiration_date'];
    warning = json['warning'];
    completionPercentage = json['completion_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_name'] = this.employeeName;
    data['sub_training_name'] = this.subTrainingName;
    data['main_training_name'] = this.mainTrainingName;
    data['start_date'] = this.startDate;
    data['expiration_date'] = this.expirationDate;
    data['warning'] = this.warning;
    data['completion_percentage'] = this.completionPercentage;
    return data;
  }
}
