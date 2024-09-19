import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Screens/MainScreen/HomeScreen/Take_Quize_Screen/take_quize_screen.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Helper/page_route.dart';
import 'package:earn_streak/src/Utils/Notifier/home_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

HomeScreen() => ChangeNotifierProvider<HomeNotifier>(create: (_) => HomeNotifier(), child: Builder(builder: (context) => const HomeScreenProvider()),);

class HomeScreenProvider extends StatelessWidget {
  const HomeScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight - 50,
      child: Scaffold(
          body: Consumer<HomeNotifier>(
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
                      left: 25.w, right: 25.w, top: 70.h,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: ScreenUtil().screenHeight,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Quizzit", style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),),
                                  Image.asset(AppImages.userImage, height: 32, width: 30,)
                                ],
                              ),
                              paddingTop(30),
                              Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Reading and comprehension", style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700), overflow: TextOverflow.ellipsis,),
                                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.", style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                          ],
                                        ),
                                      ),
                                      SvgPicture.asset(AppImages.bookIcon, width: 45.w, height: 50.h,)
                                    ],
                                  ),
                                ),
                              ),
                              paddingTop(10),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: 4,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(bottom: 160),
                                    itemBuilder: (context, index){
                                  return Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(AppImages.dummyImage, width: 60.w, height: 60.h,),
                                              paddingLeft(10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Blog Read", style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),),
                                                    Text("Lorem Ipsum is simply text , dummy text", style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600)),
                                                    Text("read more...", style: TextStyleTheme.customTextStyle(AppColors.blue, 12, FontWeight.w600)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          paddingTop(15),
                                          InkWell(
                                            onTap: (){push(context, TakeQuizScreen());},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.midLightGrey
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("Take Quiz", style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        gradient: const LinearGradient(colors: [Color(0xff7979FC), Color(0xff9B9BFF)]),
                                                        borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4),
                                                        child: Row(
                                                          children: [
                                                            Text("Start", style: TextStyleTheme.customTextStyle(AppColors.white, 16, FontWeight.w700),),
                                                            paddingLeft(5),
                                                            SvgPicture.asset(AppImages.rightArrowIcon, color: Colors.white, width: 15, height: 15,)
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
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
          )
      ),
    );
  }
}
