class SignUpModel {
  String? firstName;
  String? lastName;
  String? middleName;
  String? address;
  String? emailAddress;
  String? mobileNumber;
  String? dateOfBirth;
  List<dynamic>? userRoles;
  String? username;
  String? password;
  String? photo;
  String? deviceId;
  String? geoLocation;
  String? gender;
  String? language;
  String? city;
  String? country;
  String? channel;
  String? signupBy;

  SignUpModel({
    this.firstName,
    this.lastName,
    this.middleName,
    this.address,
    this.emailAddress,
    this.mobileNumber,
    this.dateOfBirth,
    this.userRoles,
    this.username,
    this.password,
    this.photo,
    this.deviceId,
    this.geoLocation,
    this.gender,
    this.language,
    this.city,
    this.country,
    this.channel = "MOBILE",
    this.signupBy = "LOCAL_DOMAIN",
  });

  SignUpModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'] as String?;
    lastName = json['lastName'] as String?;
    middleName = json['middleName'] as String?;
    address = json['address'] as String?;
    emailAddress = json['emailAddress'] as String?;
    mobileNumber = json['mobileNumber'] as String?;
    dateOfBirth = json['dateOfBirth'] as String?;
    userRoles = json['userRoles'] as List?;
    username = json['username'] as String?;
    password = json['password'] as String?;
    photo = json['photo'] as String?;
    deviceId = json['deviceId'] as String?;
    geoLocation = json['geoLocation'] as String?;
    gender = json['gender'] as String?;
    language = json['language'] as String?;
    city = json['city'] as String?;
    country = json['country'] as String?;
    channel = json['channel'] as String?;
    signupBy = json['signupBy'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['firstName'] = firstName;
    json['lastName'] = lastName;
    json['middleName'] = middleName;
    json['address'] = address;
    json['emailAddress'] = emailAddress;
    json['mobileNumber'] = mobileNumber;
    json['dateOfBirth'] = dateOfBirth;
    json['userRoles'] = userRoles;
    json['username'] = username;
    json['password'] = password;
    json['photo'] = photo;
    json['deviceId'] = deviceId;
    json['geoLocation'] = geoLocation;
    json['gender'] = gender;
    json['language'] = language;
    json['city'] = city;
    json['country'] = country;
    json['channel'] = channel;
    json['signupBy'] = signupBy;
    return json;
  }
}
