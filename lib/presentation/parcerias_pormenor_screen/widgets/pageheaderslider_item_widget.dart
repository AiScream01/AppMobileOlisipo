import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';

// ignore: must_be_immutable
class PageheadersliderItemWidget extends StatelessWidget {
  const PageheadersliderItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 7.v,
                  bottom: 9.v,
                ),
                child: Text(
                  "Back",
                  style: CustomTextStyles.titleMediumMedium,
                ),
              ),
              Text(
                "Parcerias",
                style: theme.textTheme.headlineLarge,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 7.v,
                  bottom: 9.v,
                ),
                child: Text(
                  "Filtro",
                  style: CustomTextStyles.titleMediumMedium,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.v),
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
        SizedBox(height: 6.v),
        Text(
          "Parceria ",
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(height: 9.v),
        Text(
          "Texto aqui!!",
          style: CustomTextStyles.bodyMediumInterBlack900,
        ),
      ],
    );
  }
}
