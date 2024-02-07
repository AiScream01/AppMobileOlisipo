import '../reunioes_screen/widgets/meetingcardlist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';

class ReunioesScreen extends StatelessWidget {
  const ReunioesScreen({Key? key}) : super(key: key);

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
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 23.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 7.v),
                      _buildDoUtilizadorRow(context),
                      SizedBox(height: 9.v),
                      Text("Reuniões", style: theme.textTheme.displayMedium),
                      SizedBox(height: 12.v),
                      Container(
                          margin: EdgeInsets.only(left: 1.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 23.h, vertical: 80.v),
                          decoration: AppDecoration.outlineGray.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder35),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Próximas reuniões",
                                    style: CustomTextStyles.titleLargeBold),
                                SizedBox(height: 21.v),
                                _buildMeetingCardList(context),
                                SizedBox(height: 89.v),
                                CustomElevatedButton(
                                    height: 51.v,
                                    text: "Faça um pedido de reunião",
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.h),
                                    buttonStyle: CustomButtonStyles.fillPrimary,
                                    buttonTextStyle:
                                        theme.textTheme.titleMedium!,
                                    onPressed: () {
                                      onTapFaaUmPedidoDeReunio(context);
                                    }),
                                SizedBox(height: 52.v)
                              ]))
                    ])))));
  }

  /// Section Widget
  Widget _buildDoUtilizadorRow(BuildContext context) {
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
              margin: EdgeInsets.only(top: 12.v, bottom: 13.v))
        ]));
  }

  /// Section Widget
  Widget _buildMeetingCardList(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 4.h, right: 5.h),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 20.v);
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return MeetingcardlistItemWidget();
            }));
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }

  /// Navigates to the pedidoReuniaoScreen when the action is triggered.
  onTapFaaUmPedidoDeReunio(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.pedidoReuniaoScreen);
  }
}
