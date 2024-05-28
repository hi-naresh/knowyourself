import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/features/learning/model/resources_model.dart';
import 'package:knowyourself/utils/constants/enums.dart';

import '../remote/resources_online.dart';

class ResourcesRepo extends GetxService{
  static ResourcesRepo get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'local_resources';
  final onlineRepo = Get.put(OnlineResources());

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> loadFromOnline() async {
    var resources = await onlineRepo.fetchResourcesFromFirestore();
    await saveExternalResources(resources);
  }

  Future<void> saveExternalResources(List<ResourcesModel> resources) async {
    await _storage.write(_storageKey, resources);
  }

  Future<List<ResourcesModel>> getExternalResources(ResourceType type) async {
    List<dynamic> allData = _storage.read(_storageKey);
    if(allData != null){
      List<ResourcesModel> resources = allData.map((e) => ResourcesModel.fromJson(e)).toList();
      return resources;
    }else{
      loadFromOnline();
      getExternalResources(type);
      return [];
    }
  }

  Future<void> clearExternalResources() async {
    await _storage.remove(_storageKey);
  }

}