import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Model/CommonModel/common_model.dart';
import 'package:earn_streak/src/Model/LoginModel/login_response_model.dart';
import 'package:earn_streak/src/Model/user_details_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Screens/Auth/login_screen.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/balance_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/custom_bottom_tab_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/home_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/leader_board_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/profile_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/setting_notifier.dart';
import 'package:earn_streak/src/Utils/Notifier/transaction_notifier.dart';
import 'package:earn_streak/src/Utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

showLogoutDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding:  const EdgeInsets.symmetric(horizontal: 30),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Wrap(
              children: [
                Column(
                  children: [
                    Text("Are you sure logout?",style: TextStyleTheme.customTextStyle(AppColors.black, 17, FontWeight.w500),),
                    paddingTop(15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: (){ Navigator.pop(context); },
                            child: Container( height: 50, decoration: BoxDecoration( borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.grey)),
                              child: Center(child: Text("Cancel",style: TextStyleTheme.customTextStyle(AppColors.black, 12, FontWeight.w400),)),
                            ),
                          ),
                        ),
                        paddingLeft(10),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: (){
                              clearAllAndGoToLoginScreen(context);
                              Navigator.pop(context);
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (Route<dynamic> route)=> false);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(8),),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.logOutIcon,height: 15,width: 15, color: Colors.white,),
                                  paddingLeft(5),
                                  Flexible(child: Text("Sign out",style: TextStyleTheme.customTextStyle(AppColors.white, 12, FontWeight.w400),)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}


clearAllAndGoToLoginScreen(context) {
  selectedBottomTab = 0;
  prevBottomTab = 0;
  Provider.of<HomeNotifier>(context, listen: false).articleList.clear();
  Provider.of<TransactionNotifier>(context, listen: false).transactionHistoryList.clear();
  Provider.of<LeaderBoardNotifier>(context, listen: false).lenderBoardList.clear();
  Provider.of<LeaderBoardNotifier>(context, listen: false).weeklyLenderBoardList.clear();
  Provider.of<LeaderBoardNotifier>(context, listen: false).monthlyLenderBoardList.clear();
  Provider.of<SettingNotifier>(context, listen: false).commonModel = CommonModel();
  Provider.of<ProfileNotifier>(context, listen: false).userDetailsModel = UserDetailsModel();
  Provider.of<BalanceNotifier>(context, listen: false).userDetailsModel = UserDetailsModel();
  Provider.of<HomeNotifier>(context, listen: false).removeListener(() { });
  Provider.of<LeaderBoardNotifier>(context, listen: false).removeListener(() { });
  sharedPref.save("profileDetails", UserDetailsModel().toJson());
  sharedPref.save("balanceProfileDetails", UserDetailsModel().toJson());
   loginResponseModel = LoginResponseModel();
  sharedPref.removeAll();
  sharedPref.save("userData", LoginResponseModel());
  loadUserDataSharedPrefs();
  debugPrint("Hii ${loginResponseModel.toJson()}");

}


showDeleteAccountDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding:  const EdgeInsets.symmetric(horizontal: 30),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Wrap(
              children: [
                Column(
                  children: [
                    Text("Are you sure delete account?",style: TextStyleTheme.customTextStyle(AppColors.black, 17, FontWeight.w500),),
                    paddingTop(15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: (){ Navigator.pop(context); },
                            child: Container( height: 50, decoration: BoxDecoration( borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.grey)),
                              child: Center(child: Text("Cancel",style: TextStyleTheme.customTextStyle(AppColors.black, 12, FontWeight.w400),)),
                            ),
                          ),
                        ),
                        paddingLeft(10),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(8),),
                              child: Center(child: Text("Delete",style: TextStyleTheme.customTextStyle(AppColors.white, 12, FontWeight.w400),)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

showDeactivateAccountDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding:  const EdgeInsets.symmetric(horizontal: 30),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Wrap(
              children: [
                Column(
                  children: [
                    Text("Are you sure deactivate account?",style: TextStyleTheme.customTextStyle(AppColors.black, 18, FontWeight.w500),),
                    paddingTop(30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: (){ Navigator.pop(context); },
                            child: Container( height: 50, decoration: BoxDecoration( borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.grey)),
                              child: Center(child: Text("Cancel",style: TextStyleTheme.customTextStyle(AppColors.black, 12, FontWeight.w400),)),
                            ),
                          ),
                        ),
                        paddingLeft(10),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(color: AppColors.red, borderRadius: BorderRadius.circular(8),),
                              child: Center(child: Text("Deactivate",style: TextStyleTheme.customTextStyle(AppColors.white, 12, FontWeight.w400),)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}