import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/models/Quote/quote_model.dart';
import 'package:knowyourself/utils/pref.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    QuoteModel? quoteModel = SharedPreferencesHelper.getQuote();
    return Container(
      height: 140.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        image: DecorationImage(
            image: quoteModel == null
                ? const AssetImage("assets/quote/quote.png")
                : AssetImage("assets/quote/${quoteModel.image}.png"),
            fit: BoxFit.cover),
      ),
      child: Center(
          child: Text(
        quoteModel == null ? "Quote of the day" : quoteModel.title,
        textAlign: TextAlign.center,
        maxLines: 4,
        style: TextStyle(
            fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
      )),
    );
  }
}
