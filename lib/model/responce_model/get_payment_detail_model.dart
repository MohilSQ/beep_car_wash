class GetPaymentDetailsModel {
  final int? code;
  final String? msg;
  final String? currnetBlance;
  final int? freeWashes;
  final String? discountAvailable;
  final List<Data>? data;

  GetPaymentDetailsModel({
    this.code,
    this.msg,
    this.currnetBlance,
    this.freeWashes,
    this.discountAvailable,
    this.data,
  });

  GetPaymentDetailsModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        msg = json['msg'] as String?,
        currnetBlance = json['currnet_blance'] as String?,
        freeWashes = json['free_washes'] as int?,
        discountAvailable = json['discount_available'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'code' : code,
    'msg' : msg,
    'currnet_blance' : currnetBlance,
    'free_washes' : freeWashes,
    'discount_available' : discountAvailable,
    'data' : data?.map((e) => e.toJson()).toList()
  };
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

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        brand = json['brand'] as String?,
        last4 = json['last4'] as String?,
        custToken = json['cust_token'] as String?,
        cardToken = json['card_token'] as String?,
        sourceType = json['source_type'] as String?,
        primaryCard = json['primary_card'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'brand' : brand,
    'last4' : last4,
    'cust_token' : custToken,
    'card_token' : cardToken,
    'source_type' : sourceType,
    'primary_card' : primaryCard
  };
}