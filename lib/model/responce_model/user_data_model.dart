class UserDataModel {
  String? firstName;
  String? lastName;
  String? cconde;
  String? phoneNumber;
  String? email;
  String? token;

  UserDataModel({
    this.firstName,
    this.lastName,
    this.cconde,
    this.phoneNumber,
    this.email,
    this.token,
  });

  UserDataModel.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        cconde = json['cconde'] as String?,
        phoneNumber = json['phoneNumber'] as String?,
        email = json['email'] as String?,
        token = json['token'] as String?;

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'cconde': cconde,
        'phoneNumber': phoneNumber,
        'email': email,
        'token': token,
      };
}
