import '../pagina_principal_screen/widgets/slider_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';
import 'package:rui_pedro_s_application10/widgets/app_bar/appbar_leading_image.dart';
import 'package:rui_pedro_s_application10/widgets/app_bar/appbar_trailing_image.dart';
import 'package:rui_pedro_s_application10/widgets/app_bar/custom_app_bar.dart';
import 'package:rui_pedro_s_application10/widgets/custom_search_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore_for_file: must_be_immutable
class PaginaPrincipalScreen extends StatelessWidget {
  PaginaPrincipalScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  int sliderIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                height: SizeUtils.height,
                width: double.maxFinite,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgFundo,
                      height: 893.v,
                      width: 411.h,
                      radius: BorderRadius.circular(30.h),
                      alignment: Alignment.bottomCenter),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(height: 30.v),
                        _buildAppBar(context),
                        SizedBox(height: 34.v),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20.h, right: 20.h, bottom: 80.v),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder30),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder30),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.h,
                                                      vertical: 11.v),
                                                  decoration: AppDecoration
                                                      .outlineGray
                                                      .copyWith(
                                                          borderRadius:
                                                              BorderRadiusStyle
                                                                  .roundedBorder35),
                                                  child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 9.h,
                                                                    right: 8.h),
                                                            child: CustomSearchView(
                                                                controller:
                                                                    searchController,
                                                                hintText:
                                                                    "Search")),
                                                        SizedBox(height: 11.v),
                                                        Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: 21
                                                                            .h),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Text(
                                                                          "Conteúdo",
                                                                          style:
                                                                              CustomTextStyles.titleLargeInterSemiBold),
                                                                      Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 71
                                                                                  .h,
                                                                              top: 3
                                                                                  .v),
                                                                          child: Text(
                                                                              "Filtro",
                                                                              style: CustomTextStyles.titleMediumGreen400))
                                                                    ]))),
                                                        SizedBox(height: 9.v),
                                                        _buildSlider(context),
                                                        SizedBox(height: 17.v),
                                                        SizedBox(
                                                            height: 8.v,
                                                            child: AnimatedSmoothIndicator(
                                                                activeIndex:
                                                                    sliderIndex,
                                                                count: 1,
                                                                axisDirection: Axis
                                                                    .horizontal,
                                                                effect: ScrollingDotsEffect(
                                                                    spacing: 8,
                                                                    activeDotColor:
                                                                        appTheme
                                                                            .green400,
                                                                    dotColor:
                                                                        appTheme
                                                                            .gray200,
                                                                    dotHeight:
                                                                        8.v,
                                                                    dotWidth:
                                                                        8.h))),
                                                        SizedBox(height: 15.v),
                                                        _buildColumnFour(
                                                            context),
                                                        SizedBox(height: 16.v),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        41.h),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "Pedido:",
                                                                      style: CustomTextStyles
                                                                          .titleLargeInterMedium),
                                                                  Text(
                                                                      "Estado:",
                                                                      style: CustomTextStyles
                                                                          .titleLargeInterMedium)
                                                                ])),
                                                        SizedBox(height: 6.v),
                                                        Divider(
                                                            indent: 16.h,
                                                            endIndent: 6.h),
                                                        SizedBox(height: 6.v),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3.h,
                                                                    right: 1.h),
                                                            child: _buildRowNine(
                                                                context,
                                                                dynamicText1:
                                                                    "Pedido de férias",
                                                                dynamicText2:
                                                                    "Aprovado")),
                                                        SizedBox(height: 12.v),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 4.h),
                                                            child: _buildRowNine(
                                                                context,
                                                                dynamicText1:
                                                                    "Pedido de reunião",
                                                                dynamicText2:
                                                                    "Reprovado")),
                                                        SizedBox(height: 12.v),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3.h,
                                                                    right: 1.h),
                                                            child: _buildRowNine(
                                                                context,
                                                                dynamicText1:
                                                                    "Pedido de ajudas",
                                                                dynamicText2:
                                                                    "Pendente"))
                                                      ])),
                                              SizedBox(height: 12.v),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.h, right: 37.h),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Pedido de Contas",
                                                            style: CustomTextStyles
                                                                .titleLargeInter),
                                                        Text("Enviado",
                                                            style: CustomTextStyles
                                                                .titleLargeInterBluegray700)
                                                      ]))
                                            ])))))
                      ]))
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 45.v,
        leadingWidth: 70.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgDoUtilizador,
            margin: EdgeInsets.only(left: 25.h),
            onTap: () {
              onTapDoUtilizador(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgMegaphone,
              margin: EdgeInsets.fromLTRB(25.h, 12.v, 25.h, 13.v),
              onTap: () {
                onTapMegaphone(context);
              })
        ]);
  }

  /// Section Widget
  Widget _buildSlider(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.h),
        child: CarouselSlider.builder(
            options: CarouselOptions(
                height: 240.v,
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
              return SliderItemWidget();
            }));
  }

  /// Section Widget
  Widget _buildColumnFour(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 3.h, right: 1.h),
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v),
        decoration: AppDecoration.fillLightGreenA
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 4.v),
              Text("Estado das suas submissões/pedidos",
                  style: CustomTextStyles.titleMediumNunitoOnPrimaryContainer)
            ]));
  }

  /// Common widget
  Widget _buildRowNine(
    BuildContext context, {
    required String dynamicText1,
    required String dynamicText2,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 7.v),
        decoration: AppDecoration.fillGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: EdgeInsets.only(left: 4.h, bottom: 2.v),
              child: Text(dynamicText1,
                  style: CustomTextStyles.titleLargeInter
                      .copyWith(color: appTheme.black900))),
          Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Text(dynamicText2,
                  style: CustomTextStyles.titleLargeInterPrimaryContainer
                      .copyWith(color: theme.colorScheme.primaryContainer)))
        ]));
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }

  /// Navigates to the menuHamburguerScreen when the action is triggered.
  onTapMegaphone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.menuHamburguerScreen);
  }
}
