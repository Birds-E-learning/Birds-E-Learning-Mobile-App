class LoginResponse {
  final String? responseCode;
  final String? responseMessage;
  final ResponseData? responseData;

  LoginResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  LoginResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?,
        responseData = (json['responseData'] as Map<String,dynamic>?) != null ? ResponseData.fromJson(json['responseData'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'responseMessage' : responseMessage,
    'responseData' : responseData?.toJson()
  };
}

class ResponseData {
  final String? userId;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? fullName;
  final String? address;
  final dynamic mobileNumber;
  final String? status;
  final dynamic dateOfBirth;
  final dynamic lastLoginDate;
  final String? photoLink;
  final dynamic createdDate;
  final dynamic modifiedDate;
  final String? deviceId;
  final String? geoLocation;
  final String? gender;
  final String? language;
  final String? city;
  final String? country;
  final String? authToken;
  final SubscriptionModel? subscription;

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
    this.subscription,
  });

  ResponseData.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as String?,
        username = json['username'] as String?,
        email = json['email'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        middleName = json['middleName'] as String?,
        fullName = json['fullName'] as String?,
        address = json['address'] as String?,
        mobileNumber = json['mobileNumber'] as dynamic,
        status = json['status'] as String?,
        dateOfBirth = json['dateOfBirth'] as dynamic,
        lastLoginDate = json['lastLoginDate'] as dynamic,
        photoLink = json['photoLink'] as String?,
        createdDate = json['createdDate'] as dynamic,
        modifiedDate = json['modifiedDate'] as dynamic,
        deviceId = json['deviceId'] as String?,
        geoLocation = json['geoLocation'] as String?,
        gender = json['gender'] as String?,
        language = json['language'] as String?,
        city = json['city'] as String?,
        country = json['country'] as String?,
        authToken = json['authToken'] as String?,
        subscription = (json['subscription'] as Map<String,dynamic>?) != null ? SubscriptionModel.fromJson(json['subscription'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'username' : username,
    'email' : email,
    'firstName' : firstName,
    'lastName' : lastName,
    'middleName' : middleName,
    'fullName' : fullName,
    'address' : address,
    'mobileNumber' : mobileNumber,
    'status' : status,
    'dateOfBirth' : dateOfBirth,
    'lastLoginDate' : lastLoginDate,
    'photoLink' : photoLink,
    'createdDate' : createdDate,
    'modifiedDate' : modifiedDate,
    'deviceId' : deviceId,
    'geoLocation' : geoLocation,
    'gender' : gender,
    'language' : language,
    'city' : city,
    'country' : country,
    'authToken' : authToken,
    'subscription' : subscription?.toJson()
  };
}


class SubscriptionModel {
  final String? userId;
  final String? userEmail;
  final dynamic subscriptionId;
  final String? subscriptionSlug;
  final String? createdAt;
  final dynamic updatedAt;
  final String? subscribedAt;
  final String? expirationAt;
  final String? status;
  final dynamic amount;
  final String? currency;
  final String? package;

  SubscriptionModel({
    this.userId,
    this.userEmail,
    this.subscriptionId,
    this.subscriptionSlug,
    this.createdAt,
    this.updatedAt,
    this.subscribedAt,
    this.expirationAt,
    this.status,
    this.amount,
    this.currency,
    this.package
  });

  SubscriptionModel.fromJson(Map<String, dynamic> json)
        : userId = json['userId'] as String?,
    userEmail = json['userEmail'] as String?,
    subscriptionId = json['subscriptionId'] as dynamic,
    subscriptionSlug = json['subscriptionSlug'] as String?,
    createdAt = json['createdAt'] as String?,
    updatedAt = json['updatedAt'] as dynamic,
    subscribedAt = json['subscribedAt'] as String?,
    expirationAt = json['expirationAt'] as String?,
    amount = json['amount'] as dynamic,
    package = json['package'] as String?,
    currency = json['currency'] as String?,
    status = json['status'] as String?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'userEmail' : userEmail,
    'subscriptionId' : subscriptionId,
    'subscriptionSlug' : subscriptionSlug,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    'subscribedAt' : subscribedAt,
    'expirationAt' : expirationAt,
    'status' : status,
    'amount' : amount,
    'currency' : currency,
    'package' : package,
  };
}

