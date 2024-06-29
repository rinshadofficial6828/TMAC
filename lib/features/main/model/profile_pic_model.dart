class ProfilePicUpdate {
  String? profilePhoto;

  ProfilePicUpdate({this.profilePhoto});

  ProfilePicUpdate.fromJson(Map<String, dynamic> json) {
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}
