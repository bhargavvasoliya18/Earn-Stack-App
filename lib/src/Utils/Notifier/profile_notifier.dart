import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileNotifier extends ChangeNotifier{

  Future<bool> getCameraPermissionStatus() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    } else if(status.isPermanentlyDenied) {
      return false;
    }else if(status.isDenied){
      return false;
    }
    else  {
      return false;
    }
  }

  XFile? pickedFile;

  selectImageFromCamera() async {
      if(await getCameraPermissionStatus()) {
        pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      }
    notifyListeners();
  }

  selectImageFromGallery() async {
     pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
     notifyListeners();
  }

}