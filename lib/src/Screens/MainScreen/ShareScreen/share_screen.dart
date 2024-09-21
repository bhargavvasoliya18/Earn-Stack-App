import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Utils/Notifier/share_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
      // height: ScreenUtil().screenHeight - 80,
      height: ScreenUtil().screenHeight,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: ScreenUtil().screenHeight - 100,
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.only(left: 20, top: 60, right: 20),
              child: ClipRRect(
               borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  AppImages.shareBackground,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 400,
              left: 60,
              right: 60,
              child: Column(
                children: [
                  Text(
                    "Refer your friends",
                    style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w600),
                  ),
                  paddingTop(30.h),
                  paddingTop(10.h),
                  Text(
                    "Share your code",
                    style: TextStyleTheme.customTextStyle(AppColors.white, 14, FontWeight.w400),
                  ),
                  paddingTop(20.h),
                  Divider(thickness: 1.sp,color: AppColors.white,),
                  paddingTop(10.h),
                  Text(
                    "Lorem Ipsum is simply dummy text",
                    style: TextStyleTheme.customTextStyle(AppColors.white, 16, FontWeight.w700),
                  ),
                  paddingTop(10.h),
                  Text(
                    "Contrary to popular belief, Lorem Ipsum is not simply random text.",
                    textAlign: TextAlign.center,
                    style: TextStyleTheme.customTextStyle(AppColors.white, 14, FontWeight.w400,),
                  ),
                  paddingTop(10.h),
                  Stack(
                    children: [
                      Image.asset(
                        AppImages.buttonBackground,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 15,
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

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
