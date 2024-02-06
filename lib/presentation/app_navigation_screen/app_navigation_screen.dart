import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/core/app_export.dart';

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
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "pagina principal",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pagina Perfil",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Noticia",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pedido Ferias Two",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pedido Ferias One",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pedido Reuniao One",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Menu Hamburguer",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Registo",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "recuperar password email",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "recuperar password confirmar password",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pedido Horas",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Noticias",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pedido Ferias",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Despesas Viatura propria",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Ajudas",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Reunioes",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Pedido Reuniao",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Parcerias",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Parcerias Pormenor One",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Parcerias Pormenor",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "faltas",
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
  }) {
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
