import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';

class MenuHamburguerScreen extends StatelessWidget {
  const MenuHamburguerScreen({Key? key}) : super(key: key);

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
                        EdgeInsets.symmetric(horizontal: 54.h, vertical: 43.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 43.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgOlisipoLogoblack,
                          height: 118.v,
                          width: 246.h),
                      SizedBox(height: 14.v),
                      Text("HOME",
                          style: CustomTextStyles.headlineLargePrimary),
                      SizedBox(height: 23.v),
                      GestureDetector(
                          onTap: () {
                            onTapTxtNOTCIAS(context);
                          },
                          child: Text("NOTÍCIAS",
                              style: theme.textTheme.headlineLarge)),
                      SizedBox(height: 30.v),
                      GestureDetector(
                          onTap: () {
                            onTapTxtAJUDASCUSTOS(context);
                          },
                          child: Text("AJUDAS CUSTOS",
                              style: theme.textTheme.headlineLarge)),
                      SizedBox(height: 27.v),
                      GestureDetector(
                          onTap: () {
                            onTapTxtHORAS(context);
                          },
                          child: Text("HORAS",
                              style: theme.textTheme.headlineLarge)),
                      SizedBox(height: 23.v),
                      GestureDetector(
                          onTap: () {
                            onTapTxtFRIAS(context);
                          },
                          child: Text("FÉRIAS",
                              style: theme.textTheme.headlineLarge)),
                      SizedBox(height: 27.v),
                      GestureDetector(
                          onTap: () {
                            onTapTxtREUNIES(context);
                          },
                          child: Text("REUNIÕES",
                              style: theme.textTheme.headlineLarge)),
                      SizedBox(height: 30.v),
                      GestureDetector(
                          onTap: () {
                            onTapTxtPARCERIAS(context);
                          },
                          child: Text("PARCERIAS",
                              style: theme.textTheme.headlineLarge)),
                      SizedBox(height: 23.v),
                      GestureDetector(
                          onTap: () {
                            onTapTxtVIATURAPRPRIA(context);
                          },
                          child: Text("VIATURA PRÓPRIA",
                              style: theme.textTheme.headlineLarge))
                    ])))));
  }

  /// Navigates to the noticiasScreen when the action is triggered.
  onTapTxtNOTCIAS(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.noticiasScreen);
  }

  /// Navigates to the ajudasScreen when the action is triggered.
  onTapTxtAJUDASCUSTOS(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.ajudasScreen);
  }

  /// Navigates to the pedidoHorasScreen when the action is triggered.
  onTapTxtHORAS(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.pedidoHorasScreen);
  }

  /// Navigates to the pedidoFeriasScreen when the action is triggered.
  onTapTxtFRIAS(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.pedidoFeriasScreen);
  }

  /// Navigates to the reunioesScreen when the action is triggered.
  onTapTxtREUNIES(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.reunioesScreen);
  }

  /// Navigates to the parceriasScreen when the action is triggered.
  onTapTxtPARCERIAS(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.parceriasScreen);
  }

  /// Navigates to the parceriasScreen when the action is triggered.
  onTapTxtVIATURAPRPRIA(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.parceriasScreen);
  }
}
