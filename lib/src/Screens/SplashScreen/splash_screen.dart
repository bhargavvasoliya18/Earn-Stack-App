import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Screens/Auth/login_screen.dart';
import 'package:earn_streak/src/Screens/MainScreen/main_screen.dart';
import 'package:earn_streak/src/Utils/Helper/page_route.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import '../OnbordingScreen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadUserDataSharedPrefs().then((value) {
      Future.delayed(Duration(seconds: 2), () async {
        if (await sharedPref.read("isOnBoardComplete") == null) {
          sharedPref.save("isOnBoardComplete", false);
        }
        if (await sharedPref.read("isOnBoardComplete")  == false) {
          pushReplacement(context, OnBoardingScreen());
        } else {
          loginResponseModel.id.toString().isEmpty == true ||
                  loginResponseModel.id == null
              ? pushReplacement(context, LoginScreen())
              : pushReplacement(context, MainScreen());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.splashScreenImage,
          height: ScreenUtil().screenHeight,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
