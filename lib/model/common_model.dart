import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonModel {
  int? index = 0;
  String? image = '';
  String? title = '';
  String? subtitle = '';
  RxBool? isSelected = false.obs;
  Widget? screen;
  Bindings? bindings;

  CommonModel({
    this.index,
    this.image,
    this.title,
    this.subtitle,
    this.isSelected,
    this.screen,
    this.bindings,
  });

  factory CommonModel.fromDocument(CommonModel document) {
    return CommonModel(
      index: document.index,
      image: document.image,
      title: document.title,
      subtitle: document.subtitle,
      isSelected: document.isSelected,
      screen: document.screen,
      bindings: document.bindings,
    );
  }
}
