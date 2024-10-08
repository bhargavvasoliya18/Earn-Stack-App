import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Screens/Auth/profile_screen.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/board_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Utils/Notifier/login_notifier.dart';
import '../../../Widget/common_network_image.dart';

BoardScreen()=> ChangeNotifierProvider<BoardNotifier>(create: (_) => BoardNotifier(), child: Builder(builder: (context) => const BoardScreenProvider()),);

class BoardScreenProvider extends StatelessWidget {
  const BoardScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight - 50,
      child: Scaffold(
        body:  Consumer<BoardNotifier>(
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
                    left: 25.w, right: 25.w, top: 40.h,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: ScreenUtil().screenHeight,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(BoardString.board, style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),),
                                GestureDetector(
                                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=> ProfileScreen()));},
                                    child: fadeImageView(loginResponseModel.profile?.thumbnail ?? "", placeHolderSize: 40)),
                              ],
                            ),
                            paddingTop(30),
                            Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: ListView.builder(
                                   itemCount: state.boardList.length,
                                   shrinkWrap: true,
                                   padding: EdgeInsets.zero,
                                   itemBuilder: (context, index){
                                     var model = state.boardList[index];
                                     int lastIndex = state.boardList.length - 1;
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: (){state.onTap(context, index);},
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(model.image ?? "", height: 35, width: 35,),
                                                paddingLeft(20),
                                                Text(model.title ?? "", style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),),
                                              ],
                                            ),
                                            SvgPicture.asset(AppImages.rightBackIcon, height: 35, width: 35)
                                          ],
                                        ),
                                      ),
                                     lastIndex != index ? Divider(color: AppColors.black.withOpacity(0.5),) : Container()
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        )
      ),
    );
  }
}
