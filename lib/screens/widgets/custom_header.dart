
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../provider/Extras/user_data_provider.dart';
import '../../utils/ui_colors.dart';
import '../Journals/Account Screen/account_screen.dart';
import 'CustomTitles.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key, required this.title}) : super(key: key);

  final String title;

  get onPressed => null;

  @override
  Widget build(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 110.h,
          child: Text(
            title,
            style: customTitleBold(
                kGreyed1.withOpacity(0.05)
                , 90, FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const AccountScreen();
                  }));
                },
                child: Consumer<UserDataProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return CircleAvatar(
                      radius: 18.r,
                      backgroundColor: const Color(0xFFD9D9D9),
                      backgroundImage: AssetImage(
                        "assets/avatars/${value.avatar}.png",
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: SvgPicture.asset(
                  "assets/icons/bell.svg",
                  color: Colors.black,
                ),)
            ],
          ),
        ),
      ],
    );
  }
}