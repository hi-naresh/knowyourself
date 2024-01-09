import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/Extras/user_data_provider.dart';
import 'package:knowyourself/screens/Extras/Reminder/reminder_screen.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class AvatarSelectScreen extends StatelessWidget {
  final bool? isSaved;
  const AvatarSelectScreen({super.key, this.isSaved});

  Widget _buildAvatarContainer({required String avatar}) {
    return Consumer<UserDataProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return GestureDetector(
          onTap: () {
            value.updateAvatar(avatar);
          },
          child: Container(
            height: 70.w,
            margin: const EdgeInsets.all(5),
            width: 70.w,
            decoration: BoxDecoration(
              color: value.avatar != avatar
                  ? kBackground
                  : kPrimaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            foregroundDecoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/avatars/$avatar.png"),
                  fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'What Should We ',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      TextSpan(
                        text: 'Call ',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                          height: 1,
                        ),
                      ),
                      TextSpan(
                        text: 'You? ',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Consumer<UserDataProvider>(
                  builder: (context, value, child) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: value.nameTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          errorText: value.hasEntered
                              ? null
                              : "Please Enter Your Name",
                          contentPadding: const EdgeInsets.all(20),
                          fillColor:
                              Theme.of(context).chipTheme.backgroundColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Your Alias",
                        ),
                        maxLength: 30,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Which ',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      TextSpan(
                        text: 'Avatar ',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                          height: 1,
                        ),
                      ),
                      TextSpan(
                        text: 'Would You Like?',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAvatarContainer(avatar: "avatar1"),
                    _buildAvatarContainer(avatar: "avatar2"),
                    _buildAvatarContainer(avatar: "avatar3"),
                    _buildAvatarContainer(avatar: "avatar4"),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAvatarContainer(avatar: "avatar5"),
                    _buildAvatarContainer(avatar: "avatar6"),
                    _buildAvatarContainer(avatar: "avatar7"),
                    _buildAvatarContainer(avatar: "avatar8"),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAvatarContainer(avatar: "avatar9"),
                    _buildAvatarContainer(avatar: "avatar10"),
                    _buildAvatarContainer(avatar: "avatar11"),
                    _buildAvatarContainer(avatar: "avatar12"),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    final userDataProvider =
                        Provider.of<UserDataProvider>(context, listen: false);
                    userDataProvider.validateText();

                    userDataProvider.saveData();

                    if (isSaved == null && userDataProvider.userName != "") {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ReminderSreen();
                      }));
                    } else if (isSaved == true) {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7E5FD),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        isSaved != null ? "Save" : "Continue",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
