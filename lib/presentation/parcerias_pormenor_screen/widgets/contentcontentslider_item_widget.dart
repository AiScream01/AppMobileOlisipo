import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class ContentcontentsliderItemWidget extends StatelessWidget {
  const ContentcontentsliderItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 240.v,
          width: 343.h,
          decoration: BoxDecoration(
            color: appTheme.gray100,
            borderRadius: BorderRadius.circular(
              8.h,
            ),
          ),
        ),
        SizedBox(height: 8.v),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Parceria",
            style: theme.textTheme.titleMedium,
          ),
        ),
        SizedBox(height: 16.v),
        Text(
          "Texto aqui!!",
          style: CustomTextStyles.bodyMediumInterBlack900,
        ),
        SizedBox(height: 41.v),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 1.v,
            child: AnimatedSmoothIndicator(
              activeIndex: 0,
              count: 3,
              effect: ScrollingDotsEffect(
                spacing: 8,
                activeDotColor: appTheme.green400,
                dotColor: appTheme.gray200,
                dotHeight: 8.v,
                dotWidth: 8.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
