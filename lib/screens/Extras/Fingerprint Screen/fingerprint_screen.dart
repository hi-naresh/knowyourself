import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/auth/local_auth/local_authentication.dart';
import 'package:knowyourself/screens/Main%20Screen/main_screen.dart';
import 'package:knowyourself/utils/pref.dart';

class FingerprintScreen extends StatelessWidget {
  const FingerprintScreen({super.key});

  Future<void> _authenticate(BuildContext context) async {
    if (SharedPreferencesHelper.getAuthPermission() == true) {
      await LocalAuthApi.authenticate().then((value) {
        if (value == true) {
          navigate(context);
        }
      });
      return;
    }
    // ignore: use_build_context_synchronously
    navigate(context);
  }

  void navigate(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return const MainScreen();
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    _authenticate(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.h,
          ),
          Image.asset(
            "assets/icons/lock.png",
            height: 50.h,
            width: 50.h,
          ),
          Text(
            "KYB Locked",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 100.h,
          ),
          GestureDetector(
            onTap: () {
              _authenticate(context);
            },
            child: Center(
              child: Icon(
                Icons.fingerprint,
                size: 65.r,
                color: const Color(0xFF96969B),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Authenticate To KYB",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF96969B),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}
