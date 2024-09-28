// lib/models/tour_info.dart
// class TourInfo {
//   final int position;
//   final String title;
//   final String iconImage;
//   final String description;
//   final List<String> images;
//   final String category; // Added this field
//
//   TourInfo({
//     required this.position,
//     required this.title,
//     required this.iconImage,
//     required this.description,
//     required this.images,
//     required this.category, // Initialize in the constructor
//   });
// }
class TourInfo {
  final int position;
  final String title;
  final String iconImage;
  final String description;
  final List<String>? images;
  final String category;
  final String id;  // Unique identifier

  TourInfo({
    required this.position,
    required this.title,
    required this.iconImage,
    required this.description,
    this.images,
    required this.category,
    required String uniqueId,
  }) : id = uniqueId;
}


// class TourStep {
//   final String title;
//   final String description;
//   final String? lottieAnimationPath;
//   final String? imagePath;
//   final bool isLastStep;
//
//   TourStep({
//     required this.title,
//     required this.description,
//     this.lottieAnimationPath,
//     this.imagePath,
//     this.isLastStep = false,
//   });
// }
