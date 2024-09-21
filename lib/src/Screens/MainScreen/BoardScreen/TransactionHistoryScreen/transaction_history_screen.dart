import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/transaction_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

TransactionHistoryScreen()=> ChangeNotifierProvider<TransactionNotifier>(create: (_)=> TransactionNotifier(), child: Builder(builder: (context) => const TransactionHistoryScreenProvider()),);

class TransactionHistoryScreenProvider extends StatelessWidget {
  const TransactionHistoryScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TransactionNotifier>(
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
                  left: 25, right: 25, top: 70,
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
                              Text("Transaction history", style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),),
                            ],
                          ),
                          paddingTop(30),
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                    itemCount: 10,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(index.toString(), style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w400),),
                                                paddingLeft(10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Sign up bonus", style: TextStyleTheme.customTextStyle(AppColors.black, 14 , FontWeight.w600),),
                                                    Text("07/09/2024", style: TextStyleTheme.customTextStyle(AppColors.lightGrey, 14, FontWeight.w600),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text("+1200", style: TextStyleTheme.customTextStyle(AppColors.green, 16, FontWeight.w600),),
                                          ],
                                        ),
                                      ),
                                      paddingTop(5),
                                      index == 10 ? Container() : Divider(),
                                      paddingTop(index == 10 ? 0 : 5),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
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
