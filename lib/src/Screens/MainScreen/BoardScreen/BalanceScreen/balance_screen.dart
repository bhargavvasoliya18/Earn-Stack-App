import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Screens/MainScreen/BoardScreen/BalanceScreen/Module/bank_transfer_details.dart';
import 'package:earn_streak/src/Screens/MainScreen/BoardScreen/BalanceScreen/Module/mobile_money_dialog.dart';
import 'package:earn_streak/src/Screens/MainScreen/BoardScreen/BalanceScreen/Module/paypal_dialog.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Mixins/alert_dialog.dart';
import 'package:earn_streak/src/Utils/Notifier/balance_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/home_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/setting_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

BalanceScreen() => ChangeNotifierProvider<SettingNotifier>(
    create: (_) => SettingNotifier(),
    child: ChangeNotifierProvider<BalanceNotifier>(
      create: (_) => BalanceNotifier(),
      child: Builder(builder: (context) => const BalanceScreenProvider()),
    ));

class BalanceScreenProvider extends StatefulWidget {
  const BalanceScreenProvider({super.key});

  @override
  State<BalanceScreenProvider> createState() => _BalanceScreenProviderState();
}

class _BalanceScreenProviderState extends State<BalanceScreenProvider> {
  String? minCoin;

  @override
  void initState() {
    getMinCoin();
    super.initState();
  }

  getMinCoin() async {
    minCoin = await sharedPref.read("minimumCoin");
    setState(() {});
    print("min coin $minCoin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SettingNotifier>(
        builder: (context, settingState, child) => Consumer<BalanceNotifier>(
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
                                child:  Padding(
                                  padding: EdgeInsets.all(10.sp),
                                  child: SvgPicture.asset(AppImages.leftBackIcon),
                                )),
                            paddingLeft(10),
                            Text(
                              BoardString.balance,
                              style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),
                            ),
                          ],
                        ),
                        paddingTop(20),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Text(
                                  BalanceString.availableBalance,
                                  style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w600),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppImages.courncyIcon,
                                      height: 26,
                                    ),
                                    Text(
                                      userCoins!.total.toString(),
                                      style: TextStyleTheme.customTextStyle(AppColors.green, 30, FontWeight.w700),
                                    ),
                                  ],
                                ),
                                paddingTop(10),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xff9797FF)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(BalanceString.totalEarning),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  AppImages.courncyIcon,
                                                  height: 22,
                                                ),
                                                Text(
                                                  userCoins!.total.toString(),
                                                  style: TextStyleTheme.customTextStyle(AppColors.green, 24, FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(BalanceString.totalRedeem),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  AppImages.courncyIcon,
                                                  height: 22,
                                                ),
                                                Text(
                                                  userCoins!.reedmCoin.toString(),
                                                  style: TextStyleTheme.customTextStyle(AppColors.green, 24, FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        paddingTop(20),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: int.parse(minCoin ?? "0") <= (userCoins?.total ?? 0)
                                      ? () {
                                          payPalDialog(context, state);
                                        }
                                      : () {
                                          showAlertDialog(context, "Sorry", "You are not eligible for this request", "ok");
                                        },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppImages.paypalIcon),
                                      paddingLeft(20),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            BalanceString.payPal,
                                            style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),
                                          ),
                                          Text(
                                            "${BalanceString.minimumPayment} $minCoin coins",
                                            style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                paddingTop(5),
                                Divider(),
                                paddingTop(5),
                                InkWell(
                                  onTap: int.parse(minCoin ?? "0") <= (userCoins?.total ?? 0)
                                      ? () {
                                          backDetailsDialog(context, state);
                                        }
                                      : () {
                                          showAlertDialog(context, "Sorry", "You are not eligible for this request", "ok");
                                        },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppImages.bankTransferIcon),
                                      paddingLeft(20),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            BalanceString.bankTransfer,
                                            style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),
                                          ),
                                          Text(
                                            "${BalanceString.minimumPayment} $minCoin coins",
                                            style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                paddingTop(5),
                                Divider(),
                                paddingTop(5),
                                InkWell(
                                  onTap: int.parse(minCoin ?? "0") <= (userCoins?.total ?? 0)
                                      ? () {
                                          mobileMoneyDialog(context, state);
                                        }
                                      : () {
                                          showAlertDialog(context, "Sorry", "You are not eligible for this request", "ok");
                                        },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppImages.mobilePayIcon),
                                      paddingLeft(20),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            BalanceString.mobileMoney,
                                            style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),
                                          ),
                                          Text(
                                            "${BalanceString.minimumPayment} $minCoin coins",
                                            style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
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
    );
  }
}
