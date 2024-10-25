import 'dart:developer';
import 'dart:io';
import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Networking/FirebaseNotificationHelper/firebase_notification.dart';
import 'package:earn_streak/src/Screens/Auth/profile_screen.dart';
import 'package:earn_streak/src/Screens/MainScreen/HomeScreen/TakeQuizeScreen/take_quize_screen.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/home_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/setting_notifier.dart';
import 'package:earn_streak/src/Utils/app_utils.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/Notifier/login_notifier.dart';
import '../../../Widget/common_network_image.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    FirebaseMessagesHelper.initFirebaseMessage(context);
    var settingState = Provider.of<SettingNotifier>(context, listen: false);
    var state = Provider.of<HomeNotifier>(context, listen: false);
    print("check list length home screen ${state.articleList.length} pri title");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      settingState.commonModel.homeTitle != null || settingState.commonModel.homeTitle != ""
          ? settingState.getCommonUrlApiCall(context)
          : null;
    });
    getHomeTitle();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration(milliseconds: 100), (){
      state.iniState(context);
    });
    super.initState();
  }

  String? homeTitle;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  getHomeTitle() async {
    homeTitle = await sharedPref.read("homeTitle");
    print("home title $homeTitle");
  }

  bool isReadBlogApiCall = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log("check did change app value");
    if(isReadBlogApiCall){
      if (state == AppLifecycleState.resumed && timeLaunched != null) {
        timeResumed = DateTime.now();
        timeSpent = timeResumed!.difference(timeLaunched!);
        Provider.of<HomeNotifier>(context, listen: false).readArticleTimeApiCall(context, timeSpent?.inSeconds);
        Provider.of<HomeNotifier>(context, listen: false).isLoaderShow = true;
        log("spend time ${timeSpent?.inSeconds}");
        setState(() {
          isReadBlogApiCall = false;
        });
      }
    }
  }

  DateTime? timeResumed;
  Duration? timeSpent;
  DateTime? timeLaunched;

  Future<void> launchURL(String url) async {
    setState(() {
      isReadBlogApiCall = true;
    });
    final Uri uri = Uri.parse(url);
    timeLaunched = DateTime.now();
    await launchUrl(uri, mode: LaunchMode.externalApplication, webViewConfiguration: WebViewConfiguration(), );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight - 50,
      child: Scaffold(
          backgroundColor: AppColors.colorF8F7FF,
          body: Consumer<SettingNotifier>(
            builder: (context, settingState, child) => Consumer<HomeNotifier>(
              builder: (context, state, child) {
                Widget loader = Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Color(0xff7979FC),
                          ))),
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
                                  Text(
                                    "Quizzit",
                                    style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
                                      },
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
                                  onEndOfPage: () {
                                    state.onScroll(context);
                                  },
                                  isLoading: state.isLoadMore,
                                  child: state.articleList.isNotEmpty
                                      ? RefreshIndicator(
                                       onRefresh: ()async{
                                         state.articleList.clear();
                                         state.initStateArticleApiCall(context); },
                                        child: ListView.builder(
                                            itemCount: state.articleList.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(bottom: Platform.isIOS ? 170 : 160),
                                            itemBuilder: (context, index) {
                                              var item = state.articleList[index];
                                              var lastIndex = state.articleList.length - 1;
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
                                                              fadeImageView(item.images?.thumbnail ?? "",
                                                                  placeHolderSize: 80.h, placeImage: AppImages.placeImage),
                                                              paddingLeft(10),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      item.title ?? '',
                                                                      style: TextStyleTheme.customTextStyle(
                                                                          AppColors.black, 16, FontWeight.w700),
                                                                    ),
                                                                    Text(
                                                                      item.content ?? '',
                                                                      style: TextStyleTheme.customTextStyle(
                                                                          AppColors.lightGrey, 14, FontWeight.w600),
                                                                      overflow: TextOverflow.ellipsis,
                                                                      maxLines: 3,
                                                                    ),
                                                                    paddingTop(5),
                                                                    GestureDetector(
                                                                      onTap: () async {
                                                                        if (item.isArticleComplete == false) {
                                                                          await launchURL(
                                                                            item.url.toString(),
                                                                          );
                                                                          state.selectArticleId = item.id.toString();
                                                                          state.postTitle = item.title;
                                                                          Future.delayed(Duration(milliseconds: 1200), () {
                                                                            state.articleList[index].isArticleComplete = true;
                                                                            setState(() {});
                                                                          });
                                                                          // state.inAppTimeCount(
                                                                          //     context, item.url, item.title, item.id);
                                                                        }
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            color: state.articleList[index].isArticleComplete ==
                                                                                    true
                                                                                ? Color(0xffC2C2CC)
                                                                                : null,
                                                                            gradient:
                                                                                state.articleList[index].isArticleComplete == true
                                                                                    ? null
                                                                                    : LinearGradient(colors: const [
                                                                                        Color(0xff7979FC),
                                                                                        Color(0xff9B9BFF)
                                                                                      ])),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 18, vertical: 10),
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
                                                          state.articleList[index].quizs?.isNotEmpty ?? false
                                                              ? InkWell(
                                                                  onTap: () async {
                                                                    var res;
                                                                    if (state.articleList[index].isArticleComplete == true) {
                                                                      if (state.articleList[index].isQuizComplete == false) {
                                                                        res = await Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => TakeQuizScreen(
                                                                                      articleModel: state.articleList[index],
                                                                                    )));
                                                                        debugPrint("back return value $res");
                                                                        if (res == true) {
                                                                          state.articleList[index].isQuizComplete = true;
                                                                          setState(() {});
                                                                        }
                                                                      }
                                                                    } else {
                                                                      showSuccess(
                                                                        message: "Please first read blog",
                                                                        background: AppColors.lightBlue,
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(12.sp),
                                                                      color: AppColors.midLightGrey,
                                                                    ),
                                                                    child: Padding(
                                                                      padding:
                                                                          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "Take Quiz",
                                                                            style: TextStyleTheme.customTextStyle(
                                                                                state.articleList[index].isQuizComplete == true
                                                                                    ? Color(0xffC2C2CC)
                                                                                    : AppColors.black,
                                                                                16,
                                                                                FontWeight.w700),
                                                                          ),
                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                              border: Border.all(
                                                                                  color: state.articleList[index].isQuizComplete ==
                                                                                          true
                                                                                      ? Color(0xffC2C2CC)
                                                                                      : AppColors.lightBlue),
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(
                                                                                  horizontal: 18, vertical: 8),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "Start",
                                                                                    style: TextStyleTheme.customTextStyle(
                                                                                        state.articleList[index].isQuizComplete ==
                                                                                                true
                                                                                            ? Color(0xffC2C2CC)
                                                                                            : AppColors.lightBlue,
                                                                                        16,
                                                                                        FontWeight.w700),
                                                                                  ),
                                                                                  paddingLeft(8),
                                                                                  SvgPicture.asset(
                                                                                    AppImages.rightArrowIcon,
                                                                                    width: 15,
                                                                                    height: 15,
                                                                                    color:
                                                                                        state.articleList[index].isQuizComplete ==
                                                                                                true
                                                                                            ? Color(0xffC2C2CC)
                                                                                            : null,
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
                                                              : Offstage(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  paddingTop(10),
                                                  lastIndex == index ? state.isLoadMore ? loader : Container() : Offstage(),
                                                ],
                                              );
                                            },
                                          ),
                                      )
                                      : state.isLoaderShow ? Center(child: CircularProgressIndicator(),) : Center(child: Text("No data found....!!!")),
                                ),
                              ),
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
