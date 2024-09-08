import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'dart:convert';

class RegistoScreen extends StatelessWidget {
  RegistoScreen({Key? key}) : super(key: key);

  final nomeController = TextEditingController();
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
                image: AssetImage(ImageConstant.imgLogin), // Substitua com a imagem desejada
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
                  _buildRegisterForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
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
          Text("Registo", style: theme.textTheme.displaySmall),
          SizedBox(height: 25),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Nome", style: theme.textTheme.bodyMedium),
          ),
          SizedBox(height: 2),
          CustomTextFormField(
            controller: nomeController,
          ),
          SizedBox(height: 18),
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
          SizedBox(height: 50),
          CustomElevatedButton(
            height: 60,
            width: 155,
            text: "Registar",
            onPressed: () async {
              try {
                // Chama o método de registro com "Utilizador" como role
                await servidor.insertUtilizador(
                  nomeController.text,
                  emailController.text,
                  "Utilizador", // Role fixa como "Utilizador"
                  passwordController.text,
                );

                // Exibe uma mensagem de sucesso
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Utilizador registado com sucesso!'),
                  ),
                );

                // Redireciona para a tela de login
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.loginScreen,
                );
              } catch (e) {
                // Exibe uma mensagem de erro apropriada
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()), // Exibe o erro completo
                  ),
                );
              }
            },
          ),
          SizedBox(height: 19),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.loginScreen);
            },
            child: Text(
              "Já tem conta?\nFaça login!",
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
}
