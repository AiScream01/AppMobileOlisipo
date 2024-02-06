import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';

// ignore: must_be_immutable
class SliderItemWidget extends StatelessWidget {
  const SliderItemWidget({Key? key})
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
