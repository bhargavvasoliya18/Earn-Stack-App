import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Screens/MainScreen/HomeScreen/Take_Quize_Screen/Module/conrats_dialog.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/take_quiz_notifier.dart';
import 'package:earn_streak/src/Widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

TakeQuizScreen() => ChangeNotifierProvider<TakeQuizNotifier>(
      create: (_) => TakeQuizNotifier(),
      child: Builder(builder: (context) => TakeQuizScreenProvider(context: context)),
    );

class TakeQuizScreenProvider extends StatelessWidget {
  BuildContext context;
  TakeQuizScreenProvider({super.key, required this.context}){
    WidgetsBinding.instance.addPostFrameCallback((_){
      var state = Provider.of<TakeQuizNotifier>(context, listen: false);
      state.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TakeQuizNotifier>(
      builder: (context, state, child) => Scaffold(
        backgroundColor: AppColors.colorF8F7FF,
        body: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundImg),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.only(left: 20, top: 60, right: 20, bottom: 50),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {Navigator.pop(context);},
                      child: SvgPicture.asset(AppImages.leftBackIcon)),
                  paddingLeft(15),
                  Text(
                    TakeQuizString.takeQuiz,
                    style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),
                  )
                ],
              ),
              paddingTop(25),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: SizedBox(
                    height: 5,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: LinearProgressIndicator(
                      minHeight: 25,
                      value: state.progress,
                      backgroundColor: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                ),
              ),
              paddingTop(8),
              Text("Question ${state.selectIndex} to ${state.quizList.length}", style: TextStyleTheme.customTextStyle(AppColors.white, 14, FontWeight.w600),),
              paddingTop(20),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${(state.selectIndex + 1)})", style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),),
                      paddingLeft(5),
                      Expanded(
                        child: Text(
                          state.quizList[state.selectIndex].question ?? "",
                          style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              paddingTop(15),
              ListView.builder(
                itemCount: state.quizList[state.selectIndex].answer?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(),
                itemBuilder: (context, answerIndex) {
                  return Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.midLightGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "A",
                                style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),
                              ),
                            ),
                          ),
                          paddingLeft(25),
                          Expanded(
                            child: Text(
                              state.quizList[state.selectIndex].answer?[answerIndex] ?? "",
                              style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                commonBorderButtonColor(width: 150, "Back", onTap: () {
                  if (state.selectIndex != 0) {
                    state.backQuestion();
                  }
                }),
                commonButtonColorLinerGradiunt(width: 150, "Next", onTap: () {
                  if(state.selectIndex < (state.quizList.length - 1)) {
                    state.nextQuestion();
                  }
                  print("check last index ${state.quizList.length} ==> ${state.lastIndex}  ${state.selectIndex}:::: ${state.quizList.length == state.lastIndex}");
                  if(state.quizList.length == (state.selectIndex + 1)){
                    congratsDialog(context);
                  }
                }),
              ],
            ),
            paddingBottom(25)
          ],
        )
      ),
    );
  }
}
