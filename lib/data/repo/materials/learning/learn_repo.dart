// // import 'dart:convert';
// //
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';
// // import 'package:get_storage/get_storage.dart';
// //
// // import '../../../../features/learning/model/chapter_model.dart';
// //
// // class LearnRepo extends GetxService {
// //   static LearnRepo get instance => Get.find();
// //   final GetStorage _storage = GetStorage();
// //   final String _storageKey = 'learningMaterials';
// //
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     print(_storage.read(_storageKey));
// //     _initializeLearningMaterials();
// //   }
// //
// //   //save learning progress to local storage in double
// //   void saveLearningProgress(String id, double progress) {
// //     var materials = _getLearningMaterialsFromStorage();
// //     var materialIndex = materials.indexWhere((material) => material.id == id);
// //     if (materialIndex != -1) {
// //       var material = materials[materialIndex];
// //       material = material.copyWith(progress: progress);
// //       materials[materialIndex] = material;
// //       _storage.write(_storageKey, jsonEncode(materials.map((e) => e.toMap()).toList()));
// //     }
// //   }
// //
// //   List<LearningChapters> _getLearningMaterialsFromStorage() {
// //     var materialsJsonString = _storage.read(_storageKey);
// //     if (materialsJsonString != null) {
// //       List<dynamic> materialsJson = jsonDecode(materialsJsonString);
// //       List<LearningChapters> materials = materialsJson.map((materialMap) {
// //         return LearningChapters.fromMap(materialMap);
// //       }).toList();
// //       return materials;
// //     } else {
// //       return [];
// //     }
// //   }
// //
// //   void _initializeLearningMaterials() {
// //     var materials = _getLearningMaterialsFromStorage();
// //     if (materials.isEmpty) {
// //       //for each aspect
// //       loadMaterialsFromJson();
// //     }
// //   }
// //
// //   Future<void> loadMaterialsFromJson() async {
// //     final String chaptersJsonString = await rootBundle.loadString('assets/chapters/chapters.json');
// //     final Map<String, dynamic> chaptersJson = json.decode(chaptersJsonString);
// //     final List<dynamic> chaptersJsonList = chaptersJson['LearningChapters'];
// //
// //     final List<LearningChapters> chaptersList = chaptersJsonList
// //         .map((chapter) => LearningChapters.fromMap(chapter))
// //         .toList();
// //
// //     _storage.write(_storageKey, jsonEncode(chaptersList.map((e) => e.toMap()).toList()));
// //   }
// //
// //   //sync from firestore to local storage
// //   Future<void> syncLearningMaterials() async {
// //     // sync learning materials from firestore
// //   }
// //
// //   Future<List<LearningChapters>> loadMaterialsForAspect(String aspect) async {
// //     var materials = _getLearningMaterialsFromStorage();
// //     return materials.where((material) => material.aspect == aspect ).toList();
// //   }
// // }
//
// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../../../../features/learning/model/chapter_model.dart';
// import '../../../../utils/constants/enums.dart';
//
// class LearnRepo extends GetxService {
//   static LearnRepo get instance => Get.find();
//   final GetStorage _storage = GetStorage();
//   final String _storageKey = 'learningMaterials';
//
//   @override
//   void onInit() {
//     super.onInit();
//     // _initializeLearningMaterials();
//   }
//
//   // Future<void> _initializeLearningMaterials() async {
//   //   var materials = _getLearningMaterialsFromStorage();
//   //   if (materials.isEmpty) {
//   //     //for each aspect
//   //     await loadMaterialsFromJson('physical');
//   //     await loadMaterialsFromJson('mental');
//   //     await loadMaterialsFromJson('emotional');
//   //     await loadMaterialsFromJson('spiritual');
//   //   }
//   // }
//
//   void saveLearningProgress(String id, double progress) {
//     var materials = _getLearningMaterialsFromStorage();
//     var materialIndex = materials.indexWhere((material) => material.id == id);
//     if (materialIndex != -1) {
//       materials[materialIndex] = materials[materialIndex].copyWith(progress: progress);
//       _storage.write(_storageKey, jsonEncode(materials.map((e) => e.toMap()).toList()));
//     }
//   }
//
//   List<LearningChapters> _getLearningMaterialsFromStorage() {
//     var materialsJsonString = _storage.read(_storageKey);
//     if (materialsJsonString != null) {
//       return (jsonDecode(materialsJsonString) as List)
//           .map((materialMap) => LearningChapters.fromMap(materialMap as Map<String, dynamic>))
//           .toList();
//     } else {
//       return [];
//     }
//   }
//
//
//   Future<void> loadMaterialsFromJson(String aspect) async {
//     final String chaptersJsonString = await rootBundle.loadString('assets/chapters/chapters.json');
//     final Map<String, dynamic> chaptersJson = json.decode(chaptersJsonString);
//     final List<dynamic> chaptersJsonList = chaptersJson['LearningChapters'];
//
//     final List<LearningChapters> chaptersList = chaptersJsonList
//         .map((chapter) => LearningChapters.fromMap(chapter))
//         .where((chapter) => chapter.aspect.toString().split('.').last == aspect)
//         .toList();
//
//     _storage.write(_storageKey, jsonEncode(chaptersList.map((e) => e.toMap()).toList()));
//
//   }
//
//
//
//   Future<List<LearningChapters>> loadMaterialsForAspect(String aspect) async {
//     await loadMaterialsFromJson(aspect);
//     var materials = _getLearningMaterialsFromStorage();
//
//     final filteredList = materials
//         .where((chapter) => chapter.aspect.toString().split('.').last == aspect)
//         .toList();
//     return filteredList;
//   }
//
//
// }

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../features/learning/model/chapter_model.dart';
import '../../../../utils/constants/enums.dart';

