import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';

class NoticiasScreen extends StatelessWidget {
  const NoticiasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:
              Colors.transparent, // Transparente para que o fundo seja visível
          elevation: 0, // Remove a sombra da AppBar
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 40.0,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text('Menu de Navegação'),
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
                  Navigator.pushNamed(
                      context, AppRoutes.despesasViaturaPropriaScreen);
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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            boxShadow: [
              BoxShadow(
                color: appTheme.black900.withOpacity(0.3),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(10, 10),
              )
            ],
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: kToolbarHeight +
                          20.v), // Adiciona espaçamento equivalente à altura da AppBar + extra padding
                  Text("Notícias", style: theme.textTheme.displayMedium),
                  SizedBox(height: 20.v),
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.35, // 35% da altura da tela
                    width: MediaQuery.of(context).size.width *
                        0.9, // 90% da largura da tela
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimaryContainer,
                      borderRadius: BorderRadius.circular(35.h),
                      border: Border.all(color: appTheme.gray20001, width: 1.h),
                      boxShadow: [
                        BoxShadow(
                          color: appTheme.black900.withOpacity(0.2),
                          spreadRadius: 2.h,
                          blurRadius: 2.h,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        onTapTxtEstetextovaiconter4(context);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.h),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "Este texto vai conter a descrição da notícia que está acima.",
                                style: CustomTextStyles.titleLargeff000000,
                              ),
                              TextSpan(text: " "),
                              TextSpan(
                                text: "Ver mais",
                                style: theme.textTheme.titleSmall,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.v),
                  _buildEightyTwoRow(context),
                  SizedBox(height: 17.v),
                  _buildViewRow(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildEightyTwoRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                0.15, // 15% da altura da tela
            width: MediaQuery.of(context).size.width *
                0.3, // 30% da largura da tela
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimaryContainer,
              borderRadius: BorderRadius.circular(20.h),
              border: Border.all(color: appTheme.gray20001, width: 1.h),
              boxShadow: [
                BoxShadow(
                  color: appTheme.black900.withOpacity(0.2),
                  spreadRadius: 2.h,
                  blurRadius: 2.h,
                  offset: Offset(0, 4),
                )
              ],
            ),
          ),
          SizedBox(width: 17.h),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 9.v, bottom: 23.v),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "Este texto vai conter a descrição da notícia que está acima.\n",
                      style: CustomTextStyles.titleMediumNunitoff000000,
                    ),
                    TextSpan(
                      text: "Ver mais",
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildViewRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                0.15, // 15% da altura da tela
            width: MediaQuery.of(context).size.width *
                0.3, // 30% da largura da tela
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimaryContainer,
              borderRadius: BorderRadius.circular(20.h),
              border: Border.all(color: appTheme.gray20001, width: 1.h),
              boxShadow: [
                BoxShadow(
                  color: appTheme.black900.withOpacity(0.2),
                  spreadRadius: 2.h,
                  blurRadius: 2.h,
                  offset: Offset(0, 4),
                )
              ],
            ),
          ),
          SizedBox(width: 17.h),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 9.v, bottom: 23.v),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "Este texto vai conter a descrição da notícia que está acima.\n",
                      style: CustomTextStyles.titleMediumNunitoff000000,
                    ),
                    TextSpan(
                      text: "Ver mais",
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the noticiaScreen when the action is triggered.
  onTapTxtEstetextovaiconter4(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.noticiaScreen);
  }
}
