class UploadProfileImage {
  final int? code;
  final String? msg;
  final String? avatar;

  UploadProfileImage({
    this.code,
    this.msg,
    this.avatar,
  });

  UploadProfileImage.fromJson(Map<String, dynamic> json)
    : code = json['code'] as int?,
      msg = json['msg'] as String?,
      avatar = json['avatar'] as String?;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'msg' : msg,
    'avatar' : avatar
  };
}