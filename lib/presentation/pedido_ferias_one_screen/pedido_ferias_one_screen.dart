import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';
import 'package:rui_pedro_s_application10/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application10/widgets/custom_outlined_button.dart';

// ignore_for_file: must_be_immutable
class PedidoFeriasOneScreen extends StatelessWidget {
  PedidoFeriasOneScreen({Key? key}) : super(key: key);

  List<DateTime?> selectedDatesFromCalendar1 = [];

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
                        EdgeInsets.symmetric(horizontal: 15.h, vertical: 24.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 6.v),
                      _buildUserProfile(context),
                      SizedBox(height: 12.v),
                      Text("Férias", style: theme.textTheme.displayMedium),
                      SizedBox(height: 20.v),
                      SizedBox(
                          height: 613.v,
                          width: 375.h,
                          child: Stack(alignment: Alignment.center, children: [
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    height: 40.v,
                                    width: 67.h,
                                    margin: EdgeInsets.only(
                                        right: 34.h, bottom: 108.v),
                                    decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        borderRadius:
                                            BorderRadius.circular(7.h),
                                        border: Border.all(
                                            color: theme.colorScheme.primary,
                                            width: 1.h),
                                        boxShadow: [
                                          BoxShadow(
                                              color: appTheme.black900
                                                  .withOpacity(0.25),
                                              spreadRadius: 2.h,
                                              blurRadius: 2.h,
                                              offset: Offset(0, 4))
                                        ]))),
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                    margin: EdgeInsets.only(right: 5.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 108.h, vertical: 26.v),
                                    decoration: AppDecoration.outlineGray
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder35),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Spacer(),
                                          CustomOutlinedButton(
                                              text: "Enviar",
                                              margin:
                                                  EdgeInsets.only(right: 8.h))
                                        ]))),
                            _buildDatePicker(context)
                          ]))
                    ])))));
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
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
              margin: EdgeInsets.only(top: 12.v, bottom: 13.v),
              onTap: () {
                onTapImgMegaphone(context);
              })
        ]));
  }

  /// Section Widget
  Widget _buildDatePicker(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.only(top: 36.v),
            padding: EdgeInsets.symmetric(horizontal: 33.h, vertical: 34.v),
            decoration: AppDecoration.outlinePrimary
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder30),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(height: 5.v),
              SizedBox(
                  height: 250.v,
                  width: 300.h,
                  child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.single,
                          firstDate: DateTime(DateTime.now().year - 5),
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
                          weekdayLabels: ["S", "M", "T", "W", "T", "F", "S"]),
                      value: selectedDatesFromCalendar1,
                      onValueChanged: (dates) {})),
              SizedBox(height: 36.v),
              Padding(
                  padding: EdgeInsets.only(left: 11.h, right: 7.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomElevatedButton(
                            width: 100.h,
                            text: "Cancelar",
                            buttonStyle:
                                CustomButtonStyles.fillOnPrimaryContainer,
                            buttonTextStyle:
                                CustomTextStyles.titleSmallBlack900),
                        CustomElevatedButton(
                            width: 100.h,
                            text: "Done",
                            buttonStyle: CustomButtonStyles.fillPrimary,
                            buttonTextStyle:
                                CustomTextStyles.titleSmallOnPrimaryContainer)
                      ]))
            ])));
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }

  /// Navigates to the menuHamburguerScreen when the action is triggered.
  onTapImgMegaphone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.menuHamburguerScreen);
  }
}
