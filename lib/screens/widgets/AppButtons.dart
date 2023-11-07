import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Container appButton(
  BuildContext context,
  BoxDecoration styleButton,
  String title,
  String route, {
  String? iconPath,
}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.88,
    height: MediaQuery.of(context).size.height * 0.065,
    decoration: styleButton,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPath != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    iconPath,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Container appButtonFunc(
    BuildContext context,
    BoxDecoration styleButton,
    String title,
    Function() onPressed, {
      String? iconPath,
      EdgeInsets? margin,
      bool isEnabled = true, // default value is true, so it won't affect other parts of the app
      Color? disabledColor,
    }) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.88,
    height: MediaQuery.of(context).size.height * 0.065,
    decoration: isEnabled ? styleButton : styleButton.copyWith(color: disabledColor ?? Colors.grey),
    margin: margin,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null, // if the button is not enabled, onTap will be null
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPath != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    iconPath,
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