class LearnRepo extends GetxService {
  static LearnRepo get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'learningMaterials';

  @override
  void onInit() {
    super.onInit();
    _initializeLearningMaterials();
  }

  Future<void> _initializeLearningMaterials() async {
    if (_getLearningMaterialsFromStorage().isEmpty) {
      await loadMaterialsFromJson('physical');
      await loadMaterialsFromJson('mental');
      await loadMaterialsFromJson('emotional');
      await loadMaterialsFromJson('spiritual');
    }
  }

  void saveLearningProgress(String id, double progress) {
    var materials = _getLearningMaterialsFromStorage();
    var materialIndex = materials.indexWhere((material) => material.id == id);
    if (materialIndex != -1) {
      materials[materialIndex] = materials[materialIndex].copyWith(progress: progress);
      _storage.write(_storageKey, jsonEncode(materials.map((e) => e.toMap()).toList()));
    }
  }

  List<LearningChapters> _getLearningMaterialsFromStorage() {
    var materialsJsonString = _storage.read(_storageKey);
    if (materialsJsonString != null) {
      return (jsonDecode(materialsJsonString) as List)
          .map((materialMap) => LearningChapters.fromMap(materialMap as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> loadMaterialsFromJson(String aspect) async {
    final String chaptersJsonString = await rootBundle.loadString('assets/chapters/chapters.json');
    final List<dynamic> chaptersJsonList = json.decode(chaptersJsonString)['LearningChapters'];

    final List<LearningChapters> chaptersList = chaptersJsonList
        .map((chapter) => LearningChapters.fromMap(chapter as Map<String, dynamic>))
        .where((chapter) => chapter.aspect.toString().split('.').last == aspect)
        .toList();

    _storage.write(_storageKey, jsonEncode(chaptersList.map((e) => e.toMap()).toList()));
  }

  Future<List<LearningChapters>> loadMaterialsForAspect(String aspect) async {
    // _storage.remove(_storageKey);
    var materials = _getLearningMaterialsFromStorage();
    return materials.where((chapter) => chapter.aspect.toString().split('.').last == aspect).toList();
  }
}
