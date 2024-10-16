import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/balance_notifier.dart';
import 'package:earn_streak/src/Utils/Validations/validation.dart';
import 'package:earn_streak/src/Widget/common_button.dart';
import 'package:flutter/material.dart';

import '../../../../../Controller/TextField/custom_textfield.dart';

payPalDialog(context, BalanceNotifier state){
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context){
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Paypal", style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w500),)),
              paddingTop(15),
              customTextField(payPalEmailController, "EMAIL ID", "enter paypal email", validation: (value) => validateEmail(value), textInputAction: TextInputAction.done),
              // paddingTop(15),
              // customTextField(coinsController, "Coins", "enter coins", validation: (value) => validateEmpty(value), textInputAction: TextInputAction.done),
              paddingTop(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: commonButtonColor("Cancel", width: 150, onTap: (){Navigator.pop(context); state.payPalDetailsClear();})),
                  paddingLeft(10),
                  Expanded(child: commonButtonColorLinerGradiunt("Submit", width: 150, onTap: (){ state.payPalDetailsUpdateApiCall(context);})),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}