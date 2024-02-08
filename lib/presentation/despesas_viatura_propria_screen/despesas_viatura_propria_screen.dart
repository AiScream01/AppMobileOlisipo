import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

// ignore_for_file: must_be_immutable
class DespesasViaturaPropriaScreen extends StatelessWidget {
  DespesasViaturaPropriaScreen({Key? key}) : super(key: key);

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
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 5.v),
                      _buildDoUtilizadorRow(context),
                      SizedBox(height: 5.v),
                      Text("Viatura própria",
                          style: theme.textTheme.displayMedium),
                      SizedBox(height: 10.v),
                      SizedBox(
                          height: 5.v,
                          width: 370.h,
                          child: Stack(alignment: Alignment.center, children: [
                            _buildEditText(context),
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30.h, vertical: 21.v),
                                    decoration: AppDecoration.outlineGray
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder35),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 50.v),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 1.h),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 3.v),
                                                        child: Text(
                                                            "Ponto de partida",
                                                            style: theme
                                                                .textTheme
                                                                .titleLarge)),
                                                    _buildViseuButton(context)
                                                  ])),
                                          SizedBox(height: 50.v),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 1.h),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 3.v),
                                                        child: Text(
                                                            "Ponto de chegada",
                                                            style: theme
                                                                .textTheme
                                                                .titleLarge)),
                                                    _buildLisboaButton(context)
                                                  ])),
                                          SizedBox(height: 50.v),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 1.h),
                                              child: _buildSixtyTwoRow(context,
                                                  title: "Kilometros",
                                                  price: "300")),
                                          SizedBox(height: 50.v),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 1.h),
                                              child: _buildSixtyTwoRow(context,
                                                  title: "Portagens ",
                                                  price: "18€")),
                                          SizedBox(height: 50.v),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 1.h, right: 41.h),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 1.v),
                                                            child: Text(
                                                                "Comprovativo",
                                                                style: theme
                                                                    .textTheme
                                                                    .titleLarge)),
                                                        Text("PDF",
                                                            style: CustomTextStyles
                                                                .titleLargePrimary)
                                                      ]))),
                                          SizedBox(height: 65.v),
                                          _buildEnviarButton(context)
                                        ])))
                          ]))
                    ])))));
  }

  /// Section Widget
  Widget _buildDoUtilizadorRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 1.h, right: 9.h),
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
  Widget _buildEditText(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 29.h, bottom: 107.v),
        child: CustomTextFormField(
            width: 67.h,
            controller: editTextController,
            textInputAction: TextInputAction.done,
            alignment: Alignment.bottomRight));
  }

  /// Section Widget
  Widget _buildViseuButton(BuildContext context) {
    return CustomOutlinedButton(
        height: 32.v,
        width: 126.h,
        text: "Viseu",
        buttonStyle: CustomButtonStyles.outlinePrimaryTL10,
        buttonTextStyle: theme.textTheme.titleLarge!);
  }

  /// Section Widget
  Widget _buildLisboaButton(BuildContext context) {
    return CustomOutlinedButton(
        height: 32.v,
        width: 126.h,
        text: "Lisboa",
        buttonStyle: CustomButtonStyles.outlinePrimary,
        buttonTextStyle: theme.textTheme.titleLarge!);
  }

  /// Section Widget
  Widget _buildEnviarButton(BuildContext context) {
    return CustomOutlinedButton(
        width: 144.h,
        text: "Enviar",
        onPressed: () {
          onTapEnviarButton(context);
        });
  }

  /// Common widget
  Widget _buildSixtyTwoRow(
    BuildContext context, {
    required String title,
    required String price,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 3.v),
          child: Text(title,
              style: theme.textTheme.titleLarge!
                  .copyWith(color: appTheme.black900))),
      Container(
          width: 126.h,
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 1.v),
          decoration: AppDecoration.outlinePrimary
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
          child: Text(price,
              style: theme.textTheme.titleLarge!
                  .copyWith(color: appTheme.black900)))
    ]);
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }

  /// Displays a dialog with the [PushNotificationDialog] content.
  onTapEnviarButton(BuildContext context) {
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
