import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Screens/Auth/Module/select_image.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Mixins/log_out_alert_dialog.dart';
import 'package:earn_streak/src/Utils/Notifier/home_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Widget/common_network_image.dart';

ProfileScreen() => ChangeNotifierProvider<ProfileNotifier>(
      create: (_) => ProfileNotifier(),
      child: Builder(builder: (context) => const ProfileScreenProvider()),
    );

class ProfileScreenProvider extends StatelessWidget {
  const ProfileScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (context, state, child) => SizedBox(
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
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: SvgPicture.asset(AppImages.leftBackIcon),
                      ),
                    ),
                    paddingLeft(10),
                    Text(
                      "Profile",
                      style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),
                    ),
                  ],
                ),
                paddingTop(15),
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
                            Stack(
                              children: [
                                fadeImageView(loginResponseModel.profile?.thumbnail ?? "",
                                    placeHolderSize: 100, borderRadius: 20),
                                // Container(
                                //   height: 100,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(10),
                                //   ),
                                //   child: Image.asset(
                                //     AppImages.userImage,
                                //   ),
                                // ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        selectImage(context, state);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: Colors.black),
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 12,
                                            ),
                                          )),
                                    ))
                              ],
                            ),
                            Text(
                              loginResponseModel.name ?? '',
                              style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w600),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.courncyIcon,
                                  height: 22,
                                ),
                                paddingLeft(02),
                                Text(
                                  (userCoins?.total.toString()) ?? "",
                                  style: TextStyleTheme.customTextStyle(AppColors.green, 24, FontWeight.w700),
                                ),
                              ],
                            ),
                            paddingTop(15),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.lightBlue), borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Invites",
                                        style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppImages.courncyIcon,
                                            height: 22,
                                          ),
                                          paddingLeft(02),
                                          Text(
                                            (userCoins?.inviteCoin.toString()) ?? "",
                                            style: TextStyleTheme.customTextStyle(AppColors.green, 24, FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Divider(thickness: 1, color: AppColors.purple),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Redeem",
                                        style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppImages.courncyIcon,
                                            height: 22,
                                          ),
                                          paddingLeft(02),
                                          Text(
                                            (userCoins?.reedmCoin.toString()) ?? "",
                                            style: TextStyleTheme.customTextStyle(AppColors.green, 24, FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
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
                            MenuClass(
                                onTap: () {
                                  showLogoutDialog(context);
                                },
                                icon: AppImages.logout,
                                name: "Logout"),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Divider(thickness: 1, color: AppColors.purple),
                            ),
                            MenuClass(
                                onTap: () {
                                  showDeactivateAccountDialog(context);
                                },
                                icon: AppImages.deActivate,
                                name: "Deactivate account"),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Divider(thickness: 1, color: AppColors.purple),
                            ),
                            MenuClass(
                                onTap: () {
                                  showDeleteAccountDialog(context);
                                },
                                icon: AppImages.deleteAccount,
                                name: "Delete account"),
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
