import '../pagina_principal_screen/widgets/contentslider_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore_for_file: must_be_immutable
class PaginaPrincipalScreen extends StatelessWidget {
  PaginaPrincipalScreen({Key? key}) : super(key: key);

  int sliderIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: AppBar(
          actions: [
            // Adicione o IconButton do perfil aqui
            IconButton(
              icon: Icon(Icons.account_circle), // Ícone do perfil
              iconSize: 40.0,
              onPressed: () {
                // Adicione a lógica que deseja executar ao clicar no ícone do perfil
                // Por exemplo, abrir a tela de perfil
                Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
              },
            ),
          ],
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text('Exemplo de Drawer'),
              ),
              ListTile(
                title: const Text('Ajudas de Custo'),
                onTap: () {
                   Navigator.pushNamed(context, AppRoutes.ajudasScreen);
                },
              ),
              ListTile(
                title: const Text('Despesas viatura própria'),
                onTap: () {
                   Navigator.pushNamed(context, AppRoutes.despesasViaturaPropriaScreen);
                },
              ),
              ListTile(
                title: const Text('Faltas'),
                onTap: () {
                   Navigator.pushNamed(context, AppRoutes.faltasScreen);
                },
              ),
              ListTile(
                title: const Text('Noticias'),
                onTap: () {
                   Navigator.pushNamed(context, AppRoutes.noticiaScreen);
                },
              ),
              ListTile(
                title: const Text('Parcerias'),
                onTap: () {
                   Navigator.pushNamed(context, AppRoutes.parceriasScreen);
                },
              ),
              ListTile(
                title: const Text('Ferias'),
                onTap: () {
                   Navigator.pushNamed(context, AppRoutes.pedidoFeriasScreen);
                },
              ),
              ListTile(
                title: const Text('Horas'),
                onTap: () {
                   Navigator.pushNamed(context, AppRoutes.pedidoHorasScreen);
                },
              ),
              ListTile(
                title: const Text('Reuniões'),
                onTap: () {
                   Navigator.pushNamed(context, AppRoutes.reunioesScreen);
                },
              ),
            ],
          ),
        ),
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
                      child: SingleChildScrollView(
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.h, right: 20.h, bottom: 80.v),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder30),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder30),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildUserImageRow(context),
                                        SizedBox(height: 34.v),
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("Conteúdo",
                                                      style: CustomTextStyles
                                                          .titleLargeInterSemiBold),
                                                  SizedBox(height: 13.v),
                                                  _buildContentSlider(context),
                                                  SizedBox(height: 27.v),
                                                  SizedBox(
                                                      height: 8.v,
                                                      child: AnimatedSmoothIndicator(
                                                          activeIndex:
                                                              sliderIndex,
                                                          count: 1,
                                                          axisDirection:
                                                              Axis.horizontal,
                                                          effect: ScrollingDotsEffect(
                                                              spacing: 8,
                                                              activeDotColor:
                                                                  appTheme
                                                                      .green400,
                                                              dotColor: appTheme
                                                                  .gray200,
                                                              dotHeight: 8.v,
                                                              dotWidth: 8.h))),
                                                  SizedBox(height: 13.v),
                                                  _buildUserStatusColumn(
                                                      context),
                                                  SizedBox(height: 16.v),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 41.h),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text("Pedido:",
                                                                style: CustomTextStyles
                                                                    .titleLargeInterMedium),
                                                            Text("Estado:",
                                                                style: CustomTextStyles
                                                                    .titleLargeInterMedium)
                                                          ])),
                                                  SizedBox(height: 6.v),
                                                  Divider(
                                                      indent: 16.h,
                                                      endIndent: 6.h),
                                                  SizedBox(height: 6.v),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3.h,
                                                          right: 1.h),
                                                      child: _buildRequestRow(
                                                          context,
                                                          pedidoDeReuniaoText:
                                                              "Pedido de férias",
                                                          reprovadoText:
                                                              "Aprovado")),
                                                  SizedBox(height: 12.v),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 4.h),
                                                      child: _buildRequestRow(
                                                          context,
                                                          pedidoDeReuniaoText:
                                                              "Pedido de reunião",
                                                          reprovadoText:
                                                              "Reprovado")),
                                                  SizedBox(height: 12.v),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3.h,
                                                          right: 1.h),
                                                      child: _buildRequestRow(
                                                          context,
                                                          pedidoDeReuniaoText:
                                                              "Pedido de ajudas",
                                                          reprovadoText:
                                                              "Pendente")),
                                                  SizedBox(height: 49.v)
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
                ]))));
  }

  /// Section Widget
  Widget _buildUserImageRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 5.h, right: 4.h),
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
  Widget _buildContentSlider(BuildContext context) {
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
              return ContentsliderItemWidget();
            }));
  }

  /// Section Widget
  Widget _buildUserStatusColumn(BuildContext context) {
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
  Widget _buildRequestRow(
    BuildContext context, {
    required String pedidoDeReuniaoText,
    required String reprovadoText,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 7.v),
        decoration: AppDecoration.fillGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: EdgeInsets.only(left: 4.h, bottom: 2.v),
              child: Text(pedidoDeReuniaoText,
                  style: CustomTextStyles.titleLargeInter
                      .copyWith(color: appTheme.black900))),
          Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Text(reprovadoText,
                  style: CustomTextStyles.titleLargeInterPrimaryContainer
                      .copyWith(color: theme.colorScheme.primaryContainer)))
        ]));
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }
}
