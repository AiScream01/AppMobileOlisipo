import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class RecuperarPasswordEmailScreen extends StatelessWidget {
  RecuperarPasswordEmailScreen({Key? key})
      : super(
          key: key,
        );

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
                offset: Offset(
                  10,
                  10,
                ),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgLogin,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 21.h,
              vertical: 30.v,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgOlisipoLogoblack,
                  height: 118.v,
                  width: 246.h,
                ),
                SizedBox(height: 40.v),
                _buildPasswordRecovery(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordRecovery(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 30.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder35,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200.h,
            child: Text(
              "Recuperar Password",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.displaySmall,
            ),
          ),
          SizedBox(height: 40.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5.h),
              child: Text(
                "Email",
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
          SizedBox(height: 10.v),
          CustomTextFormField(
            controller: emailController,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: 30.v),
          CustomElevatedButton(
            width: 155.h,
            text: "Recuperar",
          ),
          SizedBox(height: 25.v),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.loginScreen);
            },
            child: SizedBox(
              width: 150.h,
              child: Text(
                "Já tem conta?\nFaz o login",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.titleMediumNunitoPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
