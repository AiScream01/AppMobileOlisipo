import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';

class ParceriasPormenorOneScreen extends StatelessWidget {
  const ParceriasPormenorOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: Container(
                width: SizeUtils.width,
                height: SizeUtils.height,
                decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimaryContainer,
                    boxShadow: [
                      BoxShadow(
                          color: appTheme.black900.withOpacity(0.3),
                          spreadRadius: 2.h,
                          blurRadius: 2.h,
                          offset: Offset(10, 10))
                    ],
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgLogin),
                        fit: BoxFit.cover)),
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 30.v),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.h),
                                  child: Column(children: [
                                    _buildDoUtilizadorRow(context),
                                    SizedBox(height: 18.v),
                                    Text("Parcerias",
                                        style: theme.textTheme.displayMedium),
                                    SizedBox(height: 12.v),
                                    Container(
                                        margin: EdgeInsets.only(left: 1.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 11.h, vertical: 45.v),
                                        decoration: AppDecoration.outlineGray
                                            .copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder35),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Nome parceria",
                                                  style: theme
                                                      .textTheme.headlineLarge),
                                              SizedBox(height: 6.v),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 3.h),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        _buildNineteenRow(
                                                            context),
                                                        SizedBox(height: 10.v),
                                                        Text("Parceria ",
                                                            style: theme
                                                                .textTheme
                                                                .titleMedium),
                                                        SizedBox(height: 11.v),
                                                        Container(
                                                            width: 335.h,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 7.h),
                                                            child: Text(
                                                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse.",
                                                                maxLines: 9,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: CustomTextStyles
                                                                    .headlineSmallInter_1))
                                                      ])),
                                              SizedBox(height: 12.v)
                                            ]))
                                  ]))))
                    ])))));
  }

  /// Section Widget
  Widget _buildDoUtilizadorRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomImageView(
              imagePath: ImageConstant.imgDoUtilizador,
              height: 45.adaptSize,
              width: 45.adaptSize,
              onTap: () {
                onTapImgDoUtilizador(context);
              }),
          CustomImageView(
              imagePath: ImageConstant.imgMegaphone,
              height: 20.v,
              width: 39.h,
              margin: EdgeInsets.only(top: 12.v, bottom: 13.v))
        ]));
  }

  /// Section Widget
  Widget _buildNineteenRow(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 91.v),
        decoration: AppDecoration.fillGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                  imagePath: ImageConstant.imgUser,
                  height: 37.adaptSize,
                  width: 37.adaptSize,
                  margin: EdgeInsets.only(left: 5.h, bottom: 21.v)),
              CustomImageView(
                  imagePath: ImageConstant.imgOverflowMenu,
                  height: 37.adaptSize,
                  width: 37.adaptSize,
                  margin: EdgeInsets.only(bottom: 21.v))
            ]));
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }
}
