import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

class PedidoFeriasScreen extends StatelessWidget {
  const PedidoFeriasScreen({Key? key}) : super(key: key);

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
                        EdgeInsets.symmetric(horizontal: 21.h, vertical: 27.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 3.v),
                      _buildNinetyFiveRow(context),
                      SizedBox(height: 3.v),
                      Text("Férias", style: theme.textTheme.displayMedium),
                      SizedBox(height: 13.v),
                      _buildFiftySixStack(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildNinetyFiveRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 8.h),
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
  Widget _buildFiftySixStack(BuildContext context) {
    return SizedBox(
        height: 626.v,
        width: 365.h,
        child: Stack(alignment: Alignment.center, children: [
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  height: 40.v,
                  width: 66.h,
                  margin: EdgeInsets.only(right: 29.h, bottom: 105.v),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(7.h),
                      border: Border.all(
                          color: theme.colorScheme.primary, width: 1.h),
                      boxShadow: [
                        BoxShadow(
                            color: appTheme.black900.withOpacity(0.25),
                            spreadRadius: 2.h,
                            blurRadius: 2.h,
                            offset: Offset(0, 4))
                      ]))),
          Align(
              alignment: Alignment.center,
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.h, vertical: 22.v),
                  decoration: AppDecoration.outlineGray.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder35),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(height: 74.v),
                    Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 1.v, bottom: 9.v),
                                  child: Text("Data Início",
                                      style: theme.textTheme.titleLarge)),
                              CustomOutlinedButton(
                                  height: 39.v,
                                  width: 126.h,
                                  text: "Calendário",
                                  buttonStyle:
                                      CustomButtonStyles.outlinePrimary,
                                  buttonTextStyle: theme.textTheme.titleLarge!)
                            ])),
                    SizedBox(height: 77.v),
                    Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.v, bottom: 2.v),
                                  child: Text("Data Fim",
                                      style: theme.textTheme.titleLarge)),
                              CustomOutlinedButton(
                                  height: 39.v,
                                  width: 126.h,
                                  text: "Calendário",
                                  buttonStyle:
                                      CustomButtonStyles.outlinePrimary,
                                  buttonTextStyle: theme.textTheme.titleLarge!)
                            ])),
                    Spacer(),
                    CustomOutlinedButton(
                        width: 144.h,
                        text: "Enviar",
                        onPressed: () {
                          onTapEnviar(context);
                        })
                  ])))
        ]));
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
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
