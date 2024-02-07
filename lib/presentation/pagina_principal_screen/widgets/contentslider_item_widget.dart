import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';

// ignore: must_be_immutable
class ContentsliderItemWidget extends StatelessWidget {
  const ContentsliderItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: ImageConstant.imgContentBlock,
      height: 240.v,
      width: 343.h,
      radius: BorderRadius.circular(
        8.h,
      ),
    );
  }
}
