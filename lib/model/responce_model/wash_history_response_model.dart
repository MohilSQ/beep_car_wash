class WashHistoryResponseModel {
  final int? code;
  final String? msg;
  final List<Data>? data;

  WashHistoryResponseModel({
    this.code,
    this.msg,
    this.data,
  });

  WashHistoryResponseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        msg = json['msg'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'msg': msg,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

class Data {
  final String? washStart;
  final String? washEnd;
  final String? totalUsedMints;
  final String? amount;
  final String? address;

  Data({
    this.washStart,
    this.washEnd,
    this.totalUsedMints,
    this.amount,
    this.address,
  });

  Data.fromJson(Map<String, dynamic> json)
      : washStart = json['wash_start'] as String?,
        washEnd = json['wash_end'] as String?,
        totalUsedMints = json['total_used_mints'] as String?,
        amount = json['amount'] as String?,
        address = json['address'] as String?;

  Map<String, dynamic> toJson() => {
        'wash_start': washStart,
        'wash_end': washEnd,
        'total_used_mints': totalUsedMints,
        'amount': amount,
        'address': address,
      };
}
