import 'dart:io';
import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Utils/Notifier/custom_bottom_tab_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Constants/app_images.dart';

customBottomTabBar() => ChangeNotifierProvider(
    create: (_) => CustomBottomTabNotifier(), child: Builder(builder: (context) => CustomBottomTabBarProvider(context: context)));

class CustomBottomTabBarProvider extends StatelessWidget {
  BuildContext context;

  CustomBottomTabBarProvider({super.key, required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var state = Provider.of<CustomBottomTabNotifier>(context, listen: false);
      state.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    double bottomBgHeight = Platform.isAndroid == true ? 60.h : 65.h;
    return Consumer<CustomBottomTabNotifier>(builder: (context, state, child) {
      Widget icon(String icon, bool isEnable, int index) {
        return InkWell(
          onTap: () {
            state.onIconTap(context, index);
          },
          child: Center(
            child: SvgPicture.asset(
              icon,
              height: isEnable ? 36.sp : 18.sp,
              width: isEnable ? 36.sp : 18.sp,
              fit: BoxFit.contain,
            ),
          ),
        );
      }

      Widget buildBackground({Widget? child}) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 12, color: AppColors.black.withOpacity(0.2))],
          ),
          child: child,
        );
      }

      return SizedBox(
        width: appSize.width,
        height: bottomBgHeight,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              width: appSize.width,
              height: bottomBgHeight,
              child: buildBackground(
                child: Container(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      icon(selectedBottomTab == 0 ? AppImages.home1Icon : AppImages.unSelectHomeIcon, selectedBottomTab == 0, 0),
                      icon(selectedBottomTab == 1 ? AppImages.home2Icon : AppImages.unSelectBoardIcon, selectedBottomTab == 1, 1),
                      icon(selectedBottomTab == 2 ? AppImages.home3Icon : AppImages.unSelectShareIcon, selectedBottomTab == 2, 2),
                      icon(selectedBottomTab == 3 ? AppImages.home4Icon : AppImages.unSelectSettingIcon, selectedBottomTab == 3,
                          3),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
