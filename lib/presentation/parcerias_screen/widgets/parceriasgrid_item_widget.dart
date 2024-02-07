import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';

// ignore: must_be_immutable
class ParceriasgridItemWidget extends StatelessWidget {
  ParceriasgridItemWidget({
    Key? key,
    this.onTapWidget,
    this.onTapImgImageThree,
  }) : super(
          key: key,
        );

  VoidCallback? onTapWidget;

  VoidCallback? onTapImgImageThree;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapWidget!.call();
      },
      child: Container(
        height: 70.adaptSize,
        width: 70.adaptSize,
        padding: EdgeInsets.all(1.h),
        decoration: AppDecoration.outlineGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder20,
        ),
        child: CustomImageView(
          imagePath: ImageConstant.imgImage3,
          height: 65.adaptSize,
          width: 65.adaptSize,
          alignment: Alignment.center,
          onTap: () {
            onTapImgImageThree!.call();
          },
        ),
      ),
    );
  }
}
