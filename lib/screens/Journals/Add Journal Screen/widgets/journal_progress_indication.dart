import 'package:flutter/material.dart';

class JournalProgressIndicator extends StatelessWidget {
  final int value;
  final int currentVal;
  final double width;
  final double height;
  const JournalProgressIndicator(
      {super.key,
      required this.value,
      required this.width,
      required this.height,
      required this.currentVal});

  List<Widget> _buildProgressContainer() {
    if (currentVal == 1) {
      return [
        Container(
          width: width / value,
          height: height,
          decoration: const BoxDecoration(
            color: Color(0xFF5349DB),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        )
      ];
    } else if (currentVal == 2) {
      return [
        Container(
          width: width / value,
          height: height,
          decoration: const BoxDecoration(
            color: Color(0xFF5349DB),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(0),
            ),
          ),
        ),
        Container(
          width: width / value,
          height: height,
          decoration: const BoxDecoration(
            color: Color(0xFF5349DB),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(20),
            ),
          ),
        )
      ];
    }
    return [
      Container(
        width: width / value,
        height: height,
        decoration: const BoxDecoration(
          color: Color(0xFF5349DB),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(0),
          ),
        ),
      ),
      Container(
        width: width / value,
        height: height,
        decoration: const BoxDecoration(
          color: Color(0xFF5349DB),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
      ),
      Container(
        width: width / value,
        height: height,
        decoration: const BoxDecoration(
          color: Color(0xFF5349DB),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(20),
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildProgressContainer()),
    );
  }
}
