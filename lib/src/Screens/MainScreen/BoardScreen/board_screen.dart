import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/board_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

BoardScreen()=> ChangeNotifierProvider<BoardNotifier>(create: (_) => BoardNotifier(), child: Builder(builder: (context) => const BoardScreenProvider()),);

class BoardScreenProvider extends StatelessWidget {
  const BoardScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight - 50,
      child: Scaffold(
        body:  Consumer<BoardNotifier>(
          builder: (context, state, child) =>
              Stack(
                children: [
                  SizedBox(
                    height: ScreenUtil().screenHeight,
                    child: Column(
                      children: [
                        commonAppBar(height: 250)
                      ],
                    ),
                  ),
                  Positioned(
                    left: 25, right: 25, top: 70,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: ScreenUtil().screenHeight,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(BoardString.board, style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),),
                                Image.asset(AppImages.userImage, height: 32, width: 30,)
                              ],
                            ),
                            paddingTop(30),
                            Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ListView.builder(
                                   itemCount: state.boardList.length,
                                   shrinkWrap: true,
                                   padding: EdgeInsets.zero,
                                   itemBuilder: (context, index){
                                     var model = state.boardList[index];
                                     int lastIndex = state.boardList.length - 1;
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(model.image ?? "", height: 40, width: 40,),
                                          Text(model.title ?? "", style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),),
                                          SvgPicture.asset(AppImages.leftBackIcon, height: 40, width: 40,)
                                        ],
                                      ),
                                     lastIndex != index ? Divider(color: AppColors.black.withOpacity(0.5),) : Container()
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        )
      ),
    );
  }
}
