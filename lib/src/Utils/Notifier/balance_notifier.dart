import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Model/UiModel/country_code_model.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:earn_streak/src/Utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../Constants/api_url.dart';
import '../../Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import '../../Networking/ApiService/api_service.dart';

class BalanceNotifier extends ChangeNotifier {

  String phoneNumber = "";
  String dialCode = "1";

  onPhoneChange(Country phone){
    dialCode = phone.dialCode;
    notifyListeners();
  }

  Future paymentUpdateApiCall(context, String type, {String? email, String? accountName, String? bankName,String? accountNo,String? bankIfsc,String? coins,String? mobileName,String? mobileNo, String? mobileNetwork}) async {

    Map<String, dynamic> body = {
      "user_id": loginResponseModel.id,
      "payment_type": type,
      "paypal_email": email ?? "",
      "account_name": accountName ?? "",
      "bank_name": bankName ?? "",
      "account_no": accountNo ?? "",
      "bank_ifsc": bankIfsc ?? "",
      "coins": coins ?? "",
      "mobile_name": mobileName ?? "",
      "mobile_no": "$dialCode ${mobileNo ?? ""}",
      "mobile_network": mobileNetwork ?? "",

    };

    String authToken = await sharedPref.read("authToken");
    try {
      var res = await ApiService.request(context, AppUrls.paymentUpdate, RequestMethods.POST, requestBody: body, header: commonHeaderWithToken(authToken),);
      if (res != null && res["success"] == true) {
        Navigator.pop(context);
        payPalDetailsClear();
        bankDetailsClear();
        mobileDetailsClear();
        showError(message: "$type details update successfully", background: Colors.blue);
      }
    } catch (e) {
      debugPrint("Register api throw exception $e");
    }
    // return lenderBoardList;
  }

  mobileDetailsClear(){
    momoNameController.text = "";
    momoNoController.text = "";
    momoNetworkController.text = "";
  }

  payPalDetailsClear(){
    payPalEmailController.text = "";
  }

  bankDetailsClear(){
    accountNameController.text = "";
    bankNameController.text = "";
    accountNumberController.text = "";
    ifscCodeController.text = "";
    coinsController.text = "";
  }

  payPalDetailsUpdateApiCall(context){
    if(payPalEmailController.text.isNotEmpty){
      paymentUpdateApiCall(context, "type", email: payPalEmailController.text);
    }else{
      showError(message: "Please enter email");
    }
  }

  bankDetailsUpdateApiCall(context){
    if(accountNameController.text.isEmpty){
      showError(message: "Please enter account name");
    } else if(bankNameController.text.isEmpty){
      showError(message: "Please enter bank name");
    } else if(accountNumberController.text.isEmpty){
      showError(message: "Please enter account number");
    } else if(ifscCodeController.text.isEmpty){
      showError(message: "Please enter ifsc name");
    } else if(coinsController.text.isEmpty){
      showError(message: "Please enter coin");
    } else{
      paymentUpdateApiCall(context, "bank", accountName: accountNameController.text, bankName: bankNameController.text, accountNo: accountNumberController.text, bankIfsc: ifscCodeController.text, coins: coinsController.text);
    }
  }

  mobileDetailsUpdateApiCall(context){
    if(momoNameController.text.isEmpty){
      showError(message: "Please enter name");
    } else if(momoNoController.text.isEmpty){
      showError(message: "Please enter number");
    } else if(momoNetworkController.text.isEmpty){
      showError(message: "Please enter network");
    } else{
      paymentUpdateApiCall(context, "mobile", mobileName: momoNameController.text, mobileNo: momoNoController.text, mobileNetwork: momoNetworkController.text);
    }
  }

}
