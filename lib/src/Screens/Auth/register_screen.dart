import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Controller/TextField/custom_textfield.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Element/responsive_size_value.dart';
import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Screens/Auth/login_screen.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Helper/page_route.dart';
import 'package:earn_streak/src/Utils/Notifier/register_notifier.dart';
import 'package:earn_streak/src/Utils/Validations/validation.dart';
import 'package:earn_streak/src/Widget/common_button.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

RegisterScreen()=> ChangeNotifierProvider<RegisterNotifier>(create: (_) => RegisterNotifier(), child: Builder(builder: (context) => RegisterScreenProvider(context: context)),);

class RegisterScreenProvider extends StatelessWidget {
  const RegisterScreenProvider({super.key, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterNotifier>(
      builder: (context, state, child) =>
       GestureDetector(
         onTap: (){
           FocusScope.of(context).requestFocus(FocusNode());
         },
         child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: ScreenUtil().screenHeight,
                child: Column(
                  children: [
                    ClipPath(
                      clipper: CircularBottomClipper(),
                      child: Container(
                        width: setWidth(ScreenUtil().screenWidth),
                        height: 300,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff7979FC), Color(0xff9B9BFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 25, right: 25, top: 100,
                child: SizedBox(
                    height: ScreenUtil().screenHeight / 1.1,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Form(
                            key: state.globalFormKey,
                            autovalidateMode: state.validate,
                            child: Column(
                              children: [
                                paddingTop(15),
                                Text(CommonString.welcomeToQuiz, style: TextStyleTheme.customTextStyle(AppColors.black, 24, FontWeight.w700),),
                                paddingTop(10),
                                Text(CommonString.signUp, style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w600),),
                                paddingTop(10),
                                customTextField(registerNameController, "Name", "sam", validation: (value) => validateName(value)),
                                paddingTop(15),
                                customTextField(registerEmailController, "Email", "sam@mail.com", validation: (value) => validateEmail(value), textInputType: TextInputType.emailAddress),
                                paddingTop(15),
                                customTextField(registerPasswordController, "Password", "******", suffixIcon: state.isVisiblePassword ? AppImages.closeEyeIcon : AppImages.openEyeIcon, suffixIconTap: state.visiblePasswordValueUpdate, obSecure: state.isVisiblePassword, validation: (value) => validatePassword(value)),
                                paddingTop(15),
                                customTextField(registerConfirmPasswordController, "Confirm Password", "******", suffixIcon: state.isVisibleConfirmPassword ? AppImages.closeEyeIcon : AppImages.openEyeIcon, textInputAction: TextInputAction.done, suffixIconTap: state.visibleConfirmPasswordValueUpdate, obSecure: state.isVisibleConfirmPassword, validation: (value) => validateConfirmPassword(registerPasswordController.text, value)),
                                paddingTop(15),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: state.selectTermsPrivacyValueUpdate,
                                      child: Container(
                                        height: 20, width: 20,
                                        decoration: BoxDecoration(
                                          color: state.isSelectTermsPrivacy ? const Color(0xff7979FC) : Colors.transparent,
                                          shape: BoxShape.rectangle,
                                          border: Border.all(color: state.isSelectTermsPrivacy ? const Color(0xff7979FC) : AppColors.black),
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: state.isSelectTermsPrivacy ? const Icon(Icons.check, size: 15, color: Colors.white,) : Container(),
                                      ),
                                    ),
                                    paddingLeft(10),
                                    Text("I agree to the", style: TextStyleTheme.customTextStyle(AppColors.black, 14.5, FontWeight.w400),),
                                    paddingLeft(5),
                                    Text(CommonString.termsAndPrivacy, style: TextStyleTheme.customTextStyle(AppColors.black, 14.5, FontWeight.w500, decoration: TextDecoration.underline),),
                                  ],
                                ),
                                paddingTop(15),
                                commonButtonColorLinerGradiunt(CommonString.signUp, width: 150, onTap: state.signUpButtonOnTap),
                                paddingTop(20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1.5,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColors.grey)
                                        ),
                                      ),
                                    ),
                                    paddingLeft(10),
                                    Text("Or", style: TextStyleTheme.customTextStyle(AppColors.black, 12, FontWeight.w600),),
                                    paddingLeft(10),
                                    Expanded(
                                      child: Container(
                                        height: 1.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.grey)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                paddingTop(15),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.black)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SvgPicture.asset(AppImages.googleIcon, height: 20, width: 20,),
                                  ),
                                ),
                                paddingTop(15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(CommonString.haveAnAccount, style: TextStyleTheme.customTextStyle(AppColors.black.withOpacity(0.5), 13, FontWeight.w400),),
                                    paddingLeft(5),
                                    GestureDetector(
                                        onTap: (){push(context, LoginScreen());},
                                        child: Text(CommonString.login, style: TextStyleTheme.customTextStyle(AppColors.purple, 14.5, FontWeight.w500),)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              )
            ],
          ),
               ),
       ),
    );
  }
}
