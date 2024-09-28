import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart'; // For generating unique incident IDs
import '../../../../data/repo/space/digdeeper/digdeeper_repo.dart';
import '../model/deeper.dart';

class DigDeeperController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  var currentShapeIndex = 0.obs;
  var isTapped = false.obs;
  final DigDeeperRepo _digDeeperRepo = Get.put(DigDeeperRepo());

  // Unique incident ID for each DigDeeper session
  final String incidentId = Uuid().v4();

  final Map<String, TextEditingController> whatControllers = {};
  final Map<String, TextEditingController> whyControllers = {};
  final Map<String, TextEditingController> howControllers = {};

  final List<String> labels = ["Harmony", "Perfection", "Knowledge", "Action"];
  final PageController pageController = PageController(); // For managing PageView in dialog

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
    animationController.repeat(reverse: true);
    _startShapeSwitching();

    // Initialize TextEditingControllers for each force
    for (var label in labels) {
      whatControllers[label] = TextEditingController();
      whyControllers[label] = TextEditingController();
      howControllers[label] = TextEditingController();
    }
  }

  void _startShapeSwitching() async {
    while (!isTapped.value) {
      await Future.delayed(const Duration(milliseconds: 1200));
      currentShapeIndex.value = (currentShapeIndex.value + 1) % labels.length;
    }
  }

  // Handle shape tap and stop animation
  void handleTap(String tappedShape) {
    isTapped.value = true;
    animationController.stop();
    _showDialog(tappedShape);
  }

  // Show a dialog with a PageView to switch between questions
  void _showDialog(String tappedShape) {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SizedBox(
          height: Get.height * 0.4, // 70% height of the screen
          width: Get.width * 0.9, // 80% width of the screen
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(), // Disable swipe gesture
            children: [
              _buildInitialQuestionPage(tappedShape),
              _buildWhatPage(tappedShape),
              _buildWhyPage(tappedShape),
              _buildHowPage(tappedShape),
            ],
          ),
        ),
      ),
    );
  }

  // First page of the dialog
  Widget _buildInitialQuestionPage(String tappedShape) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Do you lack $tappedShape?', textAlign: TextAlign.center, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    isTapped.value = false;
                    animationController.repeat(reverse: true);
                    _startShapeSwitching();
                  },
                  child: const Text('No'),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Yes'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Second page - "What" question
  Widget _buildWhatPage(String tappedShape) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('What do you lack?'),
          const SizedBox(height: 20),
          TextField(
            controller: whatControllers[tappedShape],
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  // Third page - "Why" question
  Widget _buildWhyPage(String tappedShape) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Why do you lack it?'),
          const SizedBox(height: 20),
          TextField(
            controller: whyControllers[tappedShape],
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  // Fourth page - "How" question
  Widget _buildHowPage(String tappedShape) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('How can you improve it?'),
          const SizedBox(height: 20),
          TextField(
            controller: howControllers[tappedShape],
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _saveDigDeeperEntry(tappedShape);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  // Save the DigDeeper entry
  void _saveDigDeeperEntry(String tappedShape) async {
    final soulForceAnswers = {
      tappedShape: SoulForceAnswers(
        what: whatControllers[tappedShape]!.text,
        why: whyControllers[tappedShape]!.text,
        how: howControllers[tappedShape]!.text,
      ),
    };

    final entry = DigDeeperModel(
      incidentId: incidentId,
      title: 'Incident $incidentId', // You can customize this as per your requirement
      soulForceAnswers: soulForceAnswers,
    );

    await _digDeeperRepo.saveDigDeeperEntry(entry);
    Get.back(); // Close the dialog after the final page
    isTapped.value = false;
    animationController.repeat(reverse: true);
    _startShapeSwitching();
  }

  @override
  void onClose() {
    animationController.dispose();
    for (var controller in whatControllers.values) {
      controller.dispose();
    }
    for (var controller in whyControllers.values) {
      controller.dispose();
    }
    for (var controller in howControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }
}
