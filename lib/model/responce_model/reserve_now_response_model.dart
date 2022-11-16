class ReserveNowResponseModel {
  final int? code;
  final Data? data;

  ReserveNowResponseModel({
    this.code,
    this.data,
  });

  ReserveNowResponseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        data = (json['data'] as Map<String, dynamic>?) != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data?.toJson(),
      };
}

class Data {
  final int? isAvailable;
  final ReserveDetail? data;

  Data({
    this.isAvailable,
    this.data,
  });

  Data.fromJson(Map<String, dynamic> json)
      : isAvailable = json['is_available'] as int?,
        data = (json['data'] as Map<String, dynamic>?) != null ? ReserveDetail.fromJson(json['data'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {
        'is_available': isAvailable,
        'data': data?.toJson(),
      };
}

class ReserveDetail {
  final String? reserveId;
  final String? reserveTimer;
  final String? reserveStart;

  ReserveDetail({
    this.reserveId,
    this.reserveTimer,
    this.reserveStart,
  });

  ReserveDetail.fromJson(Map<String, dynamic> json)
      : reserveId = json['reserve_id'] as String?,
        reserveTimer = json['reserve_timer'] as String?,
        reserveStart = json['reserve_start'] as String?;

  Map<String, dynamic> toJson() => {
        'reserve_id': reserveId,
        'reserve_timer': reserveTimer,
        'reserve_start': reserveStart,
      };
}
