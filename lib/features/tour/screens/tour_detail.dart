import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/features/tour/model/tour_model.dart';

class DetailsView extends StatelessWidget {
  final TourInfo tourInfo;

  const DetailsView({super.key, required this.tourInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.lightGrey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 32),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      Text(
                        tourInfo.title,
                        style: TextStyle(
                          fontSize: 55,
                          fontFamily: 'Avenir',
                          color: KColors.textPrimary,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        tourInfo.category,
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: 'Avenir',
                          color: KColors.textPrimary,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Divider(
                        color: Colors.black38,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Text(
                            tourInfo.description,
                            style: TextStyle(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'Avenir',
                              color: KColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 60,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //create circle close button
                    ],
                  ),
                ),
              ),
              Positioned(
                right: -50,
                child: Hero(
                  // tag: tourInfo.id,
                  tag: tourInfo.iconImage + tourInfo.id,
                  // child: Image.asset(tourInfo.iconImage),
                  child: SvgPicture.asset(
                    tourInfo.iconImage,
                    height: 300,
                    width: 300,
                  )
                ),
              ),
              Positioned(
                top: 60,
                left: 32,
                child: Text(
                  tourInfo.position.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 247,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.chevron_back),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor: KColors.kApp3,
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  color: KColors.textPrimary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )
            ))
    );
  }
}
