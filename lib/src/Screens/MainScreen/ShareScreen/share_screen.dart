import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/share_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Constants/app_colors.dart';
import '../../../Style/text_style.dart';

ShareScreen() => ChangeNotifierProvider<ShareNotifier>(
      create: (_) => ShareNotifier(),
      child: Builder(builder: (context) => const ShareScreenProvider()),
    );

class ShareScreenProvider extends StatelessWidget {
  const ShareScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: ScreenUtil().screenHeight - 80.h,
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  AppImages.shareBackground,
                  height: ScreenUtil().screenHeight,
                  width: ScreenUtil().screenWidth,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 100.h,
              left: 60,
              right: 60,
              child: Column(
                children: [
                  Image.asset(
                    AppImages.appLogo,
                    height: 150,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                  paddingTop(15),
                  Text(
                    "Refer your friends",
                    style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w600),
                  ),
                  paddingTop(20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.white, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 220,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              loginResponseModel.referralCode ?? '',
                              style: TextStyleTheme.customTextStyle(AppColors.white, 20, FontWeight.w600),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: SvgPicture.asset(
                              AppImages.copyTextIcon,
                              height: 25,
                              width: 25,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  paddingTop(12),
                  Text(
                    "Share your code",
                    style: TextStyleTheme.customTextStyle(AppColors.white, 14, FontWeight.w400),
                  ),
                  paddingTop(10.h),
                  Divider(
                    thickness: 1.sp,
                    color: AppColors.white,
                  ),
                  paddingTop(5.h),
                  Text(
                    "Lorem Ipsum is simply dummy text",
                    style: TextStyleTheme.customTextStyle(AppColors.white, 16, FontWeight.w700),
                  ),
                  paddingTop(8.h),
                  Text(
                    "Contrary to popular belief, Lorem Ipsum is not simply random text.",
                    textAlign: TextAlign.center,
                    style: TextStyleTheme.customTextStyle(
                      AppColors.white,
                      14,
                      FontWeight.w400,
                    ),
                  ),
                  paddingTop(10.h),
                  GestureDetector(
                    onTap: (){
                      Share.share('check out my website https://example.com', subject: 'Look what I made!');
                    },
                    child: Stack(
                      children: [
                        Image.asset(
                          AppImages.buttonBackground,
                          height: 70.h,
                          fit: BoxFit.scaleDown,
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 10.h,
                          child: Center(
                            child: Text(
                              "Invite Now",
                              textAlign: TextAlign.center,
                              style: TextStyleTheme.customTextStyle(AppColors.white, 16, FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
