import 'package:earn_streak/src/Utils/Notifier/board_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

BoardScreen()=> ChangeNotifierProvider<BoardNotifier>(create: (_) => BoardNotifier(), child: Builder(builder: (context) => const BoardScreenProvider()),);

class BoardScreenProvider extends StatelessWidget {
  const BoardScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight - 50,
      child: const Scaffold(
        body: Center(
            child: Text("Board Screen")
        ),
      ),
    );
  }
}
