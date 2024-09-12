import 'package:earn_streak/src/Utils/Notifier/setting_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

SettingScreen() => ChangeNotifierProvider<SettingNotifier>(create: (_) => SettingNotifier(), child: Builder(builder: (context) => const SettingScreenProvider()),);

class SettingScreenProvider extends StatelessWidget {
  const SettingScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight - 50,
      child: const Scaffold(
        body: Center(
            child: Text("Setting Screen")
        ),
      ),
    );
  }
}
