import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa shared_preferences
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'dart:convert'; // Adicione esta importação no início do arquivo

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Servidor servidor = Servidor();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimaryContainer,
              image: DecorationImage(
                image: AssetImage(ImageConstant.imgLogin),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 27),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 48),
                  CustomImageView(
                    imagePath: ImageConstant.imgOlisipoLogoblack,
                    height: 118,
                    width: 270,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 33),
                  _buildLoginForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Login", style: theme.textTheme.displaySmall),
          SizedBox(height: 25),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Email", style: theme.textTheme.bodyMedium),
          ),
          SizedBox(height: 2),
          CustomTextFormField(
            controller: emailController,
          ),
          SizedBox(height: 18),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Password", style: theme.textTheme.bodyMedium),
          ),
          SizedBox(height: 2),
          CustomTextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            obscureText: true,
          ),
          SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                onTapTxtEsqueceusedapassword(context);
              },
              child: Text(
                "Esqueceu-se da password?",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          CustomElevatedButton(
              height: 60,
              width: 155,
              text: "Login",
              onPressed: () async {
                try {
                  // Chama o método de login e obtém o id do usuário
                  var idUser = await servidor.login(
                    emailController.text,
                    passwordController.text,
                  );
                  print('Conectando ao servidor com idUser: $idUser');

                  // Salva o idUser nas SharedPreferences
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('idUser', idUser);

                  // Atualize os dados do perfil aqui
                  await updateProfileData(idUser);

                  // Log para verificar o idUser
                  print('Utilizador logado com id: $idUser');

                  // Redireciona para a tela principal
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.paginaPrincipalScreen,
                  );
                } catch (e) {
                  // Exibe uma mensagem de erro apropriada
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()), // Exibe o erro completo
                    ),
                  );
                }
              }),
          SizedBox(height: 19),
          GestureDetector(
            onTap: () {
              onTapTxtNovoAquiFazO(context);
            },
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTapTxtEsqueceusedapassword(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recuperarPasswordEmailScreen);
  }

  void onTapTxtNovoAquiFazO(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registoScreen);
  }

  Future<void> updateProfileData(String idUser) async {
    try {
      // Busca os dados do servidor
      await servidor.getDadosServidor(idUser);

      final prefs = await SharedPreferences.getInstance();
      final bd = Basededados();

      // Obtém os dados do utilizador e armazena-os no SharedPreferences
      var utilizador = await bd.listarUtilizador(idUser);
      await prefs.setString('profileData', jsonEncode(utilizador));
    } catch (e) {
      print('Erro ao atualizar dados do perfil: $e');
    }
  }
}
