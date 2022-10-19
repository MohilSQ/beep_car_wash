class OTPVerificationModel {
  final int? code;
  final String? msg;
  final int? isNewUser;
  final UserDetail? userDetail;
  final String? token;

  OTPVerificationModel({
    this.code,
    this.msg,
    this.isNewUser,
    this.userDetail,
    this.token,
  });

  OTPVerificationModel.fromJson(Map<String, dynamic> json)
    : code = json['code'] as int?,
      msg = json['msg'] as String?,
      isNewUser = json['is_new_user'] as int?,
      userDetail = (json['user_detail'] as Map<String,dynamic>?) != null ? UserDetail.fromJson(json['user_detail'] as Map<String,dynamic>) : null,
      token = json['token'] as String?;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'msg' : msg,
    'is_new_user' : isNewUser,
    'user_detail' : userDetail?.toJson(),
    'token' : token
  };
}

class UserDetail {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? referralCode;

  UserDetail({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.referralCode,
  });

  UserDetail.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      name = json['name'] as String?,
      email = json['email'] as String?,
      phone = json['phone'] as String?,
      avatar = json['avatar'] as String?,
      referralCode = json['referral_code'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'email' : email,
    'phone' : phone,
    'avatar' : avatar,
    'referral_code' : referralCode
  };
}