import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/features/learning/model/resources_model.dart';
import 'package:http/http.dart' as http;
import '../../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../../utils/exceptions/format_exceptions.dart';
import '../../../../../utils/exceptions/platform_exceptions.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnlineResources extends GetxService{
  static OnlineResources get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'online_resources';
  final FirebaseFirestore _onlineDB = FirebaseFirestore.instance;


  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> saveExternalResources(List<String> resources) async {
    await _storage.write(_storageKey, resources);
  }

  Future<void> saveResourcesToFirestore(List<ResourcesModel> resources) async {
    try {
      for (var resource in resources) {
        print('Saving resource: ${resource.id}');
        await _onlineDB.collection('resources').doc(resource.id).set(resource.toJson());
        print('Successfully saved resource: ${resource.id}');
      }
      // return resources;
    } on FirebaseException catch (e) {
      Get.snackbar("Firebase Error", "A Firebase error occurred: ${e.message}, Code: ${e.code}");
      throw Exception('FirebaseException during Firestore operation: ${e.message}');
    } on FormatException catch (e) {
      Get.snackbar("Format Error", "Invalid format: ${e.message}");
      throw Exception('FormatException: ${e.message}');
    } on PlatformException catch (e) {
      Get.snackbar("Platform Error", "A platform error occurred: ${e.message}");
      throw Exception('PlatformException: ${e.message}');
    } catch (e, s) {
      Get.snackbar("Error", "An unexpected error occurred: $e");
      throw Exception('Unhandled error during Firestore operation: $e');
    }
  }

  Future<List<ResourcesModel>> fetchResourcesFromFirestore() async {
    try {
      final resources = await _onlineDB.collection('resources').get();
      return resources.docs.map((e) => ResourcesModel.fromJson(e.data())).toList();
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


  Future<List<ResourcesModel>> getExternalResources() async {
    var resources = _storage.read(_storageKey);
    if (resources is List<String>) {
      return resources.map((e) => ResourcesModel.fromJson(jsonDecode(e))).toList();
    }
    return [];
  }

  Future<void> clearExternalResources() async {
    await _storage.remove(_storageKey);
  }

  @override
  void onClose() {
    super.onClose();
  }
}