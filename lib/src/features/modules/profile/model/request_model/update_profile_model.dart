class UpdateProfileModel {
  String? fullName;
  String? emailAddress;
  String? mobileNumber;
  String? gender;
  String? photoLink;

  UpdateProfileModel({
    this.fullName,
    this.emailAddress,
    this.mobileNumber,
    this.gender,
    this.photoLink,
  });

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'] as String?;
    emailAddress = json['emailAddress'] as String?;
    mobileNumber = json['mobileNumber'] as String?;
    gender = json['gender'] as String?;
    photoLink = json['photoLink'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['fullName'] = fullName;
    json['emailAddress'] = emailAddress;
    json['mobileNumber'] = mobileNumber;
    json['gender'] = gender;
    json['photoLink'] = photoLink;
    return json;
  }
}
