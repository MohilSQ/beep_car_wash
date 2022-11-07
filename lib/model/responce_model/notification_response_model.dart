class NotificationResponseModel {
  final int? code;
  final String? msg;
  final int? totalRecords;
  final int? limitPerPage;
  final String? notifUrl;
  List<Data>? data = [];

  NotificationResponseModel({
    this.code,
    this.msg,
    this.totalRecords,
    this.limitPerPage,
    this.notifUrl,
    this.data,
  });

  NotificationResponseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        msg = json['msg'] as String?,
        totalRecords = json['total_records'] as int?,
        limitPerPage = json['limit_per_page'] as int?,
        notifUrl = json['notif_url'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'msg': msg,
        'total_records': totalRecords,
        'limit_per_page': limitPerPage,
        'notif_url': notifUrl,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

class Data {
  final String? notifTitle;
  final String? notifBody;
  final String? image;
  final String? notifUrl;
  final String? createdAt;

  Data({
    this.notifTitle,
    this.notifBody,
    this.image,
    this.notifUrl,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json)
      : notifTitle = json['notif_title'] as String?,
        notifBody = json['notif_body'] as String?,
        image = json['image'] as String?,
        notifUrl = json['notif_url'] as String?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
        'notif_title': notifTitle,
        'notif_body': notifBody,
        'image': image,
        'notif_url': notifUrl,
        'created_at': createdAt,
      };
}
