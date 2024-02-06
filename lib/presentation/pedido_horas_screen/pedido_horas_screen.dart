import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';
import 'package:rui_pedro_s_application10/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application10/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application10/presentation/push_notification_dialog/push_notification_dialog.dart';

// ignore_for_file: must_be_immutable
class PedidoHorasScreen extends StatelessWidget {
  PedidoHorasScreen({Key? key}) : super(key: key);

  TextEditingController editTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
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
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 27.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 3.v),
                      _buildUserProfileRow(context),
                      SizedBox(height: 3.v),
                      Text("Horas", style: theme.textTheme.displayMedium),
                      SizedBox(height: 12.v),
                      _buildHoursRequestStack(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildUserProfileRow(BuildContext context) {
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
              margin: EdgeInsets.only(top: 12.v, bottom: 13.v),
              onTap: () {
                onTapImgMegaphone(context);
              })
        ]));
  }

  /// Section Widget
  Widget _buildHoursRequestStack(BuildContext context) {
    return SizedBox(
        height: 627.v,
        width: 370.h,
        child: Stack(alignment: Alignment.center, children: [
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  height: 40.v,
                  width: 67.h,
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
                      EdgeInsets.symmetric(horizontal: 28.h, vertical: 54.v),
                  decoration: AppDecoration.outlineGray.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder35),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(height: 4.v),
                    Padding(
                        padding: EdgeInsets.only(left: 1.h, right: 2.h),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(bottom: 5.v),
                                  child: Text("Horas",
                                      style: theme.textTheme.titleLarge)),
                              Container(
                                  width: 126.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.h, vertical: 1.v),
                                  decoration: AppDecoration.outlinePrimary1
                                      .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder8),
                                  child: Text("00:00",
                                      style: theme.textTheme.titleLarge))
                            ])),
                    Spacer(flex: 44),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 1.h),
                            child: Text("Descrição",
                                style: theme.textTheme.titleLarge))),
                    SizedBox(height: 9.v),
                    CustomTextFormField(
                        controller: editTextController,
                        textInputAction: TextInputAction.done,
                        borderDecoration:
                            TextFormFieldStyleHelper.outlineBlackTL10,
                        filled: true,
                        fillColor: theme.colorScheme.onPrimaryContainer),
                    Spacer(flex: 55),
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

  /// Navigates to the menuHamburguerScreen when the action is triggered.
  onTapImgMegaphone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.menuHamburguerScreen);
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
