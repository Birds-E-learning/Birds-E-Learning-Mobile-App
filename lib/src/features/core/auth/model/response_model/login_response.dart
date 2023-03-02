class LoginResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  LoginResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as Map<String, dynamic>?) != null
        ? ResponseData.fromJson(json['responseData'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['responseCode'] = responseCode;
    json['responseMessage'] = responseMessage;
    json['responseData'] = responseData?.toJson();
    return json;
  }
}

class ResponseData {
  String? userId;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? middleName;
  String? fullName;
  String? address;
  String? mobileNumber;
  String? status;
  DateOfBirth? dateOfBirth;
  LastLoginDate? lastLoginDate;
  String? photoLink;
  CreatedDate? createdDate;
  ModifiedDate? modifiedDate;
  String? deviceId;
  String? geoLocation;
  String? gender;
  String? language;
  String? city;
  String? country;
  String? authToken;

  ResponseData({
    this.userId,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.middleName,
    this.fullName,
    this.address,
    this.mobileNumber,
    this.status,
    this.dateOfBirth,
    this.lastLoginDate,
    this.photoLink,
    this.createdDate,
    this.modifiedDate,
    this.deviceId,
    this.geoLocation,
    this.gender,
    this.language,
    this.city,
    this.country,
    this.authToken,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] as String?;
    username = json['username'] as String?;
    email = json['email'] as String?;
    firstName = json['firstName'] as String?;
    lastName = json['lastName'] as String?;
    middleName = json['middleName'] as String?;
    fullName = json['fullName'] as String?;
    address = json['address'] as String?;
    mobileNumber = json['mobileNumber'] as String?;
    status = json['status'] as String?;
    dateOfBirth = (json['dateOfBirth'] as Map<String, dynamic>?) != null
        ? DateOfBirth.fromJson(json['dateOfBirth'] as Map<String, dynamic>)
        : null;
    lastLoginDate = (json['lastLoginDate'] as Map<String, dynamic>?) != null
        ? LastLoginDate.fromJson(json['lastLoginDate'] as Map<String, dynamic>)
        : null;
    photoLink = json['photoLink'] as String?;
    createdDate = (json['createdDate'] as Map<String, dynamic>?) != null
        ? CreatedDate.fromJson(json['createdDate'] as Map<String, dynamic>)
        : null;
    modifiedDate = (json['modifiedDate'] as Map<String, dynamic>?) != null
        ? ModifiedDate.fromJson(json['modifiedDate'] as Map<String, dynamic>)
        : null;
    deviceId = json['deviceId'] as String?;
    geoLocation = json['geoLocation'] as String?;
    gender = json['gender'] as String?;
    language = json['language'] as String?;
    city = json['city'] as String?;
    country = json['country'] as String?;
    authToken = json['authToken'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['userId'] = userId;
    json['username'] = username;
    json['email'] = email;
    json['firstName'] = firstName;
    json['lastName'] = lastName;
    json['middleName'] = middleName;
    json['fullName'] = fullName;
    json['address'] = address;
    json['mobileNumber'] = mobileNumber;
    json['status'] = status;
    json['dateOfBirth'] = dateOfBirth?.toJson();
    json['lastLoginDate'] = lastLoginDate?.toJson();
    json['photoLink'] = photoLink;
    json['createdDate'] = createdDate?.toJson();
    json['modifiedDate'] = modifiedDate?.toJson();
    json['deviceId'] = deviceId;
    json['geoLocation'] = geoLocation;
    json['gender'] = gender;
    json['language'] = language;
    json['city'] = city;
    json['country'] = country;
    json['authToken'] = authToken;
    return json;
  }
}

class DateOfBirth {
  int? year;
  int? month;
  int? day;
  int? hours;
  int? minutes;
  int? seconds;

  DateOfBirth({
    this.year,
    this.month,
    this.day,
    this.hours,
    this.minutes,
    this.seconds,
  });

  DateOfBirth.fromJson(Map<String, dynamic> json) {
    year = json['year'] as int?;
    month = json['month'] as int?;
    day = json['day'] as int?;
    hours = json['hours'] as int?;
    minutes = json['minutes'] as int?;
    seconds = json['seconds'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['year'] = year;
    json['month'] = month;
    json['day'] = day;
    json['hours'] = hours;
    json['minutes'] = minutes;
    json['seconds'] = seconds;
    return json;
  }
}

class LastLoginDate {
  int? year;
  int? month;
  int? day;
  int? hours;
  int? minutes;
  int? seconds;

  LastLoginDate({
    this.year,
    this.month,
    this.day,
    this.hours,
    this.minutes,
    this.seconds,
  });

  LastLoginDate.fromJson(Map<String, dynamic> json) {
    year = json['year'] as int?;
    month = json['month'] as int?;
    day = json['day'] as int?;
    hours = json['hours'] as int?;
    minutes = json['minutes'] as int?;
    seconds = json['seconds'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['year'] = year;
    json['month'] = month;
    json['day'] = day;
    json['hours'] = hours;
    json['minutes'] = minutes;
    json['seconds'] = seconds;
    return json;
  }
}

class CreatedDate {
  int? year;
  int? month;
  int? day;
  int? hours;
  int? minutes;
  int? seconds;

  CreatedDate({
    this.year,
    this.month,
    this.day,
    this.hours,
    this.minutes,
    this.seconds,
  });

  CreatedDate.fromJson(Map<String, dynamic> json) {
    year = json['year'] as int?;
    month = json['month'] as int?;
    day = json['day'] as int?;
    hours = json['hours'] as int?;
    minutes = json['minutes'] as int?;
    seconds = json['seconds'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['year'] = year;
    json['month'] = month;
    json['day'] = day;
    json['hours'] = hours;
    json['minutes'] = minutes;
    json['seconds'] = seconds;
    return json;
  }
}

class ModifiedDate {
  int? year;
  int? month;
  int? day;
  int? hours;
  int? minutes;
  int? seconds;

  ModifiedDate({
    this.year,
    this.month,
    this.day,
    this.hours,
    this.minutes,
    this.seconds,
  });

  ModifiedDate.fromJson(Map<String, dynamic> json) {
    year = json['year'] as int?;
    month = json['month'] as int?;
    day = json['day'] as int?;
    hours = json['hours'] as int?;
    minutes = json['minutes'] as int?;
    seconds = json['seconds'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['year'] = year;
    json['month'] = month;
    json['day'] = day;
    json['hours'] = hours;
    json['minutes'] = minutes;
    json['seconds'] = seconds;
    return json;
  }
}
