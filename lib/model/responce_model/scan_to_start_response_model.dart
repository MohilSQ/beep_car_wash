class ScanToStartResponseModel {
  final int? code;
  final Data? data;

  ScanToStartResponseModel({
    this.code,
    this.data,
  });

  ScanToStartResponseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        data = (json['data'] as Map<String, dynamic>?) != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {'code': code, 'data': data?.toJson()};
}

class Data {
  final int? isMachineStart;
  final StartMachineDetail? data;

  Data({
    this.isMachineStart,
    this.data,
  });

  Data.fromJson(Map<String, dynamic> json)
      : isMachineStart = json['is_machine_start'] as int?,
        data = (json['data'] as Map<String, dynamic>?) != null ? StartMachineDetail.fromJson(json['data'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {
        'is_machine_start': isMachineStart,
        'data': data?.toJson(),
      };
}

class StartMachineDetail {
  final String? washId;
  final String? washTimer;
  final String? washStart;

  StartMachineDetail({
    this.washId,
    this.washTimer,
    this.washStart,
  });

  StartMachineDetail.fromJson(Map<String, dynamic> json)
      : washId = json['wash_id'] as String?,
        washTimer = json['wash_timer'] as String?,
        washStart = json['wash_start'] as String?;

  Map<String, dynamic> toJson() => {
        'wash_id': washId,
        'wash_timer': washTimer,
        'wash_start': washStart,
      };
}
