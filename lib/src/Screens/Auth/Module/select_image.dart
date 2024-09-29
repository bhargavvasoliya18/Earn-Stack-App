import 'package:earn_streak/src/Utils/Notifier/profile_notifier.dart';
import 'package:flutter/material.dart';

selectImage(context,ProfileNotifier state){
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: context, builder: (BuildContext contexts){
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        height: 140,
        padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
        child: Wrap(
          children: [
            ListTile(leading: const Icon(Icons.photo_library), title: Text("From Gallery"),
                onTap: () { Navigator.of(context).pop(); state.selectImageFromGallery(contexts);  }),
            ListTile(leading: const Icon(Icons.photo_camera), title: Text("From Camera"),
              onTap: () { Navigator.of(context).pop(); state.selectImageFromCamera(contexts); },),
          ],
        ),
      ),
    ) ;
  });
}