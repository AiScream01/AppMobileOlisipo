import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';
import 'package:rui_pedro_s_application10/widgets/app_bar/appbar_leading_image.dart';
import 'package:rui_pedro_s_application10/widgets/app_bar/appbar_trailing_image.dart';
import 'package:rui_pedro_s_application10/widgets/app_bar/custom_app_bar.dart';
import 'package:rui_pedro_s_application10/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application10/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application10/presentation/push_notification_dialog/push_notification_dialog.dart';

// ignore_for_file: must_be_immutable
class PedidoReuniaoOneScreen extends StatelessWidget {
  PedidoReuniaoOneScreen({Key? key}) : super(key: key);

  List<DateTime?> selectedDatesFromCalendar1 = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: _buildAppBar(context),
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
                        EdgeInsets.symmetric(horizontal: 15.h, vertical: 14.v),
                    child: Column(children: [
                      Text("Pedido de reunião",
                          style: theme.textTheme.displayMedium),
                      SizedBox(height: 13.v),
                      SizedBox(
                          height: 611.v,
                          width: 375.h,
                          child: Stack(alignment: Alignment.center, children: [
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                    margin: EdgeInsets.only(right: 5.h),
                                    padding: EdgeInsets.all(23.h),
                                    decoration: AppDecoration.outlineGray
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder35),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 27.v),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 11.h),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 14.v),
                                                        child: Text("Com",
                                                            style: theme
                                                                .textTheme
                                                                .titleLarge)),
                                                    Container(
                                                        width: 193.h,
                                                        margin: EdgeInsets.only(
                                                            top: 10.v),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8.h,
                                                                vertical: 1.v),
                                                        decoration: AppDecoration
                                                            .outlinePrimary1
                                                            .copyWith(
                                                                borderRadius:
                                                                    BorderRadiusStyle
                                                                        .roundedBorder8),
                                                        child: Text(
                                                            "Recursos Humanos",
                                                            style: theme
                                                                .textTheme
                                                                .titleLarge))
                                                  ])),
                                          Spacer(),
                                          CustomOutlinedButton(
                                              width: 144.h,
                                              text: "Enviar",
                                              onPressed: () {
                                                onTapEnviar(context);
                                              })
                                        ]))),
                            _buildPedidoReuniaoOne(context)
                          ])),
                      SizedBox(height: 5.v)
                    ])))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 70.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgDoUtilizador,
            margin: EdgeInsets.only(left: 25.h, top: 5.v, bottom: 5.v),
            onTap: () {
              onTapDoUtilizador(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgMegaphone,
              margin: EdgeInsets.fromLTRB(25.h, 17.v, 25.h, 18.v),
              onTap: () {
                onTapMegaphone(context);
              })
        ]);
  }

  /// Section Widget
  Widget _buildPedidoReuniaoOne(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: SizedBox(
            height: 402.v,
            width: 375.h,
            child: Stack(alignment: Alignment.center, children: [
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      height: 40.v,
                      width: 67.h,
                      margin: EdgeInsets.only(right: 34.h, bottom: 11.v),
                      decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(7.h),
                          border: Border.all(
                              color: theme.colorScheme.primary, width: 1.h),
                          boxShadow: [
                            BoxShadow(
                                color: appTheme.black900.withOpacity(0.25),
                                spreadRadius: 2.h,
                                blurRadius: 2.h,
                                offset: Offset(0, 4))
                          ]))),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 33.h, vertical: 34.v),
                      decoration: AppDecoration.outlinePrimary.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder30),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(height: 5.v),
                        SizedBox(
                            height: 250.v,
                            width: 300.h,
                            child: CalendarDatePicker2(
                                config: CalendarDatePicker2Config(
                                    calendarType:
                                        CalendarDatePicker2Type.single,
                                    firstDate:
                                        DateTime(DateTime.now().year - 5),
                                    lastDate: DateTime(DateTime.now().year + 5),
                                    centerAlignModePicker: true,
                                    firstDayOfWeek: 0,
                                    controlsHeight: 22,
                                    weekdayLabelTextStyle: TextStyle(
                                        color: theme.colorScheme.primary,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400),
                                    controlsTextStyle: TextStyle(
                                        color: appTheme.black900,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700),
                                    dayTextStyle: TextStyle(
                                        color: appTheme.gray700,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500),
                                    disabledDayTextStyle: TextStyle(
                                        color: appTheme.gray700,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500),
                                    weekdayLabels: [
                                      "S",
                                      "M",
                                      "T",
                                      "W",
                                      "T",
                                      "F",
                                      "S"
                                    ]),
                                value: selectedDatesFromCalendar1,
                                onValueChanged: (dates) {})),
                        SizedBox(height: 36.v),
                        Padding(
                            padding: EdgeInsets.only(left: 12.h, right: 7.h),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomElevatedButton(
                                      width: 100.h,
                                      text: "Cancelar",
                                      buttonStyle: CustomButtonStyles
                                          .fillOnPrimaryContainer,
                                      buttonTextStyle:
                                          CustomTextStyles.titleSmallBlack900),
                                  CustomElevatedButton(
                                      width: 100.h,
                                      text: "Done",
                                      buttonStyle:
                                          CustomButtonStyles.fillPrimary,
                                      buttonTextStyle: CustomTextStyles
                                          .titleSmallOnPrimaryContainer)
                                ]))
                      ])))
            ])));
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }

  /// Navigates to the menuHamburguerScreen when the action is triggered.
  onTapMegaphone(BuildContext context) {
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
