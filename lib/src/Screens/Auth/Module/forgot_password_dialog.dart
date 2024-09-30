import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Controller/TextField/custom_textfield.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:earn_streak/src/Utils/Validations/validation.dart';
import 'package:earn_streak/src/Widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../Utils/app_utils.dart';

forgotPasswordDialog(context, LoginNotifier state) {
  forgotEmailController.text = "";
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LoginString.forgotPasswords,
                    style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w500),
                  )),
              paddingTop(15),
              customTextField(forgotEmailController, "Email", "sam@mail.com",
                  validation: (value) => validateEmail(value), textInputAction: TextInputAction.done),
              paddingTop(25),
              commonButtonColorLinerGradiunt(LoginString.reset, width: 150, onTap: () async {
                RegExp regExp = RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                if (forgotEmailController.text.isEmpty || forgotEmailController.text == "") {
                  showError(message: "Please enter email");
                } else if (!regExp.hasMatch(forgotEmailController.text)) {
                  showError(message: "Please enter valid email");
                } else {
                  if (await state.forgotApiCall(context, forgotEmailController.text)) {
                    if (context.mounted) {
                      Navigator.pop(context);
                      enterOtpDialog(context, state);
                    }
                  }
                }
              }),
              paddingTop(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LoginString.backTo,
                    style: TextStyleTheme.customTextStyle(AppColors.black.withOpacity(0.4), 14, FontWeight.w400),
                  ),
                  paddingLeft(5),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        LoginString.login,
                        style: TextStyleTheme.customTextStyle(const Color(0xff3382EB), 14, FontWeight.w400),
                      )),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

enterOtpDialog(context, LoginNotifier state) {
  String otp = "";
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      LoginString.enterOtp,
                      style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w500),
                    )),
                paddingTop(15),
                OtpTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  numberOfFields: 4,
                  borderColor: const Color(0xFF512DA8),
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    otp = verificationCode;
                  }, // end onSubmit
                ),
                paddingTop(25),
                commonButtonColorLinerGradiunt(LoginString.submit, width: 150, onTap: () async{
                  if(otp != "" && otp != null){
                    if(await state.verifyOtpApiCall(context, otp) ?? false){
                        Navigator.pop(context);
                      if (context.mounted) {
                        enterNewPasswordDialog(context, state);
                      }
                    }
                  }else{
                     showError(message: "Please enter otp");
                  }
                }),
                paddingTop(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LoginString.backTo,
                      style: TextStyleTheme.customTextStyle(AppColors.black.withOpacity(0.4), 14, FontWeight.w400),
                    ),
                    paddingLeft(5),
                    GestureDetector(
                        onTap: (){Navigator.pop(context);},
                        child: Text(
                          LoginString.login,
                          style: TextStyleTheme.customTextStyle(const Color(0xff3382EB), 14, FontWeight.w400),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

enterNewPasswordDialog(context, LoginNotifier state) {
  forgotPasswordController.text = "";
  forgotConfirmPasswordController.text = "";
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (BuildContext context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      LoginString.newPassword,
                      style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w500),
                    )),
                paddingTop(15),
                customTextField(forgotPasswordController, "New password", "******",
                    suffixIcon: state.isVisibleForgotPassword ? AppImages.closeEyeIcon : AppImages.openEyeIcon,
                    suffixIconTap: () {
                      setState(() {
                        state.visibleForgotPasswordValueUpdate();
                      });
                    },
                    obSecure: state.isVisibleForgotPassword,
                    validation: (value) => validatePassword(value)),
                paddingTop(15),
                customTextField(forgotConfirmPasswordController, "Confirm password", "******",
                    suffixIcon: state.isVisibleForgotConfirmPassword ? AppImages.closeEyeIcon : AppImages.openEyeIcon,
                    textInputAction: TextInputAction.done,
                    suffixIconTap: () {
                      setState(() {
                        state.visibleForgotConfirmPasswordValueUpdate();
                      });
                    },
                    obSecure: state.isVisibleForgotConfirmPassword,
                    validation: (value) => validateConfirmPassword(forgotPasswordController.text, value)),
                paddingTop(25),
                commonButtonColorLinerGradiunt(LoginString.submit, width: 150, onTap: () async{
                  if(forgotPasswordController.text.isNotEmpty){
                    if(forgotPasswordController.text == forgotConfirmPasswordController.text){
                      if(await state.resetPasswordApiCall(context, password: forgotPasswordController.text)){
                        Navigator.pop(context);
                      }
                    }else{
                      showError(message: "Confirm password not match");
                    }
                  }else{
                    showError(message: "Please enter password");
                  }
                }),
              ],
            ),
          ),
        );
      });
    },
  );
}
