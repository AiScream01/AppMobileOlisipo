import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';

class RegistoScreen extends StatefulWidget {
  RegistoScreen({Key? key}) : super(key: key);

  @override
  _RegistoScreenState createState() => _RegistoScreenState();
}

class _RegistoScreenState extends State<RegistoScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController palavrapasseController = TextEditingController();

  File? foto;
  File? declaracaoAcademica;
  File? declaracaoBancaria;

  final Servidor servidor = Servidor();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            boxShadow: [
              BoxShadow(
                color: appTheme.black900.withOpacity(0.3),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(10, 10),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 21.h, vertical: 28.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 47.v),
                  CustomImageView(
                    imagePath: ImageConstant.imgOlisipoLogoblack,
                    height: 118.v,
                    width: 246.h,
                  ),
                  SizedBox(height: 32.v),
                  _buildRegistrationForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.v),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder35,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 34.v),
          Text(
            "Registo de Conta",
            style: theme.textTheme.displaySmall,
          ),
          SizedBox(height: 38.v),
          _buildTextField(
              "Nome Completo", nomeController, "Digite seu nome completo"),
          SizedBox(height: 18.v),
          _buildTextField("Email", emailController, "Digite seu email"),
          SizedBox(height: 18.v),
          _buildTextField("Senha", palavrapasseController, "Digite sua senha",
              obscureText: true),
          SizedBox(height: 18.v),
          _buildFilePicker("Foto", () => _pickImage()),
          SizedBox(height: 18.v),
          _buildFilePicker(
              "Declaração Acadêmica", () => _pickFile('declaracao_academica')),
          SizedBox(height: 18.v),
          _buildFilePicker(
              "Declaração Bancária", () => _pickFile('declaracao_bancaria')),
          SizedBox(height: 20.v),
          CustomElevatedButton(
            width: 185.h,
            text: "Efetuar Pedido",
            buttonTextStyle: CustomTextStyles.titleLargeOnPrimary,
            onPressed: () => _registerUser(context),
          ),
          SizedBox(height: 14.v),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.loginScreen);
            },
            child: SizedBox(
              width: 97.h,
              child: Text(
                "Já tem conta?\nFaz o login",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.titleMediumNunitoPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String hintText,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        SizedBox(height: 2.v),
        CustomTextFormField(
          controller: controller,
          obscureText: obscureText,
          hintText: hintText,
        ),
      ],
    );
  }

  Widget _buildFilePicker(String label, Future<void> Function() onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        TextButton(
          onPressed: onTap,
          child: Text('Escolher arquivo'),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        foto = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickFile(String type) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        if (type == 'declaracao_academica') {
          declaracaoAcademica = File(result.files.single.path!);
        } else if (type == 'declaracao_bancaria') {
          declaracaoBancaria = File(result.files.single.path!);
        }
      });
    } else {
      print('Nenhum arquivo selecionado');
    }
  }

  Future<void> _registerUser(BuildContext context) async {
    final String nome = nomeController.text;
    final String email = emailController.text;
    final String palavrapasse = palavrapasseController.text;

    if (nome.isEmpty || email.isEmpty || palavrapasse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    final Uri uri = Uri.parse(
        'https://pi4-api.onrender.com/utilizador/create'); // Altere para o endpoint da sua API

    final request = http.MultipartRequest('POST', uri)
      ..fields['nome'] = nome
      ..fields['email'] = email
      ..fields['role'] = 'utilizador'
      ..fields['palavrapasse'] = palavrapasse;

    if (foto != null) {
      request.files.add(await http.MultipartFile.fromPath('foto', foto!.path));
    }
    if (declaracaoAcademica != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'declaracao_academica', declaracaoAcademica!.path));
    }
    if (declaracaoBancaria != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'declaracao_bancaria', declaracaoBancaria!.path));
    }

    try {
      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registo bem-sucedido!')),
        );
        Navigator.pushNamed(context, AppRoutes.loginScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha no registo. Tente novamente.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha no registo. Tente novamente.')),
      );
    }
  }
}
