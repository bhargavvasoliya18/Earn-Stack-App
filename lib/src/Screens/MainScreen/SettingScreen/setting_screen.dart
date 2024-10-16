import 'package:earn_streak/src/Screens/Auth/profile_screen.dart';
import 'package:earn_streak/src/Utils/Helper/page_route.dart';
import 'package:earn_streak/src/Utils/Notifier/setting_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Constants/app_colors.dart';
import '../../../Constants/app_images.dart';
import '../../../Element/padding_class.dart';
import '../../../Style/text_style.dart';
import '../../../Utils/Notifier/login_notifier.dart';
import '../../../Widget/common_network_image.dart';

SettingScreen() => ChangeNotifierProvider<SettingNotifier>(
      create: (_) => SettingNotifier(),
      child: Builder(builder: (context) => SettingScreenProvider(context: context)),
    );

class SettingScreenProvider extends StatelessWidget {
  BuildContext context;

  SettingScreenProvider({super.key, required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var state = Provider.of<SettingNotifier>(context, listen: false);
      state.getCommonUrlApiCall(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingNotifier>(
      builder: (BuildContext context, state, child) => SizedBox(
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
            padding: EdgeInsets.only(left: 20, top: 40.h, right: 20, bottom: 50),
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
                      onTap: () {
                        push(context, ProfileScreen());
                      },
                      child: fadeImageView(loginResponseModel.profile?.thumbnail ?? "", placeHolderSize: 40),
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
                            MenuClass(
                                onTap: () {
                                  debugPrint('${state.commonModel.termsService}');
                                  launchUrl(
                                    Uri.parse(state.commonModel.termsService ?? ""),
                                  );
                                },
                                icon: AppImages.termServiceIcon,
                                name: "Terms of Service"),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Divider(thickness: 1, color: AppColors.purple),
                            ),
                            MenuClass(
                                onTap: () {
                                  launchUrl(Uri.parse(state.commonModel.privacyPolicy ?? ""));
                                },
                                icon: AppImages.privacyPolicyIcon,
                                name: "Privacy Policy"),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Divider(thickness: 1, color: AppColors.purple),
                            ),
                            MenuClass(
                                onTap: () {
                                  launchUrl(Uri.parse(state.commonModel.googlePlayStore ?? ""));
                                },
                                icon: AppImages.rateUsGoogleIcon,
                                name: "Rate us on google play"),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Divider(thickness: 1, color: AppColors.purple),
                            ),
                            MenuClass(
                                onTap: () {
                                  launchUrl(Uri.parse(state.commonModel.contactUs ?? ""));
                                },
                                icon: AppImages.contactUsIcon,
                                name: "Contact us"),
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
                            state.commonModel.social?.instgram != ""
                                ? MenuClass(
                                    onTap: () {
                                      launchUrl(Uri.parse(state.commonModel.social?.instgram ?? ""));
                                    },
                                    icon: AppImages.instagramIcon,
                                    name: "Follow on Instagram")
                                : Offstage(),
                            state.commonModel.social?.instgram != ""
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Divider(thickness: 1, color: AppColors.purple),
                                  )
                                : Offstage(),
                            state.commonModel.social?.facebook != ""
                                ? MenuClass(
                                    onTap: () {
                                      launchUrl(Uri.parse(state.commonModel.social?.facebook ?? ""));
                                    },
                                    icon: AppImages.facebookIcon,
                                    name: "Follow on Facebook")
                                : Offstage(),
                            state.commonModel.social?.facebook != ""
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Divider(thickness: 1, color: AppColors.purple),
                                  )
                                : Offstage(),
                            state.commonModel.social?.whatsapp != ""
                                ? MenuClass(
                                    onTap: () {
                                      launchUrl(Uri.parse(state.commonModel.social?.whatsapp ?? ""));
                                    },
                                    icon: AppImages.whatsappIcon,
                                    name: "Follow on Whatsapp")
                                : Offstage(),
                            state.commonModel.social?.whatsapp != ""
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Divider(thickness: 1, color: AppColors.purple),
                                  )
                                : Offstage(),
                            state.commonModel.social?.youtube != ""
                                ? MenuClass(
                                    onTap: () {
                                      launchUrl(Uri.parse(state.commonModel.social?.youtube ?? ""));
                                    },
                                    icon: AppImages.youtubeIcon,
                                    name: "Follow on Youtube")
                                : Offstage(),
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
