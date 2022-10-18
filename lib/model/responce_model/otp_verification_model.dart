class OTPVerificationModel {
  final int? code;
  final String? msg;
  final int? isNewUser;
  final String? token;

  OTPVerificationModel({
    this.code,
    this.msg,
    this.isNewUser,
    this.token,
  });

  OTPVerificationModel.fromJson(Map<String, dynamic> json)
    : code = json['code'] as int?,
      msg = json['msg'] as String?,
      isNewUser = json['is_new_user'] as int?,
      token = json['token'] as String?;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'msg' : msg,
    'is_new_user' : isNewUser,
    'token' : token
  };
}