import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';

// ignore: must_be_immutable
class MeetingcardlistItemWidget extends StatelessWidget {
  const MeetingcardlistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.v,
      width: 313.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 40.v,
              width: 313.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.h,
                ),
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 1.h,
                  strokeAlign: strokeAlignCenter,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Reunião",
                  style: CustomTextStyles.titleLargeBold,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 19.h),
                  child: Text(
                    "27/11/2023",
                    style: CustomTextStyles.titleLargeMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.h),
                  child: Text(
                    "10:00",
                    style: CustomTextStyles.titleLargeMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
