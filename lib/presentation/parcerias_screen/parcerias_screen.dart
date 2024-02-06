import '../parcerias_screen/widgets/parceriasgrid_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';

class ParceriasScreen extends StatelessWidget {
  const ParceriasScreen({Key? key}) : super(key: key);

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
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      _buildDoUtilizadorRow(context),
                      SizedBox(height: 20.v),
                      Text("Parcerias", style: theme.textTheme.displayMedium),
                      SizedBox(height: 12.v),
                      SizedBox(
                          height: 607.v,
                          width: 370.h,
                          child: Stack(alignment: Alignment.center, children: [
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    height: 40.v,
                                    width: 67.h,
                                    margin: EdgeInsets.only(
                                        right: 29.h, bottom: 102.v),
                                    decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        borderRadius:
                                            BorderRadius.circular(7.h),
                                        border: Border.all(
                                            color: theme.colorScheme.primary,
                                            width: 1.h),
                                        boxShadow: [
                                          BoxShadow(
                                              color: appTheme.black900
                                                  .withOpacity(0.25),
                                              spreadRadius: 2.h,
                                              blurRadius: 2.h,
                                              offset: Offset(0, 4))
                                        ]))),
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14.h, vertical: 26.v),
                                    decoration: AppDecoration.outlineGray
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder35),
                                    child: _buildParceriasGrid(context)))
                          ]))
                    ])))));
  }

  /// Section Widget
  Widget _buildDoUtilizadorRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10.h),
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
              margin: EdgeInsets.only(top: 12.v, bottom: 13.v),
              onTap: () {
                onTapImgMegaphone(context);
              })
        ]));
  }

  /// Section Widget
  Widget _buildParceriasGrid(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 5.h),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 71.v,
                crossAxisCount: 4,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.h),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, index) {
              return ParceriasgridItemWidget(onTapWidget: () {
                onTapWidget(context);
              }, onTapImgImageThree: () {
                onTapImgImageThree(context);
              });
            }));
  }

  /// Navigates to the parceriasPormenorOneScreen when the action is triggered.
  onTapWidget(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.parceriasPormenorOneScreen);
  }

  /// Navigates to the parceriasPormenorOneScreen when the action is triggered.
  onTapImgImageThree(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.parceriasPormenorOneScreen);
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }

  /// Navigates to the menuHamburguerScreen when the action is triggered.
  onTapImgMegaphone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.menuHamburguerScreen);
  }
}
