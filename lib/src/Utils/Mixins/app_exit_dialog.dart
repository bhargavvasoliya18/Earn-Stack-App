import 'dart:io';
import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:flutter/material.dart';

Future<bool> showExitPopup(context) async{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 18),
          content: Wrap(
            children: [
              Text("Do you want to exit?", style: TextStyleTheme.customTextStyle(AppColors.black, 14, FontWeight.normal),),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        exit(0);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.white),
                      child: Text("yes",style: TextStyleTheme.customTextStyle(AppColors.black, 12, FontWeight.w400)),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                        ),
                        child: Text("no", style: TextStyleTheme.customTextStyle(AppColors.black, 12, FontWeight.w400)),
                      ))
                ],
              )
            ],
          ),
        );
      });
}