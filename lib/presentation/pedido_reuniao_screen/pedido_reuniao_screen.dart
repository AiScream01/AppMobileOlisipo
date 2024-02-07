import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/app_bar/appbar_leading_image.dart';
import 'package:rui_pedro_s_application11/widgets/app_bar/appbar_trailing_image.dart';
import 'package:rui_pedro_s_application11/widgets/app_bar/custom_app_bar.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

class PedidoReuniaoScreen extends StatelessWidget {
  const PedidoReuniaoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: _buildAppBar(context),
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
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 9.v),
                    child: Column(children: [
                      Text("Pedido de reunião",
                          style: theme.textTheme.displayMedium),
                      SizedBox(height: 12.v),
                      SizedBox(
                          height: 618.v,
                          width: 370.h,
                          child: Stack(alignment: Alignment.center, children: [
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    height: 40.v,
                                    width: 67.h,
                                    margin: EdgeInsets.only(
                                        right: 29.h, bottom: 108.v),
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
                                        horizontal: 23.h, vertical: 25.v),
                                    decoration: AppDecoration.outlineGray
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder35),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 30.v),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 11.h),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 14.v),
                                                        child: Text("Com",
                                                            style: theme
                                                                .textTheme
                                                                .titleLarge)),
                                                    Container(
                                                        width: 193.h,
                                                        margin: EdgeInsets.only(
                                                            top: 10.v),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8.h,
                                                                vertical: 1.v),
                                                        decoration: AppDecoration
                                                            .outlinePrimary2
                                                            .copyWith(
                                                                borderRadius:
                                                                    BorderRadiusStyle
                                                                        .roundedBorder8),
                                                        child: Text(
                                                            "Recursos Humanos",
                                                            style: theme
                                                                .textTheme
                                                                .titleLarge))
                                                  ])),
                                          SizedBox(height: 35.v),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 1.h, right: 12.h),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4.v),
                                                            child: Text(
                                                                "Data Reunião",
                                                                style: theme
                                                                    .textTheme
                                                                    .titleLarge)),
                                                        Container(
                                                            height: 29.v,
                                                            width: 126.h,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        2.v),
                                                            child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                children: [
                                                                  Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      child: Container(
                                                                          height: 28
                                                                              .v,
                                                                          width: 126
                                                                              .h,
                                                                          decoration: BoxDecoration(
                                                                              color: theme.colorScheme.onPrimaryContainer.withOpacity(0.85),
                                                                              borderRadius: BorderRadius.circular(10.h),
                                                                              border: Border.all(color: theme.colorScheme.primary, width: 1.h, strokeAlign: strokeAlignCenter)))),
                                                                  Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topCenter,
                                                                      child: Text(
                                                                          "Calendário",
                                                                          style: theme
                                                                              .textTheme
                                                                              .titleLarge))
                                                                ]))
                                                      ]))),
                                          SizedBox(height: 40.v),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 3.h, right: 10.h),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 4.v),
                                                        child: Text("Hora",
                                                            style: theme
                                                                .textTheme
                                                                .titleLarge)),
                                                    Container(
                                                        width: 126.h,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    30.h,
                                                                vertical: 1.v),
                                                        decoration: AppDecoration
                                                            .outlinePrimary2
                                                            .copyWith(
                                                                borderRadius:
                                                                    BorderRadiusStyle
                                                                        .roundedBorder8),
                                                        child: Text("10:00",
                                                            style: theme
                                                                .textTheme
                                                                .titleLarge))
                                                  ])),
                                          Spacer(),
                                          CustomOutlinedButton(
                                              width: 144.h,
                                              text: "Enviar",
                                              onPressed: () {
                                                onTapEnviar(context);
                                              })
                                        ])))
                          ])),
                      SizedBox(height: 5.v)
                    ])))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 70.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgDoUtilizador,
            margin: EdgeInsets.only(left: 25.h, top: 5.v, bottom: 5.v),
            onTap: () {
              onTapDoUtilizador(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgMegaphone,
              margin: EdgeInsets.fromLTRB(25.h, 17.v, 25.h, 18.v))
        ]);
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }

  /// Displays a dialog with the [PushNotificationDialog] content.
  onTapEnviar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: PushNotificationDialog(),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.only(left: 0),
            ));
  }
}
