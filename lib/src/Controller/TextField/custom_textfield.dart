import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget customTextField(TextEditingController controller, String label, String hintText, {String? suffixIcon, bool? obSecure, TextInputAction? textInputAction, VoidCallback? suffixIconTap, Function(String)? validation, TextInputType? textInputType}) {
  return TextFormField(
    controller: controller,
    obscureText: obSecure ?? false,
    textInputAction: textInputAction ?? TextInputAction.next,
    keyboardType: textInputType ?? TextInputType.text,
    obscuringCharacter: "*",
    validator: (value){
      return validation?.call(value!);
    },
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText,
      labelStyle: TextStyleTheme.customTextStyle(AppColors.black, 18, FontWeight.w400),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(14),
        child: InkWell(
            onTap: suffixIconTap,
            child: SvgPicture.asset(suffixIcon ?? "")),
      ),
    ),
  );
}
