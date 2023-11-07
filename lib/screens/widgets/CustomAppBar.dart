import 'package:flutter/material.dart';

AppBar myAppBar(
  BuildContext context,
  String title, {
  bool showLeadingIcon = true,
  Function()? onPressed,
  String? route,
} // Optional named parameter
    ) {
  onPressed = () {
    Navigator.pop(context);
  };
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: showLeadingIcon
        ? IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: onPressed,
          )
        : null, // If showLeadingIcon is false, leading will be null
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'SF Pro Display',
        color: Theme.of(context).primaryColor,
      ),
    ),
    centerTitle: true,
  );
}
