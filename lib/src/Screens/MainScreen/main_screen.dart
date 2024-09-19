import 'package:earn_streak/src/Screens/MainScreen/BoardScreen/board_screen.dart';
import 'package:earn_streak/src/Screens/MainScreen/HomeScreen/home_screen.dart';
import 'package:earn_streak/src/Screens/MainScreen/SettingScreen/setting_screen.dart';
import 'package:earn_streak/src/Screens/MainScreen/ShareScreen/share_screen.dart';
import 'package:earn_streak/src/Utils/Notifier/custom_bottom_tab_notifier.dart';
import 'package:earn_streak/src/Widget/BottomTabBar/bottom_tab_bar.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

// PageController bottomTabPageController = PageController(initialPage: 0,keepPage: false);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: ExpandablePageView(
            controller: bottomTabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              BoardScreen(),
              ShareScreen(),
              SettingScreen(),
            ],
          ),
        ),
        bottomNavigationBar: customBottomTabBar(),
      ),
    );
  }
}
