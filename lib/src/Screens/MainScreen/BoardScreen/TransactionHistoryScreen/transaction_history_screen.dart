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

TransactionHistoryScreen()=> ChangeNotifierProvider<TransactionNotifier>(create: (_)=> TransactionNotifier(), child: Builder(builder: (context) => TransactionHistoryScreenProvider(context: context)),);

class TransactionHistoryScreenProvider extends StatelessWidget {

  BuildContext context;
    TransactionHistoryScreenProvider({super.key, required this.context}){
    WidgetsBinding.instance.addPostFrameCallback((_){
      var state = Provider.of<TransactionNotifier>(context, listen: false);
      state.getTransactionApiCall(context);
    });
  }

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
                              Text("Transaction history", style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),),
                            ],
                          ),
                          paddingTop(30),
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: SingleChildScrollView(
                                child:  SizedBox(
                                  height: ScreenUtil().screenHeight / 1.3,
                                  child: state.transactionHistoryList.isNotEmpty ? ListView.builder(
                                      itemCount: state.transactionHistoryList.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemBuilder: (context, index){
                                        var lastIndex = state.transactionHistoryList.length - 1;
                                        var model = state.transactionHistoryList[index];
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
                                                      Text((index + 1).toString(), style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w400),),
                                                      paddingLeft(10),
                                                      Text(model.history ?? "", style: TextStyleTheme.customTextStyle(AppColors.black, 14 , FontWeight.w600),),
                                                    ],
                                                  ),
                                                  Text(state.convertDateFormat(model.createdAt ?? ""))
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(AppImages.courncyIcon,height: 15,),
                                                  paddingLeft(02),
                                                  Text(model.coin ?? "", style: TextStyleTheme.customTextStyle(AppColors.green, 16, FontWeight.w600),),
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
                                  }) : Center(child: Text("No history...!!")),
                                ),
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
