import 'dart:ui';
import '../../../utils/constants/colors.dart';

class TeamMember {
  final String name;
  final String title;
  final String email;
  final String imagePath;
  Color backgroundColor = KColors.kPrimaryColor;

  TeamMember({
    required this.name,
    required this.title,
    required this.email,
    required this.imagePath,
    this.backgroundColor = KColors.kPrimaryColor,
  });

}