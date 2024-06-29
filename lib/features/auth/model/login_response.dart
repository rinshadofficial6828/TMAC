class LoginResponse {
  bool? status;
  String? message;
  Data? data;

  LoginResponse({this.status, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? fullname;
  String? mobileNumber;
  String? designation;
  String? gatePassNo;
  String? rigOrRigless;
  String? profilePhoto;
  bool? isAccepted;
  Company? company;
  Company? project;
  bool? onDuty;

  Data(
      {this.id,
      this.fullname,
      this.mobileNumber,
      this.designation,
      this.gatePassNo,
      this.rigOrRigless,
      this.profilePhoto,
      this.isAccepted,
      this.company,
      this.project,
      this.onDuty});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    mobileNumber = json['mobile_number'];
    designation = json['designation'];
    gatePassNo = json['gate_pass_no'];
    rigOrRigless = json['rig_or_rigless'];
    profilePhoto = json['profile_photo'];
    isAccepted = json['is_accepted'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    project =
        json['project'] != null ? new Company.fromJson(json['project']) : null;
    onDuty = json['on_duty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['mobile_number'] = this.mobileNumber;
    data['designation'] = this.designation;
    data['gate_pass_no'] = this.gatePassNo;
    data['rig_or_rigless'] = this.rigOrRigless;
    data['profile_photo'] = this.profilePhoto;
    data['is_accepted'] = this.isAccepted;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    data['on_duty'] = this.onDuty;
    return data;
  }
}

class Company {
  int? id;
  String? name;

  Company({this.id, this.name});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
