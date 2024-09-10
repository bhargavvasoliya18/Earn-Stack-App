import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Controller/TextField/custom_textfield.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Element/responsive_size_value.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/register_notifier.dart';
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
    return Scaffold(
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
                    child: Column(
                      children: [
                        paddingTop(15),
                        Text(CommonString.welcomeToQuiz, style: TextStyleTheme.customTextStyle(AppColors.black, 24, FontWeight.w700),),
                        paddingTop(10),
                        Text(CommonString.signUp, style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w600),),
                        paddingTop(10),
                        customTextField(TextEditingController(), "Name", "sam"),
                        paddingTop(15),
                        customTextField(TextEditingController(), "Email", "sam@mail.com"),
                        paddingTop(15),
                        customTextField(TextEditingController(), "Password", "******", suffixIcon: AppImages.closeIcon),
                        paddingTop(15),
                        customTextField(TextEditingController(), "Confirm Password", "******", suffixIcon: AppImages.closeIcon),
                        paddingTop(15),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(color: AppColors.black)
                              ),
                              child: const Icon(Icons.check, size: 15,),
                            ),
                            paddingLeft(10),
                            Text("I agree to the", style: TextStyleTheme.customTextStyle(AppColors.black, 14.5, FontWeight.w400),),
                            paddingLeft(5),
                            Text(CommonString.termsAndPrivacy, style: TextStyleTheme.customTextStyle(AppColors.black, 14.5, FontWeight.w500),),
                          ],
                        ),
                        paddingTop(15),
                        commonButton(CommonString.signUp, width: 150),
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
                            Text(CommonString.login, style: TextStyleTheme.customTextStyle(AppColors.purple, 14.5, FontWeight.w500),),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
