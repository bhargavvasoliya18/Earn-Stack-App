import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Controller/TextField/custom_textfield.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Element/responsive_size_value.dart';
import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Screens/Auth/Module/forgot_password_dialog.dart';
import 'package:earn_streak/src/Screens/Auth/register_screen.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Helper/page_route.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/register_notifier.dart';
import 'package:earn_streak/src/Utils/Validations/validation.dart';
import 'package:earn_streak/src/Widget/common_button.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

LoginScreen()=> ChangeNotifierProvider<LoginNotifier>(create: (_) => LoginNotifier(), child: Builder(builder: (context) => LoginScreenProvider(context: context)),);

class LoginScreenProvider extends StatelessWidget {
  const LoginScreenProvider({super.key, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, state, child) =>
          Scaffold(
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
                      height: ScreenUtil().screenHeight / 1.2,
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            key: state.globalFormKey,
                            autovalidateMode: state.validate,
                            child: Column(
                              children: [
                                paddingTop(30),
                                Container(
                                  height: 100, width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xff7979FC)),
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                ),
                                paddingTop(25),
                                Text(CommonString.welcomeToQuiz, style: TextStyleTheme.customTextStyle(AppColors.black, 24, FontWeight.w700),),
                                paddingTop(25),
                                customTextField(loginEmailController, "Email", "sam@mail.com", validation: (value) => validateEmail(value)),
                                paddingTop(15),
                                customTextField(loginPasswordController, "Password", "******", suffixIcon: state.isVisiblePassword ? AppImages.openIcon : AppImages.closeIcon, suffixIconTap: state.visiblePasswordValueUpdate, obSecure: state.isVisiblePassword, validation: (value) => validatePassword(value), textInputAction: TextInputAction.done ),
                                paddingTop(10),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                        onTap: (){ enterNewPasswordDialog(context);/*forgotPasswordDialog(context);*/ },
                                        child: Text(LoginString.forgotPassword, style: TextStyleTheme.customTextStyle(const Color(0xff3382EB), 14, FontWeight.w600),))),
                                paddingTop(15),
                                commonButton(LoginString.login, width: 150, onTap: state.loginButtonOnTap),
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
                                    Text(LoginString.doNotHaveAnAccount, style: TextStyleTheme.customTextStyle(AppColors.black.withOpacity(0.5), 13, FontWeight.w400),),
                                    paddingLeft(5),
                                    GestureDetector(
                                        onTap: (){push(context, RegisterScreen());},
                                        child: Text(LoginString.signUp, style: TextStyleTheme.customTextStyle(AppColors.purple, 14.5, FontWeight.w500),)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
    );
  }
}
