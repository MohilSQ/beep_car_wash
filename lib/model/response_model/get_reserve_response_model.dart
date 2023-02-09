class GetReserveResponseModel {
  final int? code;
  final String? machineId;
  final String? tagline;

  GetReserveResponseModel({
    this.code,
    this.machineId,
    this.tagline,
  });

  GetReserveResponseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        machineId = json['machine_id'] as String?,
        tagline = json['tagline'] as String?;

  Map<String, dynamic> toJson() => {
        'code': code,
        'machine_id': machineId,
        'tagline': tagline,
      };
}
