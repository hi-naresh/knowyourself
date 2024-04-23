import 'package:flutter/material.dart';
import 'package:knowyourself/features/mySpace/mood/controller/add_mood_controller.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/helpers/progress_bar.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/helpers/shadow_disabler.dart';


class ExpressFeelingsPage extends StatelessWidget {
  const ExpressFeelingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final AddMoodController controller = Get.put(AddMoodController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Column(
          // padding: const EdgeInsets.symmetric(vertical: KSizes.defaultSpace*2,horizontal:  KSizes.defaultSpace),
          children: [
            const ProgressBar(steps: "3/3", percent: 1),
            const SizedBox(height: KSizes.defaultSpace),
            Text(
              KTexts.feelingsQuestion,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: KSizes.defaultSpace),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(
                    ()=> Row(
                  children: List.generate(controller.happenedAt.length, (index) {
                    return GestureDetector(
                      onTap: ()=>controller.selectHappenedAt.value = index,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3.0),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: controller.selectHappenedAt.value == index ? KColors.kApp1 : KColors.kEmptyProgress,
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: controller.selectHappenedAt.value == index ? KColors.kApp1: KColors.transparent,
                            width: 2,
                          ),
                          boxShadow: CustomShadow.getShadow([
                            if (controller.selectHappenedAt.value == index)
                              BoxShadow(
                                color: KColors.kApp1.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                          ]),                                ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.happenedAt[index],
                              style: TextStyle(
                                color: controller.selectHappenedAt.value == index ? Colors.white : Colors.black,
                                fontSize: KSizes.fontSizeMd,
                              ),
                            ),
                            if (controller.selectHappenedAt.value == index)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: KSizes.defaultSpace),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(KSizes.md),
                decoration: BoxDecoration(
                  color: KHelper.isDark() ? KColors.kEmptyProgressDark : KColors.kEmptyProgress,
                  borderRadius: BorderRadius.circular(KSizes.borderRadiusXl),
                ),
                child: TextFormField(
                  onTap: () => controller.deFocusKeyboard(context),
                  controller: controller.reasons,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    hintText: KTexts.describeText,
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.all(KSizes.sm),
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: KSizes.defaultSpace),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final AddMoodController controller = AddMoodController.instance;

    return Column(
      children: [
        _buildActionButton(
          context,
          buttonText: KTexts.staySameButtonText,
          action: controller.saveMoodData,
        ),
        const SizedBox(height: KSizes.md),
        _buildActionButton(
          context,
          buttonText: KTexts.feelBetterButtonText,
          action: controller.shiftMood,
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, {required String buttonText, required Function action}) {
    return TextButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 55)),
        backgroundColor: MaterialStateProperty.all(KColors.kApp1),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () {
        action();
        FocusScope.of(context).unfocus(); // To hide the keyboard
      },
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
