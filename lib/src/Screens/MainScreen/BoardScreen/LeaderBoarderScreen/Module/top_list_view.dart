import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Element/padding_class.dart';
import 'package:earn_streak/src/Style/text_style.dart';
import 'package:earn_streak/src/Widget/common_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

topListView({String? image, String? name, String? coin, double? imageSize, String? tajImage}){
  return Column(
    children: [
      SvgPicture.asset(tajImage ?? ""),
      ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: fadeImageView(image ?? "", placeHolderSize: imageSize ?? 85)
      ),
      Text(name ?? "", style: TextStyleTheme.customTextStyle(Colors.black, 14, FontWeight.w700),),
      Row(
        children: [
          Image.asset(AppImages.courncyIcon, height: 15,),
          paddingLeft(02),
          Text(coin ?? "", style: TextStyleTheme.customTextStyle(AppColors.green, 16, FontWeight.w600),),
        ],
      ),
    ],
  );
}