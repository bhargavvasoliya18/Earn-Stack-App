import 'package:earn_streak/src/Screens/Auth/profile_screen.dart';
import 'package:earn_streak/src/Utils/Helper/page_route.dart';
import 'package:earn_streak/src/Utils/Notifier/setting_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../Constants/app_colors.dart';
import '../../../Constants/app_images.dart';
import '../../../Element/padding_class.dart';
import '../../../Style/text_style.dart';

SettingScreen() => ChangeNotifierProvider<SettingNotifier>(
      create: (_) => SettingNotifier(),
      child: Builder(builder: (context) => const SettingScreenProvider()),
    );

class SettingScreenProvider extends StatelessWidget {
  const SettingScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight - 30,
      child: Scaffold(
        backgroundColor: AppColors.colorF8F7FF,
        body: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundImg),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.only(left: 20, top: 60, right: 20, bottom: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Setting",
                    style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: (){
                      push(context, ProfileScreen());
                    },
                    child: Image.asset(
                      AppImages.userImage,
                      height: 32,
                      width: 30,
                    ),
                  )
                ],
              ),
              paddingTop(20),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          MenuClass(onTap: () {}, icon: AppImages.termServiceIcon, name: "Terms of Service"),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(thickness: 1, color: AppColors.purple),
                          ),
                          MenuClass(onTap: () {}, icon: AppImages.privacyPolicyIcon, name: "Privacy Policy"),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(thickness: 1, color: AppColors.purple),
                          ),
                          MenuClass(onTap: () {}, icon: AppImages.rateUsGoogleIcon, name: "Rate us on google play"),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(thickness: 1, color: AppColors.purple),
                          ),
                          MenuClass(onTap: () {}, icon: AppImages.contactUsIcon, name: "Contact us"),
                        ],
                      ),
                    ),
                    paddingTop(20),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          MenuClass(onTap: () {}, icon: AppImages.instagramIcon, name: "Follow on Instagram"),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(thickness: 1, color: AppColors.purple),
                          ),
                          MenuClass(onTap: () {}, icon: AppImages.facebookIcon, name: "Follow on Facebook"),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(thickness: 1, color: AppColors.purple),
                          ),
                          MenuClass(onTap: () {}, icon: AppImages.whatsappIcon, name: "Follow on Whatsapp"),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(thickness: 1, color: AppColors.purple),
                          ),
                          MenuClass(onTap: () {}, icon: AppImages.youtubeIcon, name: "Follow on Youtube"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuClass extends StatelessWidget {
  final String? icon;
  final String? name;
  final GestureTapCallback? onTap;

  const MenuClass({super.key, this.icon, this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(icon!, height: 22.h, width: 22.w, fit: BoxFit.scaleDown),
          paddingLeft(12),
          Text(
            name ?? "",
            style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20.sp,
          )
        ],
      ),
    );
  }
}
