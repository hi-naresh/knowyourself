import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/text_strings.dart';


class FeedBackController extends GetxController {
  static FeedBackController get instance => Get.find();
  final RxString feedback = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isSent = false.obs;
  final textController = TextEditingController();

  void setFeedback() {
    feedback.value = textController.text;
  }

  Future<void> sendFeedback() async {
    if (feedback.value.isEmpty) {
      Get.snackbar(KTexts.error, KTexts.pleaseEnterFeedback);
      return;
    }

    isLoading.value = true;
    try {
      var response = await http.post(
          Uri.parse('https://script.google.com/macros/s/AKfycbwfIgc821t9AG_fGtUWOQ543FuyMg684v7TGvQbn_z9rGIZ2wohimhq5kkKI7sslQw/exec'),
          body: jsonEncode({
            'user': 'Anonymous',
            'message': feedback.value
          }),
          headers: {'Content-Type': 'application/json'}
      );

      isLoading.value = false;
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['result'] == 'Success') {
        isSent.value = true;
        Get.back();
        Get.snackbar(KTexts.success, KTexts.thankYouFeedback);
      } else {
        print(data);
        Get.snackbar(KTexts.error, "${KTexts.failedToSendFeedback}: ${data['error']}");

      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(KTexts.error, "${KTexts.genericErrorMessage}: $e");
    }
  }


  // void sendFeedback() {
  //   if (feedback.value.isEmpty) {
  //     KHelper.showSnackBar("Please enter your feedback", "Empty feedback not allowed !");
  //     return;
  //   }
  //   isLoading.value = true;
  //   Future.delayed(const Duration(seconds: 2), () {
  //     isLoading.value = false;
  //     isSent.value = true;
  //   });
  //   Get.back();
  //   KHelper.showSnackBar("Feedback sent", "Thank you for your feedback !");
  // }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

}