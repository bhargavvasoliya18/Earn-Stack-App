import 'dart:io';
import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Screens/Auth/profile_screen.dart';
import 'package:earn_streak/src/Screens/MainScreen/HomeScreen/TakeQuizeScreen/take_quize_screen.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Helper/page_route.dart';
import 'package:earn_streak/src/Utils/Notifier/home_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/setting_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/Notifier/login_notifier.dart';
import '../../../Widget/common_network_image.dart';

HomeScreen() => ChangeNotifierProvider<SettingNotifier>(
  create: (_) => SettingNotifier(),
  child: ChangeNotifierProvider<HomeNotifier>(
        create: (_) => HomeNotifier(),
        child: Builder(builder: (context) => HomeScreenProvider(context:  context)),
      ),
);

class HomeScreenProvider extends StatefulWidget {

  BuildContext context;

   HomeScreenProvider({super.key, required this.context});

  @override
  State<HomeScreenProvider> createState() => _HomeScreenProviderState();
}


class _HomeScreenProviderState extends State<HomeScreenProvider> with WidgetsBindingObserver {

  @override
  void initState() {
    var settingState = Provider.of<SettingNotifier>(context, listen: false);
    var state = Provider.of<HomeNotifier>(context, listen: false);
      state.iniState(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      settingState.getCommonUrlApiCall(context);
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && timeLaunched != null) {
      timeResumed = DateTime.now();
      timeSpent = timeResumed!.difference(timeLaunched!);
      Provider.of<HomeNotifier>(context, listen: false).readArticleTimeApiCall(context, timeSpent?.inSeconds);
      Provider.of<HomeNotifier>(context, listen: false).readArticleAndUpdate(context);
      print("spend time ${timeSpent?.inSeconds}");
    }
  }

  DateTime? timeResumed;
  Duration? timeSpent;
  DateTime? timeLaunched;

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
      timeLaunched = DateTime.now();
      await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight - 50,
      child: Scaffold(
          backgroundColor: AppColors.colorF8F7FF,
          body: Consumer<SettingNotifier>(
            builder: (context, settingState, child) =>
             Consumer<HomeNotifier>(
              builder: (context, state, child){
                Widget loader = Padding(
                  padding: EdgeInsets.all(10),
                  child:  Center(child: SizedBox(height:50,width:50,child: CircularProgressIndicator(strokeWidth:3,color: AppColors.black,))),
                );
                return Stack(
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
                      top: 55.h,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: ScreenUtil().screenHeight,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Quizzit", style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),),
                                  GestureDetector(
                                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfileScreen()));},
                                      child: fadeImageView(loginResponseModel.profile?.thumbnail ?? "", placeHolderSize: 40)),
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
                                              settingState.commonModel.homeTitle ?? "",
                                              style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              settingState.commonModel.homeSubTitle ?? "",
                                              style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600),
                                              maxLines: 3,
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
                                child: LazyLoadScrollView(
                                  onEndOfPage: () { state.onScroll(context);},
                                  isLoading: state.isLoadMore,
                                  child: state.articleList.isNotEmpty ? ListView.builder(
                                    itemCount: state.articleList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(bottom: Platform.isIOS ? 170 : 160),
                                    itemBuilder: (context, index) {
                                      var item = state.articleList[index];
                                      print("status is ${state.articleList[index].isArticleComplete} ===> ${state.articleList[index].isQuizComplete}");
                                      return Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.sp),),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      fadeImageView(item.images?.thumbnail ?? "", placeHolderSize: 80.h),
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
                                                              onTap: state.articleList[index].isArticleComplete == true ? null : ()async{state.selectArticleId = item.id.toString(); state.notifyListeners(); await launchURL(item.url ?? "");},
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    color: state.articleList[index].isArticleComplete == true ? Color(0xffC2C2CC) : null,
                                                                    gradient: state.articleList[index].isArticleComplete == true ? null : LinearGradient(colors: const [
                                                                      Color(0xff7979FC),
                                                                      Color(0xff9B9BFF)
                                                                    ])
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                                                  child: Text("Read more", style: TextStyleTheme.customTextStyle(AppColors.white, 14, FontWeight.w400,),),
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
                                                    onTap: state.articleList[index].isQuizComplete == true ? null : () {
                                                      (state.articleList[index].quizs?.isNotEmpty ?? false) ? push(context, TakeQuizScreen(articleModel: state.articleList[index])) : null;
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.sp), color: AppColors.midLightGrey,),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("Take Quiz", style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: state.articleList[index].isQuizComplete == true ? Color(0xffC2C2CC) : AppColors.lightBlue),
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                                                child: Row(
                                                                  children: [
                                                                    Text("Start", style: TextStyleTheme.customTextStyle( state.articleList[index].isQuizComplete == true ? Color(0xffC2C2CC) : AppColors.lightBlue, 16, FontWeight.w700),),
                                                                    paddingLeft(8),
                                                                    SvgPicture.asset(
                                                                      AppImages.rightArrowIcon,
                                                                      width: 15,
                                                                      height: 15,
                                                                      color: state.articleList[index].isQuizComplete == true ? Color(0xffC2C2CC) : null,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          paddingTop(10),
                                        ],
                                      );
                                    },
                                  ) : Center(child: Text("No data found....!!!")),
                                ),
                              ),
                              state.isLoadMore?loader:Container(),
                              paddingTop(20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )),
    );
  }
}
