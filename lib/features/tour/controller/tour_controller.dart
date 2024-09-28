// import 'package:get/get.dart';
// import '../../../utils/constants/tour_data.dart';
// import '../model/tourstep_model.dart';
//
// class TourController extends GetxController {
//   final TourRepository _repository = TourRepository();
//   final RxInt currentStepIndex = 0.obs;
//
//   List<TourStep> get tourSteps => _repository.getTourSteps();
//   TourStep get currentStep => tourSteps[currentStepIndex.value];
//
//   void nextStep() {
//     if (currentStepIndex.value < tourSteps.length - 1) {
//       currentStepIndex.value++;
//     }
//   }
//
//   void previousStep() {
//     if (currentStepIndex.value > 0) {
//       currentStepIndex.value--;
//     }
//   }
//
//   void skipTour() {
//     // Handle the logic to skip the tour, like navigating to the home screen
//   }
//
//   void finishTour() {
//     // Handle the logic when the tour is finished, like marking the tour as complete and navigating to the home screen
//   }
// }
//
import 'package:get/get.dart';
import '../../../utils/constants/tour_data.dart';
import '../model/tour_model.dart';
//
// class TourController extends GetxController {
//   final RxList<TourInfo> tours = <TourInfo>[].obs;
//   final RxString selectedCategory = 'Introduction'.obs;
//
//   List<String> get categories => [
//     'Intro',
//     'Purpose'
//     'Inspiration',
//     'Features',
//   ];
//
//   @override
//   void onInit() {
//     // Initialize the tours with data
//     _loadTourData();
//     super.onInit();
//   }
//
//   List<TourInfo> get filteredTours {
//     return tours
//         .where((tour) => tour.category == selectedCategory.value)
//         .toList();
//   }
//
//   void setSelectedCategory(String category) {
//     selectedCategory.value = category;
//   }
//
//   void _loadTourData() {
//     // Load data from a predefined list
//     tours.addAll(tourData);
//   }
//
//   TourInfo getTourByPosition(int position) {
//     return tours.firstWhere((tour) => tour.position == position);
//   }
// }

class TourController extends GetxController {
  var selectedCategory = 'Introduction'.obs;

  List<TourInfo> get filteredTours =>
      tourData.where((tour) => tour.category == selectedCategory.value).toList();

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }
}
