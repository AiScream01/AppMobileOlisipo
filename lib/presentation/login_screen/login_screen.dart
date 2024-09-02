import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
//import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var servidor = Servidor();

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
                    height: 118, // Mantenha o valor de altura atual ou ajuste
                    width: 270, // Ajuste a largura se necessário
                    fit: BoxFit
                        .contain, // Adiciona esta linha para garantir que a imagem não seja cortada
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
                await servidor.login(
                  emailController.text,
                  passwordController.text,
                );
                Navigator.pushReplacementNamed(
                  context,
                  '/pagina_principal_screen', // ou o nome da rota que você deseja navegar
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Credenciais inválidas'),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 19),
          GestureDetector(
            onTap: () {
              onTapTxtNovoAquiFazO(context);
            },
            child: Text(
              "Novo aqui?\nFaz o pedido de conta",
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
}
