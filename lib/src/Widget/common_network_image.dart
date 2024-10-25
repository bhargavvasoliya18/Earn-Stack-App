import 'package:cached_network_image/cached_network_image.dart';
import 'package:earn_streak/src/Constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../Constants/app_images.dart';

Widget fadeImageView(String img, {double? placeHolderSize, double? borderRadius, String? placeImage}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius ?? 10),
    child: CachedNetworkImage(
      fadeInCurve: Curves.linear,
      fadeOutCurve: Curves.linear,
      fadeInDuration: const Duration(milliseconds: 100),
      fadeOutDuration: const Duration(milliseconds: 100),
      imageUrl: img,
      fit: BoxFit.cover,
      height: placeHolderSize ?? 100,
      width: placeHolderSize ?? 100,
      placeholder: (context, url) => Icon(
        Icons.image_outlined,
        color: AppColors.purple,
        size: placeHolderSize,
      ),
      errorWidget: (context, url, error) => Container(
        height: placeHolderSize ?? 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(placeImage ?? AppImages.dummyUserImage),
      ),
    ),
  );
}
