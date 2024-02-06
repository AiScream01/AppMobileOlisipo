import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application10/presentation/login_screen/login_screen.dart';
import 'package:rui_pedro_s_application10/presentation/pagina_principal_screen/pagina_principal_screen.dart';
import 'package:rui_pedro_s_application10/presentation/pagina_perfil_screen/pagina_perfil_screen.dart';
import 'package:rui_pedro_s_application10/presentation/noticia_screen/noticia_screen.dart';
import 'package:rui_pedro_s_application10/presentation/pedido_ferias_two_screen/pedido_ferias_two_screen.dart';
import 'package:rui_pedro_s_application10/presentation/pedido_ferias_one_screen/pedido_ferias_one_screen.dart';
import 'package:rui_pedro_s_application10/presentation/pedido_reuniao_one_screen/pedido_reuniao_one_screen.dart';
import 'package:rui_pedro_s_application10/presentation/menu_hamburguer_screen/menu_hamburguer_screen.dart';
import 'package:rui_pedro_s_application10/presentation/registo_screen/registo_screen.dart';
import 'package:rui_pedro_s_application10/presentation/recuperar_password_email_screen/recuperar_password_email_screen.dart';
import 'package:rui_pedro_s_application10/presentation/recuperar_password_confirmar_password_screen/recuperar_password_confirmar_password_screen.dart';
import 'package:rui_pedro_s_application10/presentation/pedido_horas_screen/pedido_horas_screen.dart';
import 'package:rui_pedro_s_application10/presentation/noticias_screen/noticias_screen.dart';
import 'package:rui_pedro_s_application10/presentation/pedido_ferias_screen/pedido_ferias_screen.dart';
import 'package:rui_pedro_s_application10/presentation/despesas_viatura_propria_screen/despesas_viatura_propria_screen.dart';
import 'package:rui_pedro_s_application10/presentation/ajudas_screen/ajudas_screen.dart';
import 'package:rui_pedro_s_application10/presentation/reunioes_screen/reunioes_screen.dart';
import 'package:rui_pedro_s_application10/presentation/pedido_reuniao_screen/pedido_reuniao_screen.dart';
import 'package:rui_pedro_s_application10/presentation/parcerias_screen/parcerias_screen.dart';
import 'package:rui_pedro_s_application10/presentation/parcerias_pormenor_one_screen/parcerias_pormenor_one_screen.dart';
import 'package:rui_pedro_s_application10/presentation/parcerias_pormenor_screen/parcerias_pormenor_screen.dart';
import 'package:rui_pedro_s_application10/presentation/faltas_screen/faltas_screen.dart';
import 'package:rui_pedro_s_application10/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String paginaPrincipalScreen = '/pagina_principal_screen';

  static const String paginaPerfilScreen = '/pagina_perfil_screen';

  static const String noticiaScreen = '/noticia_screen';

  static const String pedidoFeriasTwoScreen = '/pedido_ferias_two_screen';

  static const String pedidoFeriasOneScreen = '/pedido_ferias_one_screen';

  static const String pedidoReuniaoOneScreen = '/pedido_reuniao_one_screen';

  static const String menuHamburguerScreen = '/menu_hamburguer_screen';

  static const String registoScreen = '/registo_screen';

  static const String recuperarPasswordEmailScreen =
      '/recuperar_password_email_screen';

  static const String recuperarPasswordConfirmarPasswordScreen =
      '/recuperar_password_confirmar_password_screen';

  static const String pedidoHorasScreen = '/pedido_horas_screen';

  static const String noticiasScreen = '/noticias_screen';

  static const String pedidoFeriasScreen = '/pedido_ferias_screen';

  static const String despesasViaturaPropriaScreen =
      '/despesas_viatura_propria_screen';

  static const String ajudasScreen = '/ajudas_screen';

  static const String reunioesScreen = '/reunioes_screen';

  static const String pedidoReuniaoScreen = '/pedido_reuniao_screen';

  static const String parceriasScreen = '/parcerias_screen';

  static const String parceriasPormenorOneScreen =
      '/parcerias_pormenor_one_screen';

  static const String parceriasPormenorScreen = '/parcerias_pormenor_screen';

  static const String faltasScreen = '/faltas_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    paginaPrincipalScreen: (context) => PaginaPrincipalScreen(),
    paginaPerfilScreen: (context) => PaginaPerfilScreen(),
    noticiaScreen: (context) => NoticiaScreen(),
    pedidoFeriasTwoScreen: (context) => PedidoFeriasTwoScreen(),
    pedidoFeriasOneScreen: (context) => PedidoFeriasOneScreen(),
    pedidoReuniaoOneScreen: (context) => PedidoReuniaoOneScreen(),
    menuHamburguerScreen: (context) => MenuHamburguerScreen(),
    registoScreen: (context) => RegistoScreen(),
    recuperarPasswordEmailScreen: (context) => RecuperarPasswordEmailScreen(),
    recuperarPasswordConfirmarPasswordScreen: (context) =>
        RecuperarPasswordConfirmarPasswordScreen(),
    pedidoHorasScreen: (context) => PedidoHorasScreen(),
    noticiasScreen: (context) => NoticiasScreen(),
    pedidoFeriasScreen: (context) => PedidoFeriasScreen(),
    despesasViaturaPropriaScreen: (context) => DespesasViaturaPropriaScreen(),
    ajudasScreen: (context) => AjudasScreen(),
    reunioesScreen: (context) => ReunioesScreen(),
    pedidoReuniaoScreen: (context) => PedidoReuniaoScreen(),
    parceriasScreen: (context) => ParceriasScreen(),
    parceriasPormenorOneScreen: (context) => ParceriasPormenorOneScreen(),
    parceriasPormenorScreen: (context) => ParceriasPormenorScreen(),
    faltasScreen: (context) => FaltasScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
