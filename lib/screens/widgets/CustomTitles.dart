import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knowyourself/utils/ui_colors.dart';

final h1 = GoogleFonts.epilogue(
  fontSize: 26.sp,
  fontWeight: FontWeight.w500,
  color: kDarkText,
);
customTitle(Color color, double size) => GoogleFonts.epilogue(
  fontSize: size.sp,
  fontWeight: FontWeight.w500,
  color: color,
);
customTitleBold(Color color, double size, FontWeight weight) => GoogleFonts.epilogue(
  fontSize: size.sp,
  fontWeight: weight,
  color: color,
);
final h2 = GoogleFonts.epilogue(
  fontSize: 20.sp,
  fontWeight: FontWeight.w600,
  color: kDarkText,
);
final h2Bold = GoogleFonts.epilogue(
  fontSize: 22.sp,
  fontWeight: FontWeight.w700,
  color: kDarkText,
);
final h3 = GoogleFonts.epilogue(
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  color: kDarkText,
);
final h3Bold = GoogleFonts.epilogue(
  fontSize: 16.sp,
  fontWeight: FontWeight.w700,
  color: kDarkText,
);

h4(Color color) => GoogleFonts.epilogue(
  fontSize: 13.sp,
  fontWeight: FontWeight.w500,
  color: Color==null ? kLightText : color,
);
final h1Bold = GoogleFonts.epilogue(
  fontSize: 26.sp,
  fontWeight: FontWeight.w800,
  color: kDarkText,
  decoration: TextDecoration.underline,
);
