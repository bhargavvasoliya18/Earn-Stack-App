import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Screens/MainScreen/BoardScreen/BalanceScreen/Module/bank_transfer_details.dart';
import 'package:earn_streak/src/Screens/MainScreen/BoardScreen/BalanceScreen/Module/mobile_money_dialog.dart';
import 'package:earn_streak/src/Screens/MainScreen/BoardScreen/BalanceScreen/Module/paypalDialog.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/balance_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

BalanceScreen()=> ChangeNotifierProvider<BalanceNotifier>(create: (_)=> BalanceNotifier(), child: Builder(builder: (context)=> const BalanceScreenProvider()),);

class BalanceScreenProvider extends StatelessWidget {
  const BalanceScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BalanceNotifier>(
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
                  left: 25, right: 25, top: 40.h,
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
                              Text(BoardString.balance, style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),),
                            ],
                          ),
                          paddingTop(30),
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Text(BalanceString.availableBalance,style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w600),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(AppImages.courncyIcon,height: 26,),
                                      Text("1300", style: TextStyleTheme.customTextStyle(AppColors.green, 30, FontWeight.w700),),
                                    ],
                                  ),
                                  paddingTop(10),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xff9797FF)),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
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
                                                  Image.asset(AppImages.courncyIcon,height: 22,),
                                                   Text("1000",style: TextStyleTheme.customTextStyle(AppColors.green, 24, FontWeight.w600),),
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
                                                  Image.asset(AppImages.courncyIcon,height: 22,),
                                                  Text("300",style: TextStyleTheme.customTextStyle(AppColors.green, 24, FontWeight.w600),),
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
                                    onTap: (){
                                      payPalDialog(context);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppImages.paypalIcon),
                                        paddingLeft(20),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(BalanceString.payPal, style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),),
                                            Text(BalanceString.minimumPayment, style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  paddingTop(5),
                                  Divider(),
                                  paddingTop(5),
                                  InkWell(
                                    onTap: (){backDetailsDialog(context);},
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppImages.bankTransferIcon),
                                        paddingLeft(20),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(BalanceString.bankTransfer, style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),),
                                            Text(BalanceString.minimumPayment, style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  paddingTop(5),
                                  Divider(),
                                  paddingTop(5),
                                  InkWell(
                                    onTap: (){mobileMoneyDialog(context);},
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppImages.mobilePayIcon),
                                        paddingLeft(20),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(BalanceString.mobileMoney, style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),),
                                            Text(BalanceString.minimumPayment, style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600),),
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
    );
  }
}
