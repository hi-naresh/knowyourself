
import 'package:get/get.dart';

import '../../../data/repo/materials/resources/local/resources_repo.dart';
import '../../../utils/constants/enums.dart';
import '../model/resources_model.dart';

class ResourcesController extends GetxController {
  static ResourcesController get instance => Get.find();

  RxList<ResourcesModel> materialsList = <ResourcesModel>[].obs;
  // final RxString type= CourseType.guide.toString().obs;
  var type = ResourceType.guide.obs;
  final localRepo = Get.put(ResourcesRepo());

  @override
  void onInit() {
    super.onInit();
    fetchMaterials(type.value);
  }

  void setType(ResourceType newType) {
    type.value = newType;
    fetchMaterials(newType);
  }

  Future<void> fetchMaterials( ResourceType type) async {
    List<ResourcesModel> fetchedMaterials = await localRepo.getExternalResources(type);
    List<ResourcesModel> filteredMaterials = fetchedMaterials.where(
            (element) => element.type == type.toString().split(".").last ).toList();
    materialsList.assignAll(filteredMaterials);
  }

}