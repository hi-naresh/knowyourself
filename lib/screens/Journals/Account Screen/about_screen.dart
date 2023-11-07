import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/utils/utils_functions.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Widget _buildPolicyContainer(
      {required BuildContext context,
      required String text,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).chipTheme.backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 25.r,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          title: Text(
            "About KYB",
            style: TextStyle(
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Column(
        children: [
          _buildPolicyContainer(
              context: context,
              text: "Contact Us",
              onTap: () {
              }),
          _buildPolicyContainer(
              context: context,
              text: "Terms & Conditions",
              onTap: () {
              }),
          _buildPolicyContainer(
              context: context,
              text: "Privacy Policy",
              onTap: () {
              }),
        ],
      ),
    );
  }
}
