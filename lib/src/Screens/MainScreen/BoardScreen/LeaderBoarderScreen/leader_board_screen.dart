import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/leader_board_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

LeaderBoardScreen()=> ChangeNotifierProvider<LeaderBoardNotifier>(create: (_) => LeaderBoardNotifier(), child: Builder(builder: (context) => const LeaderBoardScreenProvider()),);

class LeaderBoardScreenProvider extends StatelessWidget {
  const LeaderBoardScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<LeaderBoardNotifier>(
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
                              children: [
                                GestureDetector(
                                    onTap: (){Navigator.pop(context);},
                                    child: SvgPicture.asset(AppImages.leftBackIcon)),
                                paddingLeft(10),
                                Text(BoardString.leaderBoard, style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),),
                              ],
                            ),
                            paddingTop(10),
                            Card(
                              color: const Color(0xffEDEAFC),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap : (){state.selectTabIndex(0);},
                                      child: Container(
                                          decoration: BoxDecoration(color: state.selectIndex == 0 ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                            child: Center(child: Text("Daily", style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w700),)),
                                          )),
                                    ),
                                    InkWell(
                                      onTap: (){state.selectTabIndex(1);},
                                      child: Container(
                                          decoration: BoxDecoration(color: state.selectIndex == 1 ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                            child: Text("Weekly", style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w700),),
                                          )),
                                    ),
                                    InkWell(
                                      onTap: (){state.selectTabIndex(2);},
                                      child: Container(
                                          decoration: BoxDecoration(color: state.selectIndex == 2 ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                            child: Text("Monthly", style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w700),),
                                          )),
                                    ),
                                  ],
                                )
                              ),
                            ),
                            paddingTop(10),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        SvgPicture.asset(AppImages.silverTajIcon),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: Image.asset(AppImages.secondImage, height: 67, width: 67,)),
                                        Text("Lorem ipsum", style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w700),),
                                        Text("3560", style: TextStyleTheme.customTextStyle(const Color(0xffFD8002), 16, FontWeight.w600),),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SvgPicture.asset(AppImages.goldTajIcon),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: Image.asset(AppImages.secondImage, height: 89, width: 89,)),
                                        Text("Lorem ipsum", style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w700),),
                                        Text("3560", style: TextStyleTheme.customTextStyle(const Color(0xffFD8002), 16, FontWeight.w600),),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SvgPicture.asset(AppImages.bronzeTajIcon),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: Image.asset(AppImages.secondImage, height: 67, width: 67,)),
                                        Text("Lorem ipsum", style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w700),),
                                        Text("3560", style: TextStyleTheme.customTextStyle(const Color(0xffFD8002), 16, FontWeight.w600),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            paddingTop(10),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(bottom: 80),
                                  itemBuilder: (context, index){
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("1", style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w400),),
                                            paddingLeft(10),
                                            ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: Image.asset(AppImages.secondImage, height: 40, width: 40,)),
                                            paddingLeft(10),
                                            Text("Lorem ipsum", style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w600),),
                                          ],
                                        ),
                                        Text("2450", style: TextStyleTheme.customTextStyle(const Color(0xffFD8002), 16, FontWeight.w600),),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        ),
    );
  }
}
