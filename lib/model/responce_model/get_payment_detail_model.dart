class GetPaymentDetailsModel {
  final int? code;
  final String? msg;
  List<Data>? data;

  GetPaymentDetailsModel({
    this.code,
    this.msg,
    this.data,
  });

  GetPaymentDetailsModel copyWith({
    int? code,
    String? msg,
    List<Data>? data,
  }) {
    return GetPaymentDetailsModel(
      code: code ?? this.code,
      msg: msg ?? this.msg,
      data: data ?? this.data,
    );
  }

  GetPaymentDetailsModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        msg = json['msg'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'code': code, 'msg': msg, 'data': data?.map((e) => e.toJson()).toList()};
}

class Data {
  final String? id;
  final String? brand;
  final String? last4;
  final String? custToken;
  final String? cardToken;
  final String? sourceType;
  String? primaryCard;

  Data({
    this.id,
    this.brand,
    this.last4,
    this.custToken,
    this.cardToken,
    this.sourceType,
    this.primaryCard,
  });

  Data copyWith({
    String? id,
    String? brand,
    String? last4,
    String? custToken,
    String? cardToken,
    String? sourceType,
    String? primaryCard,
  }) {
    return Data(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      last4: last4 ?? this.last4,
      custToken: custToken ?? this.custToken,
      cardToken: cardToken ?? this.cardToken,
      sourceType: sourceType ?? this.sourceType,
      primaryCard: primaryCard ?? this.primaryCard,
    );
  }

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        brand = json['brand'] as String?,
        last4 = json['last4'] as String?,
        custToken = json['cust_token'] as String?,
        cardToken = json['card_token'] as String?,
        sourceType = json['source_type'] as String?,
        primaryCard = json['primary_card'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand': brand,
        'last4': last4,
        'cust_token': custToken,
        'card_token': cardToken,
        'source_type': sourceType,
        'primary_card': primaryCard,
      };
}
