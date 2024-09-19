import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Utils/Notifier/share_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

ShareScreen() => ChangeNotifierProvider<ShareNotifier>(create: (_) => ShareNotifier(), child: Builder(builder: (context) => const ShareScreenProvider()),);

class ShareScreenProvider extends StatelessWidget {
  const ShareScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: ScreenUtil().screenHeight - 80,
      height:ScreenUtil().screenHeight,
      child: Scaffold(
        body: Column(
          children: [
            paddingTop(50),
            Image.asset(AppImages.shareBackground, ),
          ],
        )
      ),
    );
  }
}
