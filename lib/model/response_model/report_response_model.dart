class GetReportOptionResponseModel {
  final int? code;
  final List<Data>? data;

  GetReportOptionResponseModel({
    this.code,
    this.data,
  });

  GetReportOptionResponseModel copyWith({
    int? code,
    List<Data>? data,
  }) {
    return GetReportOptionResponseModel(
      code: code ?? this.code,
      data: data ?? this.data,
    );
  }

  GetReportOptionResponseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'code': code, 'data': data?.map((e) => e.toJson()).toList()};
}

class Data {
  final String? id;
  final String? issue;
  bool? isSelected;
  Data({
    this.id,
    this.issue,
    this.isSelected,
  });

  Data copyWith({
    String? id,
    String? issue,
    bool? isSelected,
  }) {
    return Data(
      id: id ?? this.id,
      isSelected: isSelected ?? this.isSelected,
      issue: issue ?? this.issue,
    );
  }

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        isSelected = json['isSelected'] as bool?,
        issue = json['issue'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'issue': issue, "isSelected": isSelected};
}
