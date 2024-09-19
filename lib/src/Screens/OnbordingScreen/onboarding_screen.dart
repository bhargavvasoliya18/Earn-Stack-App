import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Element/responsive_size_value.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/onboarding_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

OnBoardingScreen() => ChangeNotifierProvider<OnBoardingNotifier>(create: (_) => OnBoardingNotifier(), child: Builder(builder: (context) => OnBoardingScreenProvider(context: context)),);

class OnBoardingScreenProvider extends StatelessWidget {
  OnBoardingScreenProvider({super.key, required BuildContext context}){
    WidgetsBinding.instance.addPostFrameCallback((_){
      var state = Provider.of<OnBoardingNotifier>(context, listen: false);
      state.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<OnBoardingNotifier>(
          builder: (context, state, child) =>
           Stack(
            children: [
              SizedBox(
                height: ScreenUtil().screenHeight ,
                child: Column(
                  children: [
                    ClipPath(
                      clipper: CircularBottomClipper(),
                      child: Container(
                        width: setWidth(ScreenUtil().screenWidth),
                        height: 300,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff7979FC), Color(0xff9B9BFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 25, right: 25, top: 100,
                child: SizedBox(
                    height: ScreenUtil().screenHeight / 1.2,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: ScreenUtil().screenWidth,
                              child: PageView.builder(
                                controller: state.pageController,
                                onPageChanged: (index){ state.onPageChange(index); },
                                itemCount: state.onBoardingList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var model = state.onBoardingList[index];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(state.onBoardingList[index].image ?? "", height: 294.h, width: ScreenUtil().screenWidth / 1.5, fit: BoxFit.cover,),
                                      paddingTop(10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Text(model.title ?? "", style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w800), textAlign: TextAlign.center,),
                                      ),
                                      paddingTop(08),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: SizedBox(width : 380.h, child: Text(model.subTitle ?? "", style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w500), textAlign: TextAlign.center,)),
                                      ),
                                      paddingTop(08),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: SizedBox(width : 380.h, child: Text(model.subSubTitle ?? "", style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w500), textAlign: TextAlign.center,)),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            paddingTop(15),
                            SizedBox(
                              height: 50,
                              width: ScreenUtil().screenWidth / 1.2,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                      onTap:(){state.navigateBackScreen();},
                                      child: Text(OnBoardingString.back, style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600),)),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.numberOfPages,
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context,index){
                                        return Center(
                                          child: AnimatedContainer(
                                            width: 8, height: 8,
                                            margin: const EdgeInsets.all(5),
                                            duration: const Duration(milliseconds: 300),
                                            decoration: state.currentPage == index ? const BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(colors: [Color(0xff7979FC), Color(0xff9B9BFF)])
                                            ) : const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:  Color(0xffE7E3FC),
                                          ),
                                          ),
                                        );
                                      }),
                                  GestureDetector(
                                      onTap: (){state.navigateScreen(context);},
                                      child: SvgPicture.asset(AppImages.rightArrowIcon, height: 25, width: 25))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        )
    );
  }
}
