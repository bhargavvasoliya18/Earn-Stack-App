import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/transaction_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

// TransactionHistoryScreen() => ChangeNotifierProvider<TransactionNotifier>(
//       create: (_) => TransactionNotifier(),
//       child: Builder(builder: (context) => TransactionHistoryScreenProvider(context: context)),
//     );

class TransactionHistoryScreen extends StatefulWidget {
  TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: 50), () {
      var state = Provider.of<TransactionNotifier>(context, listen: false);
      state.isLoadMore = false;
      state.isHaseMoreData = true;
      state.page = 1;
      if (state.isTransactionHistoryApiCall == false) {
        state.isTransactionHistoryApiCall = true;
        state.getTransactionApiCall(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TransactionNotifier>(
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
              child: SizedBox(
                height: ScreenUtil().screenHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: SvgPicture.asset(AppImages.leftBackIcon),
                          ),
                        ),
                        paddingLeft(10),
                        Text(
                          "Transaction history",
                          style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),
                        ),
                      ],
                    ),
                    paddingTop(20),
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                          child: state.transactionHistoryList.isNotEmpty ?? false
                              ? RefreshIndicator(
                                  onRefresh: () async {
                                    state.onRefresh(context);
                                    return;
                                  },
                                  child: NotificationListener<ScrollNotification>(
                                    onNotification: (ScrollNotification scrollInfo) {
                                      if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !state.isLoadMore) {
                                        // Trigger the load more action
                                        state.onScroll(context);
                                      }
                                      return false;
                                    },
                                    child: ListView.builder(
                                        itemCount: state.transactionHistoryList.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          var lastIndex = (state.transactionHistoryList!.length ?? 0) - 1;
                                          // debugPrint('Last index $lastIndex');
                                          var model = state.transactionHistoryList![index];
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              (index + 1).toString(),
                                                              style: TextStyleTheme.customTextStyle(
                                                                  AppColors.black, 16, FontWeight.w400),
                                                            ),
                                                            paddingLeft(10),
                                                            Text(
                                                              model.history ?? "",
                                                              style: TextStyleTheme.customTextStyle(
                                                                  AppColors.black, 14, FontWeight.w600),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(state.convertDateFormat(model.createdAt ?? ""))
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Image.asset(
                                                          AppImages.courncyIcon,
                                                          height: 15,
                                                        ),
                                                        paddingLeft(02),
                                                        Text(
                                                          model.coin ?? "",
                                                          style: TextStyleTheme.customTextStyle(
                                                              AppColors.green, 16, FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              paddingTop(5),
                                              index == lastIndex ? Container() : Divider(),
                                              paddingTop(index == lastIndex ? 0 : 5),
                                            ],
                                          );
                                        }),
                                  ),
                                )
                              : Center(child: Text("No history...!!")),
                        ),
                      ),
                    ),
                    paddingTop(50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
