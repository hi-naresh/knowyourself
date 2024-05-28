import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/data/repo/materials/learning/remote/chapters_remote.dart';
import 'package:knowyourself/features/learning/model/chapter_model.dart';
import 'package:knowyourself/features/learning/model/resources_model.dart';
import 'package:knowyourself/utils/constants/enums.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';


class ChaptersRepo extends GetxService{
  static ChaptersRepo get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'chapters';
  // final onlineRepo = Get.put(ChaptersOnline());
  // final RxLi

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> saveExternalResources(List<ChapterModel> chapters) async {
    await _storage.write(_storageKey, chapters);
    print("saved : ${_storage.read(_storageKey)}");
    // saved : [ChapterModel{id: 1, title: What is Mind, subTitle: The mind is a tool for evolution, reflecting various aspects of existence., progress: 0.0, contentChunks: [The mind, as beautifully illustrated by Sri Aurobindo, is like a multifaceted gem, reflecting various aspects of existence. At its core, the mind is not just a simple entity but a complex weave of different layers, each layer contributing to our understanding and interaction with the world around us., The mind, in its essence, is a tool for evolution, a medium through which we, as beings, can grow and develop. It's the bridge between the simple, often automatic reactions of life and the luminous realm of the spirit. Each layer of the mind has its unique purpose and characteristics, creating a tapestry of consciousness that allows us to experience and interpret the richness of life., Sri Aurobindo's insight into the mind's hierarchy is a way of understanding its structure and functions. It's a reminder that within us lies <…>}]
  }


  Future<List<ChapterModel>> getExternalResources() async {
    var allData = _storage.read(_storageKey);
    // print(allData);
    if (allData != null) {
      List<ChapterModel> chapters = allData.map<ChapterModel>((chapter) => ChapterModel.fromMap(chapter)).toList();
      return chapters;
    }
    return [];
  }


  Future<void> clearExternalResources() async {
    await _storage.remove(_storageKey);
    print("cleared");
  }

}