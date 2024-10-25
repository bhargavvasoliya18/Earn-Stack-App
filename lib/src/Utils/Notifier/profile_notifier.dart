import 'dart:io';

import 'package:earn_streak/src/Constants/api_url.dart';
import 'package:earn_streak/src/Model/user_details_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Repository/Services/Navigation/navigation_service.dart';
import 'package:earn_streak/src/Utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Networking/ApiService/api_service.dart';
import 'login_notifier.dart';

class ProfileNotifier extends ChangeNotifier {

  XFile? pickedFile;
  UserDetailsModel userDetailsModel = UserDetailsModel();

  Future<bool> getCameraPermissionStatus() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      return false;
    } else if (status.isDenied) {
      return false;
    } else {
      return false;
    }
  }

  selectImageFromCamera(context) async {
    if (await getCameraPermissionStatus()) {
      pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      await updateProfile(rootNavigatorKey.currentContext);
    }
    notifyListeners();
  }

  selectImageFromGallery(context) async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    await updateProfile(rootNavigatorKey.currentContext);
    notifyListeners();
  }

  Future updateProfile(context) async {
    String token = await sharedPref.read('authToken');
    try {
      var res = await ApiService.request(
        context,
        "${AppUrls.profileUpdate}?user_id=${loginResponseModel.id}",
        RequestMethods.POSTFILE,
        postFiles: [pickedFile!],
        header: commonHeaderWithMultiPartFormData(token),
        showLogs: true,
        showLoader: true,
      );
      if (res != null) {
        debugPrint("success Profile ${res['data']}");
        loginResponseModel.profile?.thumbnail = res['data']['profile']['thumbnail'];
        updateUserDataSharedPrefs(loginResponseModel);
        loadUserDataSharedPrefs();
      }
    } catch (e) {
      print("Upload file exception : $e");
    }
  }

  getUserDetails(context)async{
   UserDetailsModel tempUserDetailsModel = await AuthHelper().getUserDetails(context, showLoader: userDetailsModel.redeem != null && userDetailsModel.redeem != "" ? false : true);
   if(userDetailsModel.redeem != tempUserDetailsModel.redeem){
     sharedPref.save("profileDetails", tempUserDetailsModel.toJson());
     await loadUserDataSharedPrefs();
   }
   notifyListeners();
  }

  loadUserDataSharedPrefs() async {
    var data = await sharedPref.read("profileDetails");
    UserDetailsModel user = data != null ? UserDetailsModel.fromJson(data) : UserDetailsModel();
    userDetailsModel = user;
    notifyListeners();
    debugPrint('LOG => ${userDetailsModel.toJson()}');
  }

}
