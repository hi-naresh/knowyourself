import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/utils/constants/colors.dart';

import '../../model/tour_model.dart';

class TourCard extends StatelessWidget {
  final TourInfo tour;
  final String heroTag;
  final VoidCallback onTap;

  const TourCard({
    Key? key,
    required this.tour,
    required this.heroTag,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Column(
            children: <Widget>[
              const SizedBox(height: 100),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 8,
                color: KColors.lightGrey,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 100),
                      Text(
                        tour.title,
                        style: const TextStyle(
                          fontSize: 32,
                          fontFamily: 'Avenir',
                          color: Color(0xff47455f),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        tour.category,
                        style: const TextStyle(
                          fontSize: 23,
                          fontFamily: 'Avenir',
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Text(
                            "Know more",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Avenir',
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.blueGrey,
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -30,
            child: Container(
              height: 220,
              width: 220,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: KColors.kApp3Light,
              ),
              child: Hero(
                tag: heroTag,
                child: tour.iconImage.contains('.svg')
                  ? SvgPicture.asset(
                  tour.iconImage,
                  height: 150,
                  width: 150,
                  ) : Image.asset(
                  tour.iconImage,
                  height: 150,
                  width: 150,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}