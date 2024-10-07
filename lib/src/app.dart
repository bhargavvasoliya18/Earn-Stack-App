import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Screens/SplashScreen/splash_screen.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Utils/app_utils.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool isCheckLogin = false;

  @override
  void initState() {
    loadUserDataSharedPrefs();
    isLogin();
    super.initState();
  }

  getToken() async {
    loginResponseModel.deviceToken = (await fcm.getToken()) ?? '';
    print("Device Token ${loginResponseModel.deviceToken}");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return OverlaySupport.global(
      child: StyledToast(
        toastAnimation: StyledToastAnimation.size,
        reverseAnimation: StyledToastAnimation.size,
        locale: const Locale('en', 'US'),
        fullWidth: false,
        isHideKeyboard: false,
        isIgnoring: true,
        child: MaterialApp(
            title: 'Flutter Demo',
            navigatorKey: rootNavigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: SplashScreen()
            // home: loginResponseModel.id?.isEmpty == true ? LoginScreen() : MainScreen()
            ),
      ),
    );
  }

  isLogin() async {
    setState(() async {
      isCheckLogin = await sharedPref.read("isLogin");
    });
  }
}
