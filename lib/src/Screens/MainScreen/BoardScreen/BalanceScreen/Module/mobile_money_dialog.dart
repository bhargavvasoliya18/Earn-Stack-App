import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Controller/TextField/custom_textfield.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Utils/Notifier/balance_notifier.dart';
import 'package:earn_streak/src/Utils/Validations/validation.dart';
import 'package:earn_streak/src/Widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mobileMoneyDialog(context, BalanceNotifier state){
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
                  child: Text("Mobile money", style: TextStyleTheme.customTextStyle(AppColors.black, 20, FontWeight.w500),)),
              paddingTop(15),
              customTextField(momoNameController, "Name", "Enter name", validation: (value) => validateEmail(value), textInputAction: TextInputAction.done),
              paddingTop(15),
              customPhoneTextFiled(
                  state.phoneNumber, (value) => null, "+1", TextAlign.start, momoNoController, TextInputType.number, "phone", FocusNode(), TextInputAction.done, context, onCountryChanged: (country) {state.onPhoneChange(country);},
                  hintStyle: TextStyleTheme.customTextStyle(Colors.grey, 15, FontWeight.w400),
                  showBorder: false, inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              // customTextField(momoNoController, "Number.", "Enter mobile number", validation: (value) => validateEmail(value), textInputAction: TextInputAction.done),
              paddingTop(15),
              customTextField(momoNetworkController, "Network", "Enter account nuber", validation: (value) => validateEmail(value), textInputAction: TextInputAction.done),
              // paddingTop(15),
              // customTextField(coinsController, "Coins", "Enter coins", validation: (value) => validateEmail(value), textInputAction: TextInputAction.done),
              paddingTop(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: commonButtonColor("Cancel", width: 150, onTap: (){Navigator.pop(context); state.mobileDetailsClear();}, )),
                  paddingLeft(10),
                  Expanded(child: commonButtonColorLinerGradiunt("Submit", width: 150, onTap: (){state.mobileDetailsUpdateApiCall(context);})),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}