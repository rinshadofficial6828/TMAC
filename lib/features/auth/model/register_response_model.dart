class RegisterresponseModel {
  final String gatePassNo;
  final String rigOrRigless;
  final String projectName;
  final String companyName;
  final String designationName;
  final String mobileNumber;
  final String fullName;
  final int projectId;
  final int companyId;

  RegisterresponseModel({
    required this.projectId,
    required this.companyId,
    required this.gatePassNo,
    required this.rigOrRigless,
    required this.projectName,
    required this.companyName,
    required this.designationName,
    required this.mobileNumber,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'gate_pass_no': gatePassNo,
      'rig_or_rigless': rigOrRigless,
      'project_name': projectName,
      'company_name': companyName,
      'designation': designationName,
      'mobile_number': mobileNumber,
      'fullname': fullName,
      'project_id':projectId,
      'company_id': companyId
    };
  }

  factory RegisterresponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterresponseModel(
      gatePassNo: json['gate_pass_no'],
      rigOrRigless: json['rig_or_rigless'],
      projectName: json['project_name'],
      companyName: json['company_name'],
      designationName: json['designation'],
      mobileNumber: json['mobile_number'],
      fullName: json['fullname'],
      projectId: json['project_id'],
      companyId: json['company_id']
    );
  }
}
