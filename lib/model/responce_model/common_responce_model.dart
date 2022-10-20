class CommonResponceModel {
  final int? code;
  final String? msg;

  CommonResponceModel({
    this.code,
    this.msg,
  });

  CommonResponceModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {'code': code, 'msg': msg};
}
