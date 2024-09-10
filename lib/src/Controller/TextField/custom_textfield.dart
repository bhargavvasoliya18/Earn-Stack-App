import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget customTextField(TextEditingController controller, String label, String hintText, {String? suffixIcon, bool? obSecure}) {
  return TextFormField(
    controller: controller,
    obscureText: obSecure ?? false,
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText,
      labelStyle: TextStyleTheme.customTextStyle(AppColors.black, 18, FontWeight.w400),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(14),
        child: SvgPicture.asset(suffixIcon ?? ""),
      )
    ),
  );
}
