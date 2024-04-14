
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/courses.dart';

import '../../../utils/constants/enums.dart';
import '../model/course_model.dart';

class CourseController extends GetxController {
  static CourseController get instance => Get.find();

  RxList<CourseModel> materialsList = <CourseModel>[].obs;
  // final RxString type= CourseType.guide.toString().obs;
  var type = CourseType.guide.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMaterials(type.value);
  }

  void setType(CourseType newType) {
    type.value = newType;
    fetchMaterials(newType);
  }

  Future<void> fetchMaterials( CourseType type) async {
    List<CourseModel> fetchedMaterials = materials;
    List<CourseModel> filteredMaterials = fetchedMaterials.where(
            (element) => element.type == type ).toList();
    materialsList.assignAll(filteredMaterials);
  }

}