import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Screens/MainScreen/BoardScreen/LeaderBoarderScreen/Module/top_list_view.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/leader_board_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:earn_streak/src/Widget/common_network_image.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';


class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    var state = Provider.of<LeaderBoardNotifier>(context, listen: false);
    state.iniState(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      body: Consumer<LeaderBoardNotifier>(
        builder: (context, state, child) => Stack(
          children: [
            SizedBox(
              height: ScreenUtil().screenHeight,
              child: Column(
                children: [commonAppBar(height: 250)],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              top: 40.h,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: ScreenUtil().screenHeight,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: SvgPicture.asset(AppImages.leftBackIcon),
                            ),
                          ),
                          paddingLeft(10),
                          Text(
                            BoardString.leaderBoard,
                            style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),
                          ),
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
                                  onTap: () {
                                    state.selectTabIndex(0, context, loginResponseModel.id, "daily");
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: state.selectIndex == 0 ? Colors.white : Colors.transparent,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                        child: Center(
                                            child: Text(
                                              "Daily",
                                              style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w700),
                                            )),
                                      )),
                                ),
                                InkWell(
                                  onTap: () {
                                    state.selectTabIndex(1, context, loginResponseModel.id, "weekly");
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: state.selectIndex == 1 ? Colors.white : Colors.transparent,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                        child: Text(
                                          "Weekly",
                                          style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w700),
                                        ),
                                      )),
                                ),
                                InkWell(
                                  onTap: () {
                                    state.selectTabIndex(2, context, loginResponseModel.id, "monthly");
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: state.selectIndex == 2 ? Colors.white : Colors.transparent,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                        child: Text(
                                          "Monthly",
                                          style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w700),
                                        ),
                                      )),
                                ),
                              ],
                            )),
                      ),
                      paddingTop(10),
                      if(state.selectIndex == 0)
                      state.lenderBoardList.isNotEmpty
                          ? Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              topListView(
                                  image: state.lenderBoardList.length > 1
                                      ? state.lenderBoardList[1].profile?.thumbnail ?? ""
                                      : "",
                                  name: state.lenderBoardList.length > 1 ? state.lenderBoardList[1].displayName ?? "" : "",
                                  coin: state.lenderBoardList.length > 1
                                      ? state.lenderBoardList[1].earnappUserEarnCoin ?? ""
                                      : "",
                                  imageSize: 67,
                                  tajImage: AppImages.silverTajIcon),
                              topListView(
                                  image: state.lenderBoardList.isNotEmpty
                                      ? state.lenderBoardList[0].profile?.thumbnail ?? ""
                                      : "",
                                  name: state.lenderBoardList.isNotEmpty ? state.lenderBoardList[0].displayName ?? "" : "",
                                  coin: state.lenderBoardList.isNotEmpty
                                      ? state.lenderBoardList[0].earnappUserEarnCoin ?? ""
                                      : "",
                                  tajImage: AppImages.goldTajIcon),
                              topListView(
                                  image: state.lenderBoardList.length > 2
                                      ? state.lenderBoardList[2].profile?.thumbnail ?? ""
                                      : "",
                                  name: state.lenderBoardList.length > 2 ? state.lenderBoardList[2].displayName ?? "" : "",
                                  coin: state.lenderBoardList.length > 2
                                      ? state.lenderBoardList[2].earnappUserEarnCoin ?? ""
                                      : "",
                                  imageSize: 67,
                                  tajImage: AppImages.bronzeTajIcon),
                            ],
                          ),
                        ),
                      )
                          : Offstage(),
                      if(state.selectIndex == 1)
                        state.weeklyLenderBoardList.isNotEmpty
                            ? Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                topListView(
                                    image: state.weeklyLenderBoardList.length > 1
                                        ? state.weeklyLenderBoardList[1].profile?.thumbnail ?? ""
                                        : "",
                                    name: state.weeklyLenderBoardList.length > 1 ? state.weeklyLenderBoardList[1].displayName ?? "" : "",
                                    coin: state.weeklyLenderBoardList.length > 1
                                        ? state.weeklyLenderBoardList[1].earnappUserEarnCoin ?? ""
                                        : "",
                                    imageSize: 67,
                                    tajImage: AppImages.silverTajIcon),
                                topListView(
                                    image: state.weeklyLenderBoardList.isNotEmpty
                                        ? state.weeklyLenderBoardList[0].profile?.thumbnail ?? ""
                                        : "",
                                    name: state.weeklyLenderBoardList.isNotEmpty ? state.weeklyLenderBoardList[0].displayName ?? "" : "",
                                    coin: state.weeklyLenderBoardList.isNotEmpty
                                        ? state.weeklyLenderBoardList[0].earnappUserEarnCoin ?? ""
                                        : "",
                                    tajImage: AppImages.goldTajIcon),
                                topListView(
                                    image: state.weeklyLenderBoardList.length > 2
                                        ? state.weeklyLenderBoardList[2].profile?.thumbnail ?? ""
                                        : "",
                                    name: state.weeklyLenderBoardList.length > 2 ? state.weeklyLenderBoardList[2].displayName ?? "" : "",
                                    coin: state.weeklyLenderBoardList.length > 2
                                        ? state.weeklyLenderBoardList[2].earnappUserEarnCoin ?? ""
                                        : "",
                                    imageSize: 67,
                                    tajImage: AppImages.bronzeTajIcon),
                              ],
                            ),
                          ),
                        )
                            : Offstage(),
                      if(state.selectIndex == 2)
                        state.monthlyLenderBoardList.isNotEmpty
                            ? Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                topListView(
                                    image: state.monthlyLenderBoardList.length > 1
                                        ? state.monthlyLenderBoardList[1].profile?.thumbnail ?? ""
                                        : "",
                                    name: state.monthlyLenderBoardList.length > 1 ? state.monthlyLenderBoardList[1].displayName ?? "" : "",
                                    coin: state.monthlyLenderBoardList.length > 1
                                        ? state.monthlyLenderBoardList[1].earnappUserEarnCoin ?? ""
                                        : "",
                                    imageSize: 67,
                                    tajImage: AppImages.silverTajIcon),
                                topListView(
                                    image: state.monthlyLenderBoardList.isNotEmpty
                                        ? state.monthlyLenderBoardList[0].profile?.thumbnail ?? ""
                                        : "",
                                    name: state.monthlyLenderBoardList.isNotEmpty ? state.monthlyLenderBoardList[0].displayName ?? "" : "",
                                    coin: state.monthlyLenderBoardList.isNotEmpty
                                        ? state.monthlyLenderBoardList[0].earnappUserEarnCoin ?? ""
                                        : "",
                                    tajImage: AppImages.goldTajIcon),
                                topListView(
                                    image: state.monthlyLenderBoardList.length > 2
                                        ? state.monthlyLenderBoardList[2].profile?.thumbnail ?? ""
                                        : "",
                                    name: state.monthlyLenderBoardList.length > 2 ? state.monthlyLenderBoardList[2].displayName ?? "" : "",
                                    coin: state.monthlyLenderBoardList.length > 2
                                        ? state.monthlyLenderBoardList[2].earnappUserEarnCoin ?? ""
                                        : "",
                                    imageSize: 67,
                                    tajImage: AppImages.bronzeTajIcon),
                              ],
                            ),
                          ),
                        )
                            : Offstage(),
                      paddingTop(10),
                      if(state.selectIndex == 0)
                      state.lenderBoardList.length > 3
                          ? Expanded(
                        child: LazyLoadScrollView(
                          onEndOfPage: () {
                            state.onScroll(context);
                          },
                          isLoading: state.isLoadMore,
                          child: RefreshIndicator(
                            onRefresh: ()async{
                              state.pullToRefresh(context);
                            },
                            child: ListView.builder(
                                itemCount: state.lenderBoardList.length - 4,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 80),
                                itemBuilder: (context, index) {
                                  var model = state.lenderBoardList[index + 4];
                                  int lastIndex = state.lenderBoardList.length - 5;
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(18),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${index + 4}",
                                                    style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w400),
                                                  ),
                                                  paddingLeft(10),
                                                  ClipRRect(
                                                      borderRadius: BorderRadius.circular(100),
                                                      child: fadeImageView(model.profile?.thumbnail ?? "", placeHolderSize: 40)),
                                                  paddingLeft(10),
                                                  SizedBox(
                                                    width: 150.w,
                                                    child: Text(
                                                      model.displayName ?? "",
                                                      style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w600),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    AppImages.courncyIcon,
                                                    height: 15,
                                                  ),
                                                  paddingLeft(02),
                                                  Text(
                                                    model.earnappUserEarnCoin ?? "",
                                                    style: TextStyleTheme.customTextStyle(AppColors.green, 16, FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      index == lastIndex  ? state.isLoadMore ? loader : Offstage() : Offstage(),
                                      paddingBottom(index == lastIndex && state.isLoadMore ? 20 : 0),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      )
                          : SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Center(child: Text("No data found...!!!"))),
                      if(state.selectIndex == 1)
                        state.weeklyLenderBoardList.length > 3
                            ? Expanded(
                          child: LazyLoadScrollView(
                            onEndOfPage: () {
                              state.onScroll(context);
                            },
                            isLoading: state.isLoadMore,
                            child: RefreshIndicator(
                              onRefresh: ()async{
                                state.pullToRefresh(context);
                              },
                              child: ListView.builder(
                                  itemCount: state.weeklyLenderBoardList.length - 4,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(bottom: 80),
                                  itemBuilder: (context, index) {
                                    var model = state.weeklyLenderBoardList[index + 4];
                                    var lastIndex = state.weeklyLenderBoardList.length - 5;
                                    return Column(
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(18),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${index + 4}",
                                                      style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w400),
                                                    ),
                                                    paddingLeft(10),
                                                    ClipRRect(
                                                        borderRadius: BorderRadius.circular(100),
                                                        child: fadeImageView(model.profile?.thumbnail ?? "", placeHolderSize: 40)),
                                                    paddingLeft(10),
                                                    SizedBox(
                                                      width: 150.w,
                                                      child: Text(
                                                        model.displayName ?? "",
                                                        style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w600),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      AppImages.courncyIcon,
                                                      height: 15,
                                                    ),
                                                    paddingLeft(02),
                                                    Text(
                                                      model.earnappUserEarnCoin ?? "",
                                                      style: TextStyleTheme.customTextStyle(AppColors.green, 16, FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        index == lastIndex && state.isLoadMore? loader : Offstage()
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        )
                            : SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Center(child: Text("No data found...!!!"))),
                        if(state.selectIndex == 2)
                          state.monthlyLenderBoardList.length > 3
                              ? Expanded(
                            child: LazyLoadScrollView(
                              onEndOfPage: () {
                                state.onScroll(context);
                              },
                              isLoading: state.isLoadMore,
                              child: RefreshIndicator(
                                onRefresh: ()async{
                                  state.pullToRefresh(context);
                                },
                                child: ListView.builder(
                                    itemCount: state.monthlyLenderBoardList.length - 4,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(bottom: 80),
                                    itemBuilder: (context, index) {
                                      var model = state.monthlyLenderBoardList[index + 4];
                                      var lastIndex = state.monthlyLenderBoardList.length - 5;
                                      return Column(
                                        children: [
                                          Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(18),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${index + 4}",
                                                        style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w400),
                                                      ),
                                                      paddingLeft(10),
                                                      ClipRRect(
                                                          borderRadius: BorderRadius.circular(100),
                                                          child: fadeImageView(model.profile?.thumbnail ?? "", placeHolderSize: 40)),
                                                      paddingLeft(10),
                                                      SizedBox(
                                                        width: 150.w,
                                                        child: Text(
                                                          model.displayName ?? "",
                                                          style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w600),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(AppImages.courncyIcon, height: 15,),
                                                      paddingLeft(02),
                                                      Text(
                                                        model.earnappUserEarnCoin ?? "",
                                                        style: TextStyleTheme.customTextStyle(AppColors.green, 16, FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          index == lastIndex && state.isLoadMore? loader : Offstage()
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ) : SizedBox(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: Center(child: Text("No data found...!!!"))),
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
