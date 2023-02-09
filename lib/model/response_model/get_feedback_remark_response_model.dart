class GetFeedbackRemarkModel {
  final int? code;
  final List<Data>? data;

  GetFeedbackRemarkModel({
    this.code,
    this.data,
  });

  GetFeedbackRemarkModel copyWith({
    int? code,
    List<Data>? data,
  }) {
    return GetFeedbackRemarkModel(
      code: code ?? this.code,
      data: data ?? this.data,
    );
  }

  GetFeedbackRemarkModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'code': code, 'data': data?.map((e) => e.toJson()).toList()};
}

class Data {
  final String? id;
  final String? remark;

  Data({
    this.id,
    this.remark,
  });

  Data copyWith({
    String? id,
    String? remark,
  }) {
    return Data(
      id: id ?? this.id,
      remark: remark ?? this.remark,
    );
  }

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        remark = json['remark'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'remark': remark};
}
