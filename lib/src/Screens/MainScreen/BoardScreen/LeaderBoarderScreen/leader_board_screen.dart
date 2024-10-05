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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

LeaderBoardScreen() => ChangeNotifierProvider<LeaderBoardNotifier>(
      create: (_) => LeaderBoardNotifier(),
      child: Builder(builder: (context) => const LeaderBoardScreenProvider()),
    );

class LeaderBoardScreenProvider extends StatefulWidget {
  const LeaderBoardScreenProvider({super.key});

  @override
  State<LeaderBoardScreenProvider> createState() => _LeaderBoardScreenProviderState();
}

class _LeaderBoardScreenProviderState extends State<LeaderBoardScreenProvider> {
  @override
  void initState() {
    // TODO: implement initState
    var state = Provider.of<LeaderBoardNotifier>(context, listen: false);
    state.iniState(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              left: 25,
              right: 25,
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
                              child: SvgPicture.asset(AppImages.leftBackIcon)),
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
                                  onTap: () {state.selectTabIndex(1, context, loginResponseModel.id, "weekly");},
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: state.selectIndex == 1 ? Colors.white : Colors.transparent,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                        child: Text("Weekly", style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w700),),
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
                      state.lenderBoardList.isNotEmpty
                          ? Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    topListView(image: state.lenderBoardList.length > 1 ? state.lenderBoardList[1].profile?.thumbnail ?? "" : "", name: state.lenderBoardList.length > 1 ? state.lenderBoardList[1].displayName ?? "" : "", coin: state.lenderBoardList.length > 1 ? state.lenderBoardList[1].earnappUserEarnCoin ?? "" : "", imageSize: 67, tajImage: AppImages.silverTajIcon),
                                    topListView(image: state.lenderBoardList.isNotEmpty ? state.lenderBoardList[0].profile?.thumbnail ?? "" : "", name: state.lenderBoardList.isNotEmpty ? state.lenderBoardList[0].displayName ?? "" : "", coin: state.lenderBoardList.isNotEmpty ? state.lenderBoardList[0].earnappUserEarnCoin ?? "" : "", tajImage: AppImages.goldTajIcon),
                                    topListView(image: state.lenderBoardList.length > 2 ? state.lenderBoardList[2].profile?.thumbnail ?? "" : "", name: state.lenderBoardList.length > 2 ? state.lenderBoardList[2].displayName ?? "" : "", coin: state.lenderBoardList.length > 2 ? state.lenderBoardList[2].earnappUserEarnCoin ?? "" : "", imageSize: 67, tajImage: AppImages.bronzeTajIcon),
                                  ],
                                ),
                              ),
                            )
                          : Offstage(),
                      paddingTop(10),
                      state.lenderBoardList.length > 3
                          ? Expanded(
                              child: LazyLoadScrollView(
                                onEndOfPage: () { state.onScroll(context);},
                                isLoading: state.isLoadMore,
                                child: ListView.builder(
                                    itemCount: state.lenderBoardList.length - 4,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(bottom: 80),
                                    itemBuilder: (context, index) {
                                      var model = state.lenderBoardList[index + 4];
                                      return Card(
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
                                                      style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w600), overflow: TextOverflow.ellipsis,
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
                                      );
                                    }),
                              ),
                            )
                          : Offstage()
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
