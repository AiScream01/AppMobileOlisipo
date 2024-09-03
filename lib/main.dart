import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import './servidor/basedados.dart';
import './servidor/servidor.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bd = Basededados();
    var ser = Servidor();
    const idUser = "2";

    void servidor_basededados() {
      ser.getDadosServidor(idUser);
      ser.getNoticiasEParcerias();
      //bd.criatabelaParcerias();
      //bd.criarTabelaNoticias();
      //bd.criatabelaUtilizadores();
      //bd.criarTabelaReunioes();
      //bd.criarTabelaAjudasCusto();
      //bd.criarTabelaHoras();
      //bd.criarTabelaDespesasViaturaPessoal();
      //bd.criarTabelaFaltas();
    }

    servidor_basededados();

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'rui_pedro_s_application11',
          debugShowCheckedModeBanner: false,
          //initialRoute: AppRoutes.loginScreen,
          initialRoute: AppRoutes.paginaPrincipalScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
