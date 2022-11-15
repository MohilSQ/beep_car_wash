class MachinesResponseModel {
  final int? code;
  final List<Data>? data;

  MachinesResponseModel({
    this.code,
    this.data,
  });

  MachinesResponseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

class Data {
  final String? id;
  final String? machineName;
  final String? lat;
  final String? long;
  final String? cityName;

  Data({
    this.id,
    this.machineName,
    this.lat,
    this.long,
    this.cityName,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        machineName = json['machine_name'] as String?,
        lat = json['lat'] as String?,
        long = json['long'] as String?,
        cityName = json['city_name'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'machine_name': machineName,
        'lat': lat,
        'long': long,
        'city_name': cityName,
      };
}
