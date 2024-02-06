import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';
import 'package:rui_pedro_s_application10/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application10/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class RecuperarPasswordConfirmarPasswordScreen extends StatelessWidget {
  RecuperarPasswordConfirmarPasswordScreen({Key? key}) : super(key: key);

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordController1 = TextEditingController();

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
                        EdgeInsets.symmetric(horizontal: 21.h, vertical: 24.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 51.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgOlisipoLogoblack,
                          height: 118.v,
                          width: 246.h),
                      SizedBox(height: 32.v),
                      _buildPasswordSection(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildPasswordSection(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 21.v),
        decoration: AppDecoration.outlineGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder35),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: 31.v),
          SizedBox(
              width: 172.h,
              child: Text("Recuperar Password",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall)),
          SizedBox(height: 41.v),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text("Password",
                      style: CustomTextStyles.bodyMediumBlack900))),
          SizedBox(height: 2.v),
          CustomTextFormField(
              controller: passwordController, obscureText: true),
          SizedBox(height: 18.v),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text("Confirmar Password",
                      style: theme.textTheme.bodyMedium))),
          SizedBox(height: 2.v),
          CustomTextFormField(
              controller: passwordController1,
              textInputAction: TextInputAction.done,
              obscureText: true),
          SizedBox(height: 70.v),
          CustomElevatedButton(
              height: 60.v,
              width: 155.h,
              text: "Recuperar",
              onPressed: () {
                onTapRecuperar(context);
              }),
          SizedBox(height: 18.v),
          GestureDetector(
              onTap: () {
                onTapTxtJTemContaFaz(context);
              },
              child: SizedBox(
                  width: 97.h,
                  child: Text("Já tem conta?\nFaz o login",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.titleMediumNunitoPrimary)))
        ]));
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapRecuperar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapTxtJTemContaFaz(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
