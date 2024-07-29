import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';

class NoticiaScreen extends StatelessWidget {
  const NoticiaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                height: SizeUtils.height,
                width: double.maxFinite,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgLogin,
                      height: 800.v,
                      width: 411.h,
                      alignment: Alignment.center),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                          child: Container(
                              height: 811.v,
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(horizontal: 13.h),
                              child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                            height: 786.v,
                                            width: 377.h,
                                            child: Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 8.h),
                                                          child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                _buildUserImage(
                                                                    context),
                                                                SizedBox(
                                                                    height:
                                                                        16.v),
                                                                Text(
                                                                    "NASA Descobre Exoplaneta",
                                                                    style: theme
                                                                        .textTheme
                                                                        .displayMedium),
                                                                SizedBox(
                                                                    height:
                                                                        13.v),
                                                                Container(
                                                                    height:
                                                                        289.v,
                                                                    width:
                                                                        369.h,
                                                                    decoration: BoxDecoration(
                                                                        color: theme
                                                                            .colorScheme
                                                                            .onPrimaryContainer,
                                                                        borderRadius: BorderRadius.circular(35
                                                                            .h),
                                                                        border: Border.all(
                                                                            color: appTheme
                                                                                .gray20001,
                                                                            width: 1
                                                                                .h),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: appTheme.black900.withOpacity(0.2),
                                                                              spreadRadius: 2.h,
                                                                              blurRadius: 2.h,
                                                                              offset: Offset(0, 4))
                                                                        ]),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(35
                                                                            .h),
                                                                        child: Image.network(
                                                                            'https://exoplanets.nasa.gov/system/news_items/main_images/731_HubbleK2-18b.jpg',
                                                                            fit: BoxFit.cover))),
                                                                SizedBox(
                                                                    height:
                                                                        27.v),
                                                                Container(
                                                                    width:
                                                                        352.h,
                                                                    margin: EdgeInsets.only(
                                                                        left: 13
                                                                            .h,
                                                                        right: 4
                                                                            .h),
                                                                    child: Text(
                                                                        "A NASA anunciou a descoberta de um exoplaneta que pode conter água em sua superfície. O planeta, chamado K2-18b.",
                                                                        style: CustomTextStyles
                                                                            .titleLargeMedium)),
                                                              ]))),
                                                  Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: SizedBox(
                                                          width: 232.h,
                                                          child: RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                        text:
                                                                            "Este texto contém uma descrição da notícia acima.\n",
                                                                        style: CustomTextStyles
                                                                            .titleMediumNunitoff000000),
                                                                    TextSpan(
                                                                        text:
                                                                            "Ver mais",
                                                                        style: theme
                                                                            .textTheme
                                                                            .titleSmall)
                                                                  ]),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left)))
                                                ]))),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                            height: 100.v,
                                            width: 128.h,
                                            margin: EdgeInsets.only(left: 8.h),
                                            decoration: BoxDecoration(
                                                color: theme.colorScheme
                                                    .onPrimaryContainer,
                                                borderRadius:
                                                    BorderRadius.circular(20.h),
                                                border: Border.all(
                                                    color: appTheme.gray20001,
                                                    width: 1.h),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: appTheme.black900
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2.h,
                                                      blurRadius: 2.h,
                                                      offset: Offset(0, 4))
                                                ]),
                                            child: Padding(
                                                padding: EdgeInsets.all(8.h),
                                                child: Text(
                                                    "K2-18b é um exoplaneta super-Terra, maior que o nosso planeta, mas menor que Netuno. A descoberta de vapor de água na atmosfera de K2-18b é um passo importante na busca por vida fora do Sistema Solar.",
                                                    style: CustomTextStyles
                                                        .titleLargeMedium))))
                                  ]))))
                ]))));
  }

  /// Section Widget
  Widget _buildUserImage(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.h),
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

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }
}
