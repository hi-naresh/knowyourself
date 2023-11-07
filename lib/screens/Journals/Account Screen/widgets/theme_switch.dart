import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/App%20State/app_state_provider.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (BuildContext context, theme, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Semantics(
              label: 'Change Theme',
              hint: 'Press to change  Theme',
              child: CupertinoSwitch(
                thumbColor: !theme.isDarkMode ? kPrimaryColor : Colors.white,
                value: theme.isDarkMode,
                trackColor: Colors.white,
                activeColor: kPrimaryColor,
                onChanged: (bool value) {
                  theme.updateTheme(value);
                  if (value == false) {
                    SystemChrome.setSystemUIOverlayStyle(
                      const SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark,
                          systemNavigationBarColor: kLightModeBottomNavBarColor,
                          systemNavigationBarIconBrightness: Brightness.dark),
                    );
                  } else {
                    SystemChrome.setSystemUIOverlayStyle(
                      const SystemUiOverlayStyle(
                          statusBarColor: kDarkModeScaffoldColor,
                          statusBarIconBrightness: Brightness.light,
                          systemNavigationBarColor: kDarkModeScaffoldColor,
                          systemNavigationBarIconBrightness: Brightness.light),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
