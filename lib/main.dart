import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import './servidor/basedados.dart';
import './servidor/servidor.dart';
import 'package:shared_preferences/shared_preferences.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Recuperar o idUser armazenado
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idUser = prefs.getString('idUser');

  // Define o tema padrão
  ThemeHelper().changeTheme('primary');

  runApp(MyApp(idUser: idUser));
}

class MyApp extends StatelessWidget {
  final String? idUser;

  MyApp({this.idUser});

  @override
  Widget build(BuildContext context) {
    var bd = Basededados();
    var ser = Servidor();
    //bd.criatabelaUtilizadores();

    // Função que conecta ao servidor ou à base de dados local
    Future<void> servidor_basededados() async {
      if (idUser != null && idUser!.isNotEmpty) {
        print('Conectando ao servidor com idUser: $idUser');
        print('PASSEI AQUIIII');
        try {
          // Carregar dados do servidor
          await ser.getDadosServidor(idUser!);
          await ser.getNoticiasEParcerias();
          print('Carregar dados do servidor');
        } catch (e) {
          print('Erro ao buscar dados do servidor: $e');
        }
      } else {
        print('Nenhum idUser encontrado. Redirecionando para o login.');
      }

      //bd.criatabelaParcerias();
      //bd.criarTabelaNoticias();

      //bd.apagartabelaUtilizadores();
      //bd.criarTabelaReunioes();
      //bd.criarTabelaAjudasCusto();
      //bd.criarTabelaHoras();
      //bd.criarTabelaDespesasViaturaPessoal();
      //bd.criarTabelaFaltas();
      //bd.criatabelaFerias();
      //bd.apagartabelaFerias();
      //bd.CriarTabelaRecibosVencimento();
      //bd.apagartabelaFaltas();
    }

    // Chamar a função assíncrona, sem bloquear a UI
    servidor_basededados();

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'Olisipo App',
          debugShowCheckedModeBanner: false,
          initialRoute: idUser != null && idUser!.isNotEmpty
              ? AppRoutes
                  .paginaPrincipalScreen // Vai para a página principal se o idUser estiver armazenado
              : AppRoutes.loginScreen, // Senão, vai para o login
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
