
import 'package:flutter/material.dart';
import 'package:knowyourself/utils/ui_colors.dart';

BoxDecoration gradient(
  BuildContext context, {
  Color borderColor = Colors.transparent,
}) =>
    BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(
        color: borderColor,
        width: 1,
      ),
      color: Theme.of(context).primaryColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(-5, 5),
          spreadRadius: 3,
          blurRadius: 10,
        ),
      ],
    );

BoxDecoration border(
  BuildContext context, {
  double borderRadius = 20,
  Color borderColor = Colors.white70,
  Color colorbg = Colors.black12,
}) =>
    BoxDecoration(
      color: colorbg,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      border: Border.all(
        color: borderColor,
        width: 1,
      ),
    );
