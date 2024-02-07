import '../parcerias_pormenor_screen/widgets/contentcontentslider_item_widget.dart';
import '../parcerias_pormenor_screen/widgets/pageheaderslider_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore_for_file: must_be_immutable
class ParceriasPormenorScreen extends StatelessWidget {
  ParceriasPormenorScreen({Key? key}) : super(key: key);

  int sliderIndex = 1;

  int sliderIndex1 = 1;

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
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 30.v),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.h),
                                  child: Column(children: [
                                    _buildDoUtilizadorRow(context),
                                    SizedBox(height: 22.v),
                                    Text("Parcerias",
                                        style: theme.textTheme.displayMedium),
                                    SizedBox(height: 12.v),
                                    Container(
                                        margin: EdgeInsets.only(left: 1.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.h, vertical: 19.v),
                                        decoration: AppDecoration.outlineGray
                                            .copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder35),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              _buildPageHeaderSlider(context),
                                              SizedBox(height: 31.v),
                                              Container(
                                                  height: 8.v,
                                                  margin: EdgeInsets.only(
                                                      right: 1.h),
                                                  child: AnimatedSmoothIndicator(
                                                      activeIndex: sliderIndex,
                                                      count: 1,
                                                      axisDirection:
                                                          Axis.horizontal,
                                                      effect:
                                                          ScrollingDotsEffect(
                                                              spacing: 8,
                                                              activeDotColor:
                                                                  appTheme
                                                                      .green400,
                                                              dotColor: appTheme
                                                                  .gray200,
                                                              dotHeight: 8.v,
                                                              dotWidth: 8.h))),
                                              SizedBox(height: 16.v),
                                              _buildContentContentSlider(
                                                  context),
                                              SizedBox(height: 7.v)
                                            ]))
                                  ]))))
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
  Widget _buildPageHeaderSlider(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 1.h),
        child: CarouselSlider.builder(
            options: CarouselOptions(
                height: 337.v,
                initialPage: 0,
                autoPlay: true,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  sliderIndex = index;
                }),
            itemCount: 1,
            itemBuilder: (context, index, realIndex) {
              return PageheadersliderItemWidget();
            }));
  }

  /// Section Widget
  Widget _buildContentContentSlider(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 1.h),
        child: CarouselSlider.builder(
            options: CarouselOptions(
                height: 259.v,
                initialPage: 0,
                autoPlay: true,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  sliderIndex1 = index;
                }),
            itemCount: 1,
            itemBuilder: (context, index, realIndex) {
              return ContentcontentsliderItemWidget();
            }));
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }
}
