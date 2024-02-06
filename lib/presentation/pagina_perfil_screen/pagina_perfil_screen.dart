import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';
import 'package:rui_pedro_s_application10/widgets/custom_outlined_button.dart';

class PaginaPerfilScreen extends StatelessWidget {
  const PaginaPerfilScreen({Key? key}) : super(key: key);

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
                        EdgeInsets.symmetric(horizontal: 21.h, vertical: 28.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 14.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgMegaphone,
                          height: 20.v,
                          width: 39.h,
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 4.h),
                          onTap: () {
                            onTapImgMegaphone(context);
                          }),
                      SizedBox(height: 45.v),
                      _buildPaginaPerfil(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildPaginaPerfil(BuildContext context) {
    return Container(
        width: 369.h,
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 21.v),
        decoration: AppDecoration.outlineGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder35),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      height: 158.v,
                      width: 163.h,
                      child: Stack(alignment: Alignment.centerRight, children: [
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                                height: 158.v,
                                width: 163.h,
                                decoration: BoxDecoration(
                                    color: appTheme.gray300,
                                    borderRadius: BorderRadius.circular(81.h),
                                    boxShadow: [
                                      BoxShadow(
                                          color: appTheme.black900
                                              .withOpacity(0.25),
                                          spreadRadius: 2.h,
                                          blurRadius: 2.h,
                                          offset: Offset(0, 4))
                                    ]))),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                height: 97.v,
                                width: 115.h,
                                margin: EdgeInsets.only(right: 15.h),
                                child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgDoUtilizador,
                                          height: 97.adaptSize,
                                          width: 97.adaptSize,
                                          alignment: Alignment.centerLeft),
                                      CustomImageView(
                                          imagePath: ImageConstant.imgEdit,
                                          height: 19.v,
                                          width: 20.h,
                                          alignment: Alignment.bottomRight,
                                          margin: EdgeInsets.only(bottom: 4.v))
                                    ])))
                      ]))),
              SizedBox(height: 58.v),
              Text("Nome", style: CustomTextStyles.titleLargePrimary),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                    padding: EdgeInsets.only(top: 7.v),
                    child: Text("Pedro Martins",
                        style: theme.textTheme.bodyLarge)),
                CustomImageView(
                    imagePath: ImageConstant.imgEdit,
                    height: 19.v,
                    width: 20.h,
                    margin: EdgeInsets.only(left: 12.h, bottom: 13.v))
              ]),
              SizedBox(height: 28.v),
              Text("Password", style: CustomTextStyles.titleLargePrimary),
              SizedBox(height: 3.v),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                    padding: EdgeInsets.only(top: 4.v),
                    child: Text("**************",
                        style: theme.textTheme.bodyLarge)),
                CustomImageView(
                    imagePath: ImageConstant.imgEdit,
                    height: 19.v,
                    width: 20.h,
                    margin: EdgeInsets.only(left: 9.h, bottom: 10.v))
              ]),
              SizedBox(height: 29.v),
              Text("Email", style: CustomTextStyles.titleLargePrimary),
              Padding(
                  padding: EdgeInsets.only(right: 99.h),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 8.v),
                            child: Text("pedromartins@gmail.com",
                                style: theme.textTheme.bodyLarge)),
                        CustomImageView(
                            imagePath: ImageConstant.imgEdit,
                            height: 19.v,
                            width: 20.h,
                            margin: EdgeInsets.only(left: 10.h, bottom: 14.v))
                      ])),
              SizedBox(height: 20.v),
              Text("Contrato", style: CustomTextStyles.titleLargePrimary),
              SizedBox(height: 8.v),
              CustomOutlinedButton(
                  height: 29.v,
                  width: 81.h,
                  text: "PDF",
                  buttonTextStyle: CustomTextStyles.bodyLarge16_1),
              SizedBox(height: 44.v),
              CustomOutlinedButton(
                  height: 29.v,
                  width: 81.h,
                  text: "Log Out",
                  margin: EdgeInsets.only(right: 6.h),
                  buttonTextStyle: CustomTextStyles.bodyLarge16,
                  onPressed: () {
                    onTapLogOut(context);
                  },
                  alignment: Alignment.centerRight),
              SizedBox(height: 5.v)
            ]));
  }

  /// Navigates to the menuHamburguerScreen when the action is triggered.
  onTapImgMegaphone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.menuHamburguerScreen);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapLogOut(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
