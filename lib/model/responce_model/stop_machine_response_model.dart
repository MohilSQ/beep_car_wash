class StopMachineResponseModel {
  final int? code;
  Data? data;

  StopMachineResponseModel({
    this.code,
    this.data,
  });

  StopMachineResponseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        data = (json['data'] as Map<String, dynamic>?) != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {'code': code, 'data': data?.toJson()};
}

class Data {
  final String? washTime;
  final String? amount;
  final String? paymentSourceType;
  final String? address;
  final String? machineLat;
  final String? machineLong;
  final int? isPaid;

  Data({
    this.washTime,
    this.amount,
    this.paymentSourceType,
    this.address,
    this.machineLat,
    this.machineLong,
    this.isPaid,
  });

  Data.fromJson(Map<String, dynamic> json)
      : washTime = json['wash_time'] as String?,
        amount = json['amount'] as String?,
        paymentSourceType = json['payment_source_type'] as String?,
        address = json['address'] as String?,
        machineLat = json['machine_lat'] as String?,
        machineLong = json['machine_long'] as String?,
        isPaid = json['isPaid'] as int?;

  Map<String, dynamic> toJson() => {
        'wash_time': washTime,
        'amount': amount,
        'payment_source_type': paymentSourceType,
        'address': address,
        'machine_lat': machineLat,
        'machine_long': machineLong,
      };
}
