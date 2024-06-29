class DutyModel {
  bool? onDuty;

  DutyModel({this.onDuty});

  DutyModel.fromJson(Map<String, dynamic> json) {
    onDuty = json['on_duty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['on_duty'] = this.onDuty;
    return data;
  }
}
