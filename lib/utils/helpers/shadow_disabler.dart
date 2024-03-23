import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomShadow {
  static final RxBool _disableShadows = false.obs;

  static set disableShadows(bool value) => _disableShadows.value = value;
  static bool get disableShadows => _disableShadows.value;

  static List<BoxShadow> getShadow(List<BoxShadow>? shadows) {
    return _disableShadows.value ? [] : (shadows ?? []);
  }
}
