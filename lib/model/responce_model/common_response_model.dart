class CommonResponseModel {
  final int? code;
  final String? msg;

  CommonResponseModel({
    this.code,
    this.msg,
  });

  CommonResponseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {'code': code, 'msg': msg};
}
