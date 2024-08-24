import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Login",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.loginScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "pagina principal",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.paginaPrincipalScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Noticia",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.noticiaScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Registo",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.registoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "recuperar password email",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.recuperarPasswordEmailScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "recuperar password confirmar password",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context,
                              AppRoutes
                                  .recuperarPasswordConfirmarPasswordScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Noticias",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.noticiasScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pedido Ferias",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.pedidoFeriasScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Despesas Viatura propria",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.despesasViaturaPropriaScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Ajudas",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.ajudasScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Reunioes",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.reunioesScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pedido Reuniao",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.pedidoReuniaoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Parcerias",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.parceriasScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Parcerias Pormenor One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.parceriasPormenorOneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "faltas",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.faltasScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pedido Horas",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.pedidoHorasScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pagina Perfil",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.paginaPerfilScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
