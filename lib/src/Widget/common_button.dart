import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

commonButton(String title, {double? height, double? width}){
  return Container(
    height: height ?? 50, width: width ?? ScreenUtil().screenWidth,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xff7979FC), Color(0xff9B9BFF)]),
      borderRadius: BorderRadius.circular(15)
    ),
    child: Center(child: Text(title, style: TextStyleTheme.customTextStyle(AppColors.white, 16, FontWeight.w600),)),
  );
}