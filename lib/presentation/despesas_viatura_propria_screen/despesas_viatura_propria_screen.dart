import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  File? comprovativo; // Variável para armazenar o ficheiro PDF

  final Servidor servidor = Servidor();
  final Basededados bd = Basededados();

  @override
  void dispose() {
    partidaController.dispose();
    chegadaController.dispose();
    kmController.dispose();
    portagensController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.black87),
              iconSize: 40.0,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
              },
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu, color: Colors.black87),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text('Menu de Navegação',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      "Despesas Viatura Própria",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 3.0,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildInputSection(context),
                  SizedBox(height: 20.0),
                  _buildEnviarButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 21.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            title: "Ponto de partida",
            controller: partidaController,
            hintText: "Insira o ponto de partida",
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 10.0),
          _buildInputField(
            title: "Ponto de chegada",
            controller: chegadaController,
            hintText: "Insira o ponto de chegada",
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 10.0),
          _buildInputField(
            title: "Kilómetros",
            controller: kmController,
            hintText: "Insira a distância em km",
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 10.0),
          _buildInputField(
            title: "Portagens",
            controller: portagensController,
            hintText: "Insira o custo das portagens",
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 10.0),
          _buildUploadButton(
            title: "Comprovativo",
            buttonText: "Upload de documento",
            onPressed: () async {
              await _pickComprovativo();
            },
          ),
          if (comprovativo != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Arquivo: ${comprovativo?.path.split('/').last}',
                style: TextStyle(color: Colors.green),
              ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5.0),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  Widget _buildUploadButton({
    required String title,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 5.0),
          CustomOutlinedButton(
            height: 32.0,
            width: double.infinity,
            text: buttonText,
            onPressed: onPressed,
            buttonStyle: CustomButtonStyles.outlinePrimary,
            buttonTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickComprovativo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        comprovativo = File(result.files.single.path!);
      });
    } else {
      print('Nenhum arquivo selecionado');
    }
  }

  Future<void> _sendData() async {
    // Coletar os dados do formulário
    final pontoPartida = partidaController.text;
    final pontoChegada = chegadaController.text;
    final km = kmController.text;
    final portagens = portagensController.text;

    // Renomear variável para evitar conflito
    final comprovativoPath =
        comprovativo != null ? comprovativo!.path.split('/').last : "";

    // Preparar os dados para inserção na base de dados local
    final despesaViaturaData = [
      (pontoPartida, pontoChegada, km, comprovativoPath, portagens, 'pendente')
    ];

    try {
      // Inserir dados na base de dados local
      await bd.inserirDespesaViaturaPessoal(despesaViaturaData);

      // Exibir uma mensagem de sucesso ou realizar outra ação
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content:
              PushNotificationDialog(), // Substitua pelo seu diálogo de sucesso
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.only(left: 0),
        ),
      );
    } catch (e) {
      print('Erro ao enviar despesa: $e');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro ao enviar despesa!'),
            content: Text(
                'Ocorreu um erro ao enviar a despesa. Tente novamente mais tarde.'),
            actions: [
              TextButton(
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildEnviarButton(BuildContext context) {
    return CustomElevatedButton(
      width: double.infinity,
      text: "Enviar",
      onPressed: () {
        _sendData(); // Chama a função que envia os dados
      },
    );
  }
}
