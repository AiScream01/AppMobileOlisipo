import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';

class RecuperarPasswordEmailScreen extends StatelessWidget {
  RecuperarPasswordEmailScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();

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
            child: Center(
              // Para centralizar o conteúdo
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 27),
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
                    _buildPasswordRecoveryForm(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRecoveryForm(BuildContext context) {
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
          // Centralização do título
          Center(
            child: Text(
              "Recuperar Password",
              style: theme.textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 25),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Email", style: theme.textTheme.bodyMedium),
          ),
          SizedBox(height: 2),
          CustomTextFormField(
            controller: emailController,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: 30),
          CustomElevatedButton(
            height: 60,
            width: 155,
            text: "Recuperar",
            onPressed: () {
              // Lógica para recuperar a password
            },
          ),
          SizedBox(height: 19),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.loginScreen);
            },
            child: Text(
              "Já tem conta? Faz o login",
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
