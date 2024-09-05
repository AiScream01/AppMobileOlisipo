import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
// ignore: unused_import
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart'; // Certifique-se de ter isso importado
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart'; // Certifique-se de que Servidor é importado
import 'package:rui_pedro_s_application11/servidor/basedados.dart'; // Certifique-se de que Basededados é importado
import 'package:shared_preferences/shared_preferences.dart'; // Certifique-se de importar o pacote

class DespesasViaturaPropriaScreen extends StatefulWidget {
  const DespesasViaturaPropriaScreen({Key? key}) : super(key: key);

  @override
  _DespesasViaturaPropriaScreenState createState() =>
      _DespesasViaturaPropriaScreenState();
}

class _DespesasViaturaPropriaScreenState
    extends State<DespesasViaturaPropriaScreen> {
  final TextEditingController partidaController = TextEditingController();
  final TextEditingController chegadaController = TextEditingController();
  final TextEditingController kmController = TextEditingController();
  final TextEditingController portagensController = TextEditingController();
  final TextEditingController comprovativoController = TextEditingController();

  final Servidor servidor = Servidor();
  final Basededados bd = Basededados();

  @override
  void dispose() {
    partidaController.dispose();
    chegadaController.dispose();
    kmController.dispose();
    portagensController.dispose();
    comprovativoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                title: const Text('Notícias'),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.noticiasScreen);
                },
              ),
              ListTile(
                title: const Text('Parcerias'),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.parceriasScreen);
                },
              ),
              ListTile(
                title: const Text('Férias'),
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
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageConstant.imgLogin),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10.v),
                      Text(
                        "Despesas Viatura Própria",
                        style: theme.textTheme.displayMedium,
                      ),
                      SizedBox(height: 20.v),
                      _buildInputSection(context),
                      SizedBox(height: 20.v),
                      _buildEnviarButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 21.v),
      decoration: BoxDecoration(
        color: Colors.white, // Fundo branco para a caixa de entrada
        borderRadius: BorderRadius.circular(35), // Bordas arredondadas
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            title: "Ponto de partida",
            controller: partidaController,
            hintText: "Insira o ponto de partida",
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 10.v),
          _buildInputField(
            title: "Ponto de chegada",
            controller: chegadaController,
            hintText: "Insira o ponto de chegada",
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 10.v),
          _buildInputField(
            title: "Kilómetros",
            controller: kmController,
            hintText: "Insira a distância em km",
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 10.v),
          _buildInputField(
            title: "Portagens",
            controller: portagensController,
            hintText: "Insira o custo das portagens",
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 10.v),
          _buildUploadButton(
            title: "Comprovativo",
            buttonText: "Adicionar PDF",
            onPressed: () {
              // Adicionar ação para adicionar PDF
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String title,
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 5.v),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.transparent, // Cor do fundo dos campos de input
            ),
            keyboardType: keyboardType,
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton({
    required String title,
    required String buttonText,
    required void Function() onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 5.v),
          CustomOutlinedButton(
            height: 32.v,
            width: double.infinity,
            text: buttonText,
            onPressed: onPressed,
            buttonStyle: CustomButtonStyles.outlinePrimary,
            buttonTextStyle: theme.textTheme.titleLarge!,
          ),
        ],
      ),
    );
  }

  Widget _buildEnviarButton(BuildContext context) {
    return CustomElevatedButton(
      width: double.infinity,
      text: "Enviar",
      onPressed: () {
        onTapEnviarButton(context);
      },
    );
  }

  void onTapEnviarButton(BuildContext context) async {
    try {
      double km = double.parse(kmController.text);
      String pontoPartida = partidaController.text;
      String pontoChegada = chegadaController.text;
      double precoPortagens = double.parse(portagensController.text);
      String comprovativo = comprovativoController.text.isNotEmpty
          ? comprovativoController.text
          : '';

      final prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser'); // Suponho que o idUser tenha sido salvo como String
      String estado = 'pendente'; // Estado padrão

        await bd.inserirDespesaViaturaPessoal([
          (
            pontoPartida.toString(),
            pontoChegada.toString(),
            km.toString(),
            comprovativo.toString(),
            precoPortagens.toString(),
            estado // Estado inicial como 'pendente'
          )
        ]);

      // Envia os dados para o servidor
      await servidor.insertDespesasViaturaPessoal(
        idUser.toString(),
        km,
        pontoPartida,
        pontoChegada,
        precoPortagens,
        comprovativo,
      );

      // Exibe o diálogo de notificação de sucesso
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: PushNotificationDialog(),
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.only(left: 0),
        ),
      );
    } catch (e) {
      print('Erro ao enviar despesas: $e');
      // Exibe o diálogo de erro
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Ocorreu um erro ao enviar as despesas. Erro: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
