import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Controller/TextField/custom_textfield.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Repository/Services/Navigation/navigation_service.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:earn_streak/src/Utils/Validations/validation.dart';
import 'package:earn_streak/src/Widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

forgotPasswordDialog(context, LoginNotifier state){
  return showDialog(
      context: context,
    builder: (context){
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(LoginString.forgotPasswords, style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w500),)),
              paddingTop(15),
              customTextField(forgotEmailController, "Email", "sam@mail.com", validation: (value) => validateEmail(value), textInputAction: TextInputAction.done),
              paddingTop(25),
              commonButton(LoginString.reset, width: 150, onTap: (){Navigator.pop(context); enterOtpDialog(context, state);}),
              paddingTop(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(LoginString.backTo, style: TextStyleTheme.customTextStyle(AppColors.black.withOpacity(0.4), 14, FontWeight.w400),),
                  paddingLeft(5),
                  GestureDetector(
                      onTap: (){Navigator.pop(context);},
                      child: Text(LoginString.login, style: TextStyleTheme.customTextStyle(const Color(0xff3382EB), 14, FontWeight.w400),)),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

enterOtpDialog(context, state){
  return showDialog(
    context: context,
    builder: (context){
      return StatefulBuilder(
        builder: (context, setState) =>
         Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(LoginString.enterOtp, style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w500),)),
                paddingTop(15),
                OtpTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  numberOfFields: 4,
                  borderColor: const Color(0xFF512DA8),
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode){
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: const Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                          );
                        }
                    );
                  }, // end onSubmit
                ),
                paddingTop(25),
                commonButton(LoginString.submit, width: 150, onTap: (){Navigator.pop(context); enterNewPasswordDialog(context, state);}),
                paddingTop(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(LoginString.backTo, style: TextStyleTheme.customTextStyle(AppColors.black.withOpacity(0.4), 14, FontWeight.w400),),
                    paddingLeft(5),
                    GestureDetector(
                        onTap: (){Navigator.pop(context);},
                        child: Text(LoginString.login, style: TextStyleTheme.customTextStyle(const Color(0xff3382EB), 14, FontWeight.w400),)),
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

enterNewPasswordDialog(context, LoginNotifier state){
  return showDialog(
    context: context,
    builder: (context){
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
        // final state = Provider.of<LoginNotifier>(context, listen: false);
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(LoginString.newPassword, style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w500),)),
                  paddingTop(15),
                  customTextField(forgotPasswordController, "Enter new password", "******", suffixIcon: state.isVisibleForgotPassword ? AppImages.closeIcon : AppImages.openIcon, suffixIconTap: (){setState((){
                    state.visibleForgotPasswordValueUpdate();
                  });} , obSecure: state.isVisibleForgotPassword, validation: (value) => validatePassword(value)),
                  paddingTop(15),
                  customTextField(forgotConfirmPasswordController, "Confirm password", "******", suffixIcon: state.isVisibleForgotConfirmPassword ? AppImages.closeIcon : AppImages.openIcon, textInputAction: TextInputAction.done, suffixIconTap:(){
                    setState((){
                      state.visibleForgotConfirmPasswordValueUpdate();
                    });
                  }, obSecure: state.isVisibleForgotConfirmPassword, validation: (value) => validateConfirmPassword(forgotPasswordController.text, value)),
                  paddingTop(25),
                  commonButton(LoginString.submit, width: 150, onTap: (){Navigator.pop(context);}),
                ],
              ),
            ),
          );
         }
      );
    },
  );
}