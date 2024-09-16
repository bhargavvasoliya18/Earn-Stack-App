import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/take_quiz_notifier.dart';
import 'package:earn_streak/src/Widget/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

TakeQuizScreen()=> ChangeNotifierProvider<TakeQuizNotifier>(create: (_)=> TakeQuizNotifier(), child: Builder(builder: (context) => const TakeQuizScreenProvider()),);

class TakeQuizScreenProvider extends StatelessWidget {
  const TakeQuizScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TakeQuizNotifier>(
      builder: (context, state, child)=>
      Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                commonAppBar(height: 250)
              ],
            ),
            Positioned(
              top: 50, left: 30,right: 30, bottom: 0,
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: (){Navigator.pop(context);},
                        child: SvgPicture.asset(AppImages.leftBackIcon)),
                    paddingLeft(15),
                    Text(TakeQuizString.takeQuiz, style: TextStyleTheme.customTextStyle(AppColors.white, 24, FontWeight.w700),)
                  ],
                ),
                paddingTop(25),
                Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      height: 5, width: MediaQuery.of(context).size.width / 1.2,
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
                paddingTop(10),
                Align(
                    alignment: Alignment.center,
                    child: Text("Question 02 to 10", style: TextStyleTheme.customTextStyle(AppColors.white, 14, FontWeight.w600),)),
                // Expanded(
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 10,
                //     itemBuilder: (context, index) =>
                //      Column(
                //       children: [
                //         Card(
                //           color: Colors.white,
                //           child: Padding(
                //             padding: const EdgeInsets.all(20),
                //             child: Row(
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 Text("2)", style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),),
                //                 paddingLeft(5),
                //                 Expanded(child: Text("Which calendar is the most widespread calendar used today?", style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),))
                //               ],
                //             ),
                //           ),
                //         ),
                //         Expanded(
                //           child: ListView.builder(
                //               itemCount: 4,
                //               itemBuilder: (context, answerIndex){
                //             return Card(
                //               color: Colors.white,
                //               child:  Padding(
                //                 padding: const EdgeInsets.all(18),
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       decoration: BoxDecoration(color: AppColors.midLightGrey, borderRadius: BorderRadius.circular(10)),
                //                       child: Padding(
                //                         padding: const EdgeInsets.all(10),
                //                         child: Text("A", style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600)),
                //                       ),
                //                     ),
                //                     paddingLeft(25),
                //                     Expanded(child: Text("Lorem calendar", style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600), overflow: TextOverflow.ellipsis,))
                //                   ],
                //                 ),
                //               ),
                //             );
                //           }),
                //         ),
                //       ],
                //     ),
                //   ),
                // )

                SizedBox(
                  height: 550,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "2)",
                                  style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),
                                ),
                                paddingLeft(5),
                                Expanded(
                                  child: Text(
                                    "Which calendar is the most widespread calendar used today?",
                                    style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox( // Use a fixed height here
                          height: 150, // Set a specific height for the inner ListView.builder
                          child: ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, answerIndex) {
                              return Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(color: AppColors.midLightGrey, borderRadius: BorderRadius.circular(10),),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text("A", style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600),),
                                        ),
                                      ),
                                      paddingLeft(25),
                                      Expanded(
                                        child: Text("Lorem calendar", style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.w600), overflow: TextOverflow.ellipsis,),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
