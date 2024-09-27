import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Screens/MainScreen/HomeScreen/TakeQuizeScreen/Module/conrats_dialog.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/take_quiz_notifier.dart';
import 'package:earn_streak/src/Widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

TakeQuizScreen({ArticleModel? articleModel}) => ChangeNotifierProvider<TakeQuizNotifier>(
      create: (_) => TakeQuizNotifier(),
      child: Builder(builder: (context) => TakeQuizScreenProvider(context: context, articleModel: articleModel)),
    );

class TakeQuizScreenProvider extends StatelessWidget {
  BuildContext context;
  ArticleModel? articleModel;
  TakeQuizScreenProvider({super.key, required this.context, this.articleModel}){
    WidgetsBinding.instance.addPostFrameCallback((_){
      var state = Provider.of<TakeQuizNotifier>(context, listen: false);
      state.initState(articleModel!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TakeQuizNotifier>(
      builder: (context, state, child) => Scaffold(
        backgroundColor: AppColors.colorF8F7FF,
        body: SingleChildScrollView(
          child: Container(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.backgroundImg), fit: BoxFit.fill,),
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
                Text("Question ${state.selectIndex} to ${articleModel?.quizs?.length}", style: TextStyleTheme.customTextStyle(AppColors.white, 14, FontWeight.w600),),
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
                            articleModel?.quizs![state.selectIndex].question ?? "",
                            style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                paddingTop(15),
                ListView.builder(
                  itemCount: articleModel?.quizs![state.selectIndex].option?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(),
                  itemBuilder: (context, answerIndex) {
                    var model = articleModel?.quizs![state.selectIndex].option?[answerIndex];
                    return GestureDetector(
                      onTap: (){state.selectQuiz(answerIndex);},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Container(
                          decoration: BoxDecoration(
                          color: state.selectQuizIndex == answerIndex ? Color(0xff66CC70).withOpacity(0.1) : Colors.white,
                            border: Border.all(color: state.selectQuizIndex == answerIndex ? Color(0xff66CC70) : Colors.transparent),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: state.selectQuizIndex == answerIndex ? Colors.white : AppColors.midLightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text((answerIndex + 1).toString(), style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),),
                                  ),
                                ),
                                paddingLeft(25),
                                Expanded(
                                  child: Text(
                                    model?.s1 ?? "",
                                    style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
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
                  print("object ${state.selectIndex}");
                  if(state.selectIndex == state.userSelectAnswer.length - 1){
                    if(state.selectIndex < (articleModel!.quizs!.length - 1)) {
                      state.nextQuestion();
                    }
                    if(articleModel!.quizs!.length == (state.selectIndex + 1)){
                      congratsDialog(context);
                    }
                  }else{
                    print("please select answer");
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
