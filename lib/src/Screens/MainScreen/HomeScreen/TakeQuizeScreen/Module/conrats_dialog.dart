import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

congratsDialog(context, String rightAnswer, String wrongAnswer,String total) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.congratsImage), fit: BoxFit.fill,),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              paddingTop(40),
              Image.asset(AppImages.currencyIcon, height: 40, width: 40,),
              Text("Congrats!", style: TextStyleTheme.customTextStyle(AppColors.black, 24, FontWeight.w500),),
              Text("$rightAnswer coin received", style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w500),),
              paddingTop(10),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color(0xffD1D1D1))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.green),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(AppImages.rightIcon),
                                  )),
                              Text(
                                rightAnswer,
                                style: TextStyleTheme.customTextStyle(AppColors.green, 32, FontWeight.bold),
                              ),
                            ],
                          ),
                          paddingLeft(10),
                          Container(height: 20, width: 2, color: Color(0xffD1D1D1)),
                          paddingLeft(10),
                          Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.red),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(AppImages.crossIcon),
                                  )),
                              Text(
                                wrongAnswer,
                                style: TextStyleTheme.customTextStyle(AppColors.red, 32, FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        "Out of $total",
                        style: TextStyleTheme.customTextStyle(Color(0xff999999), 14, FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              paddingTop(10),
              Text(
                "Quiz completed successfully",
                style: TextStyleTheme.customTextStyle(AppColors.black, 16, FontWeight.w500),
              ),
              paddingTop(10),
              commonButtonColorLinerGradiunt(
                "Home",
                width: 150,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              ),
              paddingTop(20),
            ],
          ),
        ),
      );
    },
  );
}
