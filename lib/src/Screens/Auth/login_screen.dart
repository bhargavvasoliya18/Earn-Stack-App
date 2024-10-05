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
import 'package:earn_streak/src/Utils/Validations/validation.dart';
import 'package:earn_streak/src/Widget/common_button.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

LoginScreen() => ChangeNotifierProvider<LoginNotifier>(create: (_) => LoginNotifier(), child: Builder(builder: (context) => LoginScreenProvider(context: context)),);

class LoginScreenProvider extends StatelessWidget {
  LoginScreenProvider({super.key, required BuildContext context}){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      loginResponseModel.deviceToken = (await fcm.getToken()) ?? '';
      var state = Provider.of<LoginNotifier>(context, listen: false);
      state.initState();
      print("device token is ${loginResponseModel.deviceToken}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, state, child) => GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: setHeight(ScreenUtil().screenHeight),
                child: Form(
                  key: state.globalFormKey,
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
              ),
              Positioned(
                left: 25.w,
                right: 25.w,
                top: 40.h,
                child: SizedBox(
                    height: ScreenUtil().screenHeight / 1.1,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              paddingTop(30.h),
                              SizedBox(
                                height: 100.h,
                                width: 100.w,
                                child: Image.asset(AppImages.appLogo),
                              ),
                              paddingTop(25.h),
                              Text(
                                CommonString.welcomeToQuiz,
                                style: TextStyleTheme.customTextStyle(AppColors.black, 24, FontWeight.w700),
                              ),
                              paddingTop(25.h),
                              customTextField(loginEmailController, "Email", "Enter your email",
                                  validation: (value) => validateEmail(value)),
                              paddingTop(15.h),
                              customTextField(loginPasswordController, "Password", "Enter your password",
                                  suffixIcon: state.isVisiblePassword ? AppImages.closeEyeIcon : AppImages.openEyeIcon,
                                  suffixIconTap: state.visiblePasswordValueUpdate,
                                  obSecure: state.isVisiblePassword,
                                  validation: (value) => validatePassword(value),
                                  textInputAction: TextInputAction.done),
                              paddingTop(10.h),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    forgotPasswordDialog(context, state);
                                  },
                                  child: Text(
                                    LoginString.forgotPassword,
                                    style: TextStyleTheme.customTextStyle(const Color(0xff3382EB), 14, FontWeight.w600),
                                  ),
                                ),
                              ),
                              paddingTop(15),
                              commonButtonColorLinerGradiunt(
                                LoginString.login,
                                width: 150,
                                onTap: () {
                                  state.loginButtonOnTap(context);
                                },
                              ),
                              paddingTop(20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1.5,
                                      decoration: BoxDecoration(border: Border.all(color: AppColors.grey)),
                                    ),
                                  ),
                                  paddingLeft(10),
                                  Text(
                                    "Or",
                                    style: TextStyleTheme.customTextStyle(AppColors.black, 12, FontWeight.w600),
                                  ),
                                  paddingLeft(10),
                                  Expanded(
                                    child: Container(
                                      height: 1.5,
                                      decoration: BoxDecoration(border: Border.all(color: AppColors.grey)),
                                    ),
                                  ),
                                ],
                              ),
                              paddingTop(15),
                              GestureDetector(
                                onTap: () {
                                  state.googleLogin(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.black)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SvgPicture.asset(
                                      AppImages.googleIcon,
                                      height: 20.sp,
                                      width: 20.sp,
                                    ),
                                  ),
                                ),
                              ),
                              paddingTop(15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LoginString.doNotHaveAnAccount,
                                    style: TextStyleTheme.customTextStyle(AppColors.black.withOpacity(0.5), 13, FontWeight.w400),
                                  ),
                                  paddingLeft(5),
                                  GestureDetector(
                                      onTap: () {
                                        push(context, RegisterScreen());
                                      },
                                      child: Text(
                                        LoginString.signUp,
                                        style: TextStyleTheme.customTextStyle(AppColors.purple, 14.5, FontWeight.w500),
                                      )),
                                ],
                              ),
                              paddingBottom(MediaQuery.of(context).viewInsets.bottom)
                            ],
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
