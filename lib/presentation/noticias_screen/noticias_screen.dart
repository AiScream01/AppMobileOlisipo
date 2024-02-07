import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';

class NoticiasScreen extends StatelessWidget {
  const NoticiasScreen({Key? key}) : super(key: key);

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
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.h, vertical: 30.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      _buildDoUtilizadorRow(context),
                      Text("Notícias", style: theme.textTheme.displayMedium),
                      SizedBox(height: 13.v),
                      Container(
                          height: 267.v,
                          width: 369.h,
                          decoration: BoxDecoration(
                              color: theme.colorScheme.onPrimaryContainer,
                              borderRadius: BorderRadius.circular(35.h),
                              border: Border.all(
                                  color: appTheme.gray20001, width: 1.h),
                              boxShadow: [
                                BoxShadow(
                                    color: appTheme.black900.withOpacity(0.2),
                                    spreadRadius: 2.h,
                                    blurRadius: 2.h,
                                    offset: Offset(0, 4))
                              ])),
                      SizedBox(height: 15.v),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {
                                onTapTxtEstetextovaiconter4(context);
                              },
                              child: Container(
                                  width: 316.h,
                                  margin:
                                      EdgeInsets.only(left: 21.h, right: 47.h),
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text:
                                                "Este texto vai conter a descrição da notícia que está acima.",
                                            style: CustomTextStyles
                                                .titleLargeff000000),
                                        TextSpan(text: " "),
                                        TextSpan(
                                            text: "Ver mais",
                                            style: theme.textTheme.titleSmall)
                                      ]),
                                      textAlign: TextAlign.left)))),
                      SizedBox(height: 14.v),
                      _buildEightyTwoRow(context),
                      SizedBox(height: 17.v),
                      _buildViewRow(context),
                      SizedBox(height: 5.v)
                    ])))));
  }

  /// Section Widget
  Widget _buildDoUtilizadorRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
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
  Widget _buildEightyTwoRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 100.v,
                  width: 128.h,
                  decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimaryContainer,
                      borderRadius: BorderRadius.circular(20.h),
                      border: Border.all(color: appTheme.gray20001, width: 1.h),
                      boxShadow: [
                        BoxShadow(
                            color: appTheme.black900.withOpacity(0.2),
                            spreadRadius: 2.h,
                            blurRadius: 2.h,
                            offset: Offset(0, 4))
                      ])),
              Container(
                  width: 232.h,
                  margin: EdgeInsets.only(left: 17.h, top: 9.v, bottom: 23.v),
                  child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "Este texto vai conter a descrição da notícia que está acima.\n",
                            style: CustomTextStyles.titleMediumNunitoff000000),
                        TextSpan(
                            text: "Ver mais", style: theme.textTheme.titleSmall)
                      ]),
                      textAlign: TextAlign.left))
            ]));
  }

  /// Section Widget
  Widget _buildViewRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 100.v,
                  width: 128.h,
                  decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimaryContainer,
                      borderRadius: BorderRadius.circular(20.h),
                      border: Border.all(color: appTheme.gray20001, width: 1.h),
                      boxShadow: [
                        BoxShadow(
                            color: appTheme.black900.withOpacity(0.2),
                            spreadRadius: 2.h,
                            blurRadius: 2.h,
                            offset: Offset(0, 4))
                      ])),
              Container(
                  width: 232.h,
                  margin: EdgeInsets.only(left: 17.h, top: 9.v, bottom: 23.v),
                  child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "Este texto vai conter a descrição da notícia que está acima.\n",
                            style: CustomTextStyles.titleMediumNunitoff000000),
                        TextSpan(
                            text: "Ver mais", style: theme.textTheme.titleSmall)
                      ]),
                      textAlign: TextAlign.left))
            ]));
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }

  /// Navigates to the noticiaScreen when the action is triggered.
  onTapTxtEstetextovaiconter4(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.noticiaScreen);
  }
}
