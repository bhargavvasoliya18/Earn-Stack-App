import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Model/UiModel/country_code_model.dart';
import 'package:earn_streak/src/Model/UiModel/phone_number.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Widget/CountryPickerPhoneField/country_code_dialog.dart';
import 'package:earn_streak/src/Widget/CountryPickerPhoneField/custom_country_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget customTextField(TextEditingController controller, String label, String hintText, {String suffixIcon = '', bool? obSecure, TextInputAction? textInputAction, VoidCallback? suffixIconTap, Function(String)? validation, TextInputType? textInputType}) {
  return SizedBox(
    height: 56.h,
    child: TextFormField(
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
        // contentPadding: EdgeInsets.only(top: ),
        labelStyle: TextStyleTheme.customTextStyle(AppColors.black, 18, FontWeight.w400),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        suffixIcon: suffixIcon == "" ? const Padding(padding: EdgeInsets.all(14))  :  Padding(
          padding: const EdgeInsets.all(14),
          child: InkWell(
              onTap: suffixIconTap,
              child: SvgPicture.asset(suffixIcon)),
        ),
      ),
    ),
  );
}


Widget customPhoneTextFiled(String initValue,FormFieldValidator validator,String initialCountryCode,TextAlign align, TextEditingController controller,TextInputType textInputType,String textHint, FocusNode focusNode,TextInputAction textInputAction, BuildContext context,{AutovalidateMode? autovalidateMode,Color? cursorColor,Color? underLineColor, VoidCallback? onEditingComplete,void Function(PhoneNumber)? onChange,void Function(Country)? onCountryChanged,bool showBorder = false,bool enable = true,TextStyle? textStyle,TextStyle? hintStyle,List<TextInputFormatter>? inputFormatters,String? errorText, TextStyle? errorStyle,Key? key}){
  return IntlPhoneField(
    key: key,
    textAlignVertical: TextAlignVertical.bottom,
    autovalidateMode: autovalidateMode,
    initialValue: initValue,
    initialCountryCode: initialCountryCode,
    validator: validator,
    // textAlign: align,
    controller: controller,
    keyboardType: textInputType,
    focusNode: focusNode,
    textInputAction: textInputAction,
    onChanged: onChange,
    // invalidNumberMessage: 'Please Enter Valid Number',
    onCountryChanged: onCountryChanged,
    disableLengthCheck: false,
    flagsButtonPadding: EdgeInsets.only(left: 10),
    flagsButtonMargin: EdgeInsets.zero,
    enabled: enable,
    style: textStyle ?? TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w500,),
    cursorColor: cursorColor?? AppColors.black,
    inputFormatters: inputFormatters,
    dropdownTextStyle: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w500,),
    showDropdownIcon: false,
    pickerDialogStyle: PickerDialogStyle(
      backgroundColor: AppColors.white,
      countryNameStyle:textStyle ?? TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w500,),
      countryCodeStyle: textStyle ?? TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w500,),
      padding: const EdgeInsets.all(20),
      searchFieldCursorColor: AppColors.black,
      searchFieldInputDecoration: InputDecoration(
        hintText: "Search Countries",
        suffixIcon: Icon(Icons.search,color: AppColors.black,),
        labelText: "Search Countries",
        helperStyle: TextStyleTheme.customTextStyle(AppColors.black, 12, FontWeight.w500,),
        labelStyle: TextStyleTheme.customTextStyle(AppColors.black, 12, FontWeight.w500,),
        hintStyle: hintStyle??TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w500),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        filled: true,
        contentPadding: const EdgeInsets.all(12),
        isDense: false,
        fillColor: Colors.transparent,
      ),),
    decoration: InputDecoration(
      hintText: textHint,
      hintStyle: hintStyle??TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w400,),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
      filled: true,
      isCollapsed: true,
      contentPadding: const EdgeInsets.all(12),
      isDense: true,
      fillColor: Colors.transparent,
    ),
  );
}