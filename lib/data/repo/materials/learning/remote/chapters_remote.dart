import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/features/learning/model/resources_model.dart';
import 'package:http/http.dart' as http;
import '../../../../../features/learning/model/chapter_model.dart';
import '../../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../../utils/exceptions/format_exceptions.dart';
import '../../../../../utils/exceptions/platform_exceptions.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class ChaptersOnline extends GetxService{
  static ChaptersOnline get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'chapters';
  final FirebaseFirestore _onlineDB = FirebaseFirestore.instance;


  @override
  Future<void> onInit() async {
    super.onInit();
  }

  // Future<void> saveExternalResources(List<String> resources) async {
  //   await _storage.write(_storageKey, resources);
  // }

  Future<List<ChapterModel>> fetchResourcesFromFirestore() async {
    try {
      final chapters = await _onlineDB.collection('chapters').get();
      return chapters.docs.map((e) => ChapterModel.fromJson(e.data())).toList();
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }


  // Future<List<ChapterModel>> getExternalResources() async {
  //   var resources = _storage.read(_storageKey);
  //   if (resources is List<String>) {
  //     return resources.map((e) => ChapterModel.fromJson(jsonDecode(e))).toList();
  //   }
  //   return [];
  // }

  Future<void> clearExternalResources() async {
    await _storage.remove(_storageKey);
  }

  @override
  void onClose() {
    super.onClose();
  }
}