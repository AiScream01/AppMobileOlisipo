import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';
import 'package:rui_pedro_s_application10/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application10/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application10/presentation/push_notification_dialog/push_notification_dialog.dart';

// ignore_for_file: must_be_immutable
class FaltasScreen extends StatelessWidget {
  FaltasScreen({Key? key}) : super(key: key);

  TextEditingController editTextController = TextEditingController();

  TextEditingController editTextController1 = TextEditingController();

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
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 29.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      _buildUserProfile(context),
                      SizedBox(height: 20.v),
                      Text("Faltas", style: theme.textTheme.displayMedium),
                      SizedBox(height: 12.v),
                      _buildFaltasSection(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
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
  Widget _buildFaltasSection(BuildContext context) {
    return SizedBox(
        height: 608.v,
        width: 370.h,
        child: Stack(alignment: Alignment.center, children: [
          Padding(
              padding: EdgeInsets.only(right: 29.h, bottom: 103.v),
              child: CustomTextFormField(
                  width: 67.h,
                  controller: editTextController,
                  alignment: Alignment.bottomRight)),
          Align(
              alignment: Alignment.center,
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 27.h, vertical: 47.v),
                  decoration: AppDecoration.outlineGray.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder35),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(height: 19.v),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 2.h),
                            child: Text("Data",
                                style: theme.textTheme.titleLarge))),
                    SizedBox(height: 87.v),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Descrição",
                            style: theme.textTheme.titleLarge)),
                    SizedBox(height: 9.v),
                    Padding(
                        padding: EdgeInsets.only(left: 2.h, right: 3.h),
                        child: CustomTextFormField(
                            controller: editTextController1,
                            textInputAction: TextInputAction.done,
                            borderDecoration:
                                TextFormFieldStyleHelper.outlineBlackTL10,
                            filled: true,
                            fillColor: theme.colorScheme.onPrimaryContainer)),
                    SizedBox(height: 34.v),
                    Padding(
                        padding: EdgeInsets.only(left: 2.h, right: 7.h),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 1.v),
                                  child: Text("Comprovativo",
                                      style: theme.textTheme.titleLarge)),
                              Text("PDF",
                                  style: CustomTextStyles.titleLargePrimary)
                            ])),
                    SizedBox(height: 61.v),
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
