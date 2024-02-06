import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';
import 'package:rui_pedro_s_application10/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application10/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class RegistoScreen extends StatelessWidget {
  RegistoScreen({Key? key}) : super(key: key);

  TextEditingController editTextController = TextEditingController();

  TextEditingController emailController = TextEditingController();

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
                        EdgeInsets.symmetric(horizontal: 21.h, vertical: 28.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 47.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgOlisipoLogoblack,
                          height: 118.v,
                          width: 246.h),
                      SizedBox(height: 32.v),
                      _buildRegistrationForm(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildRegistrationForm(BuildContext context) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.v),
            decoration: AppDecoration.outlineGray
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder35),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(height: 34.v),
              Text("Pedido de Conta", style: theme.textTheme.displaySmall),
              SizedBox(height: 38.v),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 1.h),
                      child: Text("Nome Completo",
                          style: CustomTextStyles.bodyMediumBlack900))),
              SizedBox(height: 1.v),
              CustomTextFormField(controller: editTextController),
              SizedBox(height: 18.v),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 1.h),
                      child: Text("Email", style: theme.textTheme.bodyMedium))),
              SizedBox(height: 2.v),
              CustomTextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.done),
              Spacer(),
              CustomElevatedButton(
                  height: 60.v,
                  width: 155.h,
                  text: "Efetuar Pedido",
                  buttonTextStyle: CustomTextStyles.titleLargeOnPrimary,
                  onPressed: () {
                    onTapEfetuarPedido(context);
                  }),
              SizedBox(height: 14.v),
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
            ])));
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapEfetuarPedido(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapTxtJTemContaFaz(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
