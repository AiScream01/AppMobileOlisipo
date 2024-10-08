import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
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
                offset: Offset(10, 10),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 21.h, vertical: 24.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 51.v),
                  CustomImageView(
                    imagePath: ImageConstant.imgOlisipoLogoblack,
                    height: 118.v,
                    width: 246.h,
                  ),
                  SizedBox(height: 32.v),
                  _buildPasswordRecovery(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordRecovery(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.v),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder35,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.v),
          Text(
            "Recuperar Password",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall,
          ),
          SizedBox(height: 40.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 2.h),
              child: Text(
                "Password",
                style: CustomTextStyles.bodyMediumBlack900,
              ),
            ),
          ),
          SizedBox(height: 10.v),
          CustomTextFormField(
            controller: passwordController,
            obscureText: true,
          ),
          SizedBox(height: 20.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 2.h),
              child: Text(
                "Confirmar Password",
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
          SizedBox(height: 10.v),
          CustomTextFormField(
            controller: passwordController1,
            textInputAction: TextInputAction.done,
            obscureText: true,
          ),
          SizedBox(height: 50.v),
          CustomElevatedButton(
            width: 155.h,
            text: "Recuperar",
          ),
          SizedBox(height: 20.v),
          GestureDetector(
            onTap: () {
              // Navegar para a tela de login
              Navigator.pushNamed(context, AppRoutes.loginScreen);
            },
            child: Text(
              "Já tem conta?\nFaz o login",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.titleMediumNunitoPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
