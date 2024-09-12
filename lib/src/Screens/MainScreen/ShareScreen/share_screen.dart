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
      height: ScreenUtil().screenHeight - 50,
      child: const Scaffold(
        body: Center(
            child: Text("Share Screen")
        ),
      ),
    );
  }
}
