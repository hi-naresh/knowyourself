import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/tour/screens/tour_detail.dart';
import 'package:knowyourself/features/tour/screens/widgets/tour_card.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import '../../../routes.dart';
import '../controller/tour_controller.dart';

class TourScreen extends StatelessWidget {
  const TourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TourController controller = Get.put(TourController());

    return Scaffold(
      backgroundColor: KColors.kApp3,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'App Tour',
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextButton(
                          onPressed: () => Get.offAllNamed(KRoutes.getMasterRoute()),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                          )
                      )
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(() => DropdownButton<String>(
                    dropdownColor: KColors.kApp3Dark,
                    value: controller.selectedCategory.value,
                    borderRadius: BorderRadius.circular(20),
                    items: const [
                      DropdownMenuItem(
                        value: 'Introduction',
                        child: Text(
                          'Introduction',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 24,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Purpose',
                        child: Text(
                          'Purpose',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 24,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Inspiration',
                        child: Text(
                          'Inspiration',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 24,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Features',
                        child: Text(
                          'Features',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 24,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.setSelectedCategory(value);
                      }
                    },
                    icon: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),
                    underline: const SizedBox(),
                  )),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final filteredTours = controller.filteredTours;

                return filteredTours.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Swiper(
                    itemCount: filteredTours.length,
                    fade: 0.3,
                    itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                    layout: SwiperLayout.STACK,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        activeSize: 20,
                        activeColor: KColors.kApp3Light,
                        space: 5,
                      ),
                    ),
                    itemBuilder: (context, index) {
                      final tour = filteredTours[index];
                      final heroTag =
                          '${tour.iconImage}-${tour.id}-$index';

                      return TourCard(
                        tour: tour,
                        heroTag: heroTag,
                        onTap: () {
                          Get.to(() => DetailsView(tourInfo: tour),
                            transition: Transition.circularReveal,
                            duration: const Duration(milliseconds: 600),
                            opaque: true,
                            // curve: Curves.fastLinearToSlowEaseIn,
                          );
                        },
                      );
                    },
                  ),
                )
                    : const Center(
                  child: Text(
                    'No tours available',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}