import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';

class AjudasScreen extends StatefulWidget {
  const AjudasScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AjudasScreen> createState() => _AjudasScreen();
}

class _AjudasScreen extends State<AjudasScreen> {
  final TextEditingController custoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController faturaController = TextEditingController();

  @override
  void dispose() {
    custoController.dispose();
    descricaoController.dispose();
    faturaController.dispose();
    super.dispose();
  }

  final Servidor servidor = Servidor();

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
              child: Column(
                children: [
                  SizedBox(height: 10.v),
                  Text(
                    "Ajudas de Custo",
                    style: theme.textTheme.displayMedium,
                  ),
                  SizedBox(height: 20.v),
                  _buildInputSection(context),
                  SizedBox(height: 20.v),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            title: "Custo",
            controller: custoController,
            hintText: "Insira o custo",
          ),
          SizedBox(height: 10.v),
          _buildInputField(
            title: "Descrição",
            controller: descricaoController,
            hintText: "Insira a descrição",
          ),
          SizedBox(height: 10.v),
          _buildUploadButton(
            title: "Recibo",
            buttonText: "Upload Documento",
            onPressed: () {
              // Adicionar ação para upload do documento
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
          CustomTextFormField(
            controller: controller,
            hintText: hintText,
            // Removido o parâmetro keyboardType
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
    if (custoController.text.isEmpty) {
      final snackBar = SnackBar(
        content: Text('O campo "Custo" é obrigatório.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    try {
      await servidor.insertAjudasCusto(
        '2', // Substitua pelo ID real do usuário
        custoController.text,
        descricaoController.text.isNotEmpty ? descricaoController.text : "",
        faturaController.text.isNotEmpty ? faturaController.text : "",
      );

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
      print('Erro ao enviar ajudas de custo: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro ao enviar Ajudas de Custo!'),
            content: Text(
              'Ocorreu um erro ao tentar enviar as ajudas de custo. Verifique os dados e tente novamente.\nErro: $e',
              style: TextStyle(fontSize: 17),
            ),
            actions: <Widget>[
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
