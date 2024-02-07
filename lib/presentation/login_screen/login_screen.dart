import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
                      SizedBox(height: 48.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgOlisipoLogoblack,
                          height: 118.v,
                          width: 246.h),
                      SizedBox(height: 33.v),
                      _buildLoginForm(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildLoginForm(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 2.h),
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 17.v),
        decoration: AppDecoration.outlineGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder35),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: 42.v),
          Text("Login", style: theme.textTheme.displaySmall),
          SizedBox(height: 25.v),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Email", style: CustomTextStyles.bodyMediumBlack900)),
          SizedBox(height: 2.v),
          CustomTextFormField(controller: emailController),
          SizedBox(height: 18.v),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Password", style: theme.textTheme.bodyMedium)),
          SizedBox(height: 2.v),
          CustomTextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true),
          SizedBox(height: 12.v),
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    onTapTxtEsqueceusedapassword(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(right: 13.h),
                      child: Text("Esqueceu-se da password?",
                          style: CustomTextStyles.titleSmallPrimary)))),
          SizedBox(height: 90.v),
          CustomElevatedButton(width: 155.h, text: "Login"),
          SizedBox(height: 19.v),
          SizedBox(
              width: 161.h,
              child: Text("Novo aqui?\nFaz o pedido de conta",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleMediumNunitoPrimary))
        ]));
  }

  /// Navigates to the recuperarPasswordEmailScreen when the action is triggered.
  onTapTxtEsqueceusedapassword(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recuperarPasswordEmailScreen);
  }
}
