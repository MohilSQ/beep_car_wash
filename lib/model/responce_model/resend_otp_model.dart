class ResendOTPModel {
  final int? code;
  final String? msg;

  ResendOTPModel({
    this.code,
    this.msg,
  });

  ResendOTPModel.fromJson(Map<String, dynamic> json)
    : code = json['code'] as int?,
      msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'msg' : msg
  };
}