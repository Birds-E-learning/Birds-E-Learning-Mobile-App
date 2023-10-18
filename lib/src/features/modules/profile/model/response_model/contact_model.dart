class ContactDetailsModel {
  final String? responseCode;
  final String? responseMessage;
  final ContactData? responseData;

  ContactDetailsModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  ContactDetailsModel.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?,
        responseData = (json['responseData'] as Map<String,dynamic>?) != null ? ContactData.fromJson(json['responseData'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'responseMessage' : responseMessage,
    'responseData' : responseData?.toJson()
  };
}

class ContactData {
  final String? adminEmail;
  final String? emailFromName;
  final String? emailFromAddress;
  final String? contactPhone;
  final String? contactFax;
  final String? contactLocation;

  ContactData({
    this.adminEmail,
    this.emailFromName,
    this.emailFromAddress,
    this.contactPhone,
    this.contactFax,
    this.contactLocation,
  });

  ContactData.fromJson(Map<String, dynamic> json)
      : adminEmail = json['adminEmail'] as String?,
        emailFromName = json['emailFromName'] as String?,
        emailFromAddress = json['emailFromAddress'] as String?,
        contactPhone = json['contactPhone'] as String?,
        contactFax = json['contactFax'] as String?,
        contactLocation = json['contactLocation'] as String?;

  Map<String, dynamic> toJson() => {
    'adminEmail' : adminEmail,
    'emailFromName' : emailFromName,
    'emailFromAddress' : emailFromAddress,
    'contactPhone' : contactPhone,
    'contactFax' : contactFax,
    'contactLocation' : contactLocation
  };
}