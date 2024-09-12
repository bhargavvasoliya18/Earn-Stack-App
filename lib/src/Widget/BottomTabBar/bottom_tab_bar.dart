import 'dart:io';
import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Utils/Notifier/custom_bottom_tab_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../Constants/app_images.dart';

CustomBottomTabBar() => ChangeNotifierProvider(create: (_) => CustomBottomTabNotifier(),child: Builder(builder: (context) => CustomBottomTabBarProvider(context: context,),),);

class CustomBottomTabBarProvider extends StatelessWidget {
  BuildContext context;

  CustomBottomTabBarProvider({Key? key,required this.context}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    var state = Provider.of<CustomBottomTabNotifier>(context,listen: false);
      state.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    double bottombgHeight =  Platform.isAndroid == true ? 60 : 75;
    return Consumer<CustomBottomTabNotifier>(
        builder: (context, state, child) {
          Widget _icon(String icon, bool isEnable, int index) {
            return InkWell(
              onTap: () {state.onIconTap(context, index);},
              child: Container(
                margin: const EdgeInsets.only(top: 15, right: 5, left: 5),
                child: SvgPicture.asset(icon, height: isEnable ? 35 : 21, width: isEnable ? 35 : 21, fit: BoxFit.contain,),
              ),
            );
          }

          Widget _buildBackground({Widget? child}) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                boxShadow: [ BoxShadow(spreadRadius:1,blurRadius: 12,color: AppColors.black.withOpacity(0.2)) ],
              ),
              child: child,
            );
          }

          return SizedBox(
            width: appSize.width,
            height: bottombgHeight,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  width: appSize.width,
                  height: bottombgHeight,
                  child: _buildBackground(
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _icon(selectedBottomTab == 0 ? AppImages.home1Icon : AppImages.unSelectHomeIcon, selectedBottomTab == 0, 0),
                          _icon(selectedBottomTab == 1 ? AppImages.home2Icon : AppImages.unSelectBoardIcon, selectedBottomTab == 1,  1),
                          _icon(selectedBottomTab == 2 ? AppImages.home3Icon : AppImages.unSelectShareIcon, selectedBottomTab == 2, 2),
                          _icon(selectedBottomTab == 3 ? AppImages.home4Icon : AppImages.unSelectSettingIcon, selectedBottomTab == 3, 3),
                        ],
                      ),
                    ),),
                ),
              ],
            ),
          );
        }
    );
  }
}