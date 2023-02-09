class UserDataModel {
  String? profileImage;
  String? firstName;
  String? lastName;
  String? cCode;
  String? phoneNumber;
  String? email;
  String? token;
   String? referralCode;

  UserDataModel({
    this.profileImage = "",
    this.firstName = "",
    this.lastName = "",
    this.cCode = "",
    this.phoneNumber = "",
    this.email = "",
    this.token = "",
  this.referralCode = "",
  });

  UserDataModel.fromJson(Map<String, dynamic> json)
      : profileImage = json['profileImage'] as String?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        cCode = json['cCode'] as String?,
        phoneNumber = json['phoneNumber'] as String?,
        email = json['email'] as String?,
        token = json['token'] as String?,
        referralCode = json['referral_code'] as String?;

  Map<String, dynamic> toJson() => {
        'profileImage': profileImage,
        'firstName': firstName,
        'lastName': lastName,
        'cCode': cCode,
        'phoneNumber': phoneNumber,
        'email': email,
        'token': token,
    'referral_code': referralCode,
      };
}
