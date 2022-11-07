class HtmlViewModel {
  final int? code;
  final String? pageContent;

  HtmlViewModel({
    this.code,
    this.pageContent,
  });

  HtmlViewModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        pageContent = json['page_content'] as String?;

  Map<String, dynamic> toJson() => {'code': code, 'page_content': pageContent};
}
