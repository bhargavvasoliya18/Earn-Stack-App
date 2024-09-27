import 'dart:io';
import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Screens/MainScreen/HomeScreen/TakeQuizeScreen/Module/web_view.dart';
import 'package:earn_streak/src/Screens/MainScreen/HomeScreen/TakeQuizeScreen/take_quize_screen.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Helper/page_route.dart';
import 'package:earn_streak/src/Utils/Notifier/home_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

HomeScreen() => ChangeNotifierProvider<HomeNotifier>(
      create: (_) => HomeNotifier(),
      child: Builder(builder: (context) => HomeScreenProvider(context:  context)),
    );

class HomeScreenProvider extends StatelessWidget {

  BuildContext context;

   HomeScreenProvider({super.key, required this.context}){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       var state = Provider.of<HomeNotifier>(context, listen: false);
       state.iniState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight - 50,
      child: Scaffold(
          backgroundColor: AppColors.colorF8F7FF,
          body: Consumer<HomeNotifier>(
            builder: (context, state, child) => Stack(
              children: [
                SizedBox(
                  height: ScreenUtil().screenHeight,
                  child: Column(
                    children: [commonAppBar(height: 250)],
                  ),
                ),
                Positioned(
                  left: 25.w,
                  right: 25.w,
                  top: 40.h,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: ScreenUtil().screenHeight,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Quizzit", style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),),
                              Image.asset(
                                AppImages.userImage,
                                height: 32,
                                width: 30,
                              )
                            ],
                          ),
                          paddingTop(15),
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
                                        Text(
                                          "Reading and comprehension",
                                          style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                          style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    AppImages.bookIcon,
                                    width: 45.w,
                                    height: 50.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                          paddingTop(10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.articleList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: Platform.isIOS ? 170 : 160),
                              itemBuilder: (context, index) {
                                var item = state.articleList[index];
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12.sp),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  AppImages.dummyImage,
                                                  width: 80.w,
                                                  height: 80.h,
                                                ),
                                                paddingLeft(10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        item.title ?? '',
                                                        style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),
                                                      ),
                                                      Text(item.content ?? '',
                                                          style: TextStyleTheme.customTextStyle(
                                                              AppColors.lightGrey, 14, FontWeight.w600),overflow: TextOverflow.ellipsis,maxLines: 3,),
                                                      paddingTop(5),
                                                      GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_) => TimeSpentInURLExample()));},
                                                        child: Container(
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.colorC2C2CC),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                                            child: Text(
                                                              "Read more",
                                                              style: TextStyleTheme.customTextStyle(
                                                                AppColors.white,
                                                                14,
                                                                FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            paddingTop(15),
                                            InkWell(
                                              onTap: () {
                                               (state.articleList[index].quizs?.isNotEmpty ?? false) ? push(context, TakeQuizScreen(articleModel: state.articleList[index])) : null;
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12.sp),
                                                  color: AppColors.midLightGrey,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Take Quiz", style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: AppColors.lightBlue),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                                          child: Row(
                                                            children: [
                                                              Text("Start", style: TextStyleTheme.customTextStyle(AppColors.lightBlue, 16, FontWeight.w700),),
                                                              paddingLeft(8),
                                                              SvgPicture.asset(
                                                                AppImages.rightArrowIcon,
                                                                width: 15,
                                                                height: 15,
                                                              )
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
                                    ),
                                    paddingTop(10),
                                  ],
                                );
                              },
                            ),
                          ),
                          paddingTop(20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
