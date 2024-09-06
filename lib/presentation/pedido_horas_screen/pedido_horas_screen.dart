import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class PedidoHorasScreen extends StatefulWidget {
  const PedidoHorasScreen({Key? key}) : super(key: key);

  @override
  _PedidoHorasScreenState createState() => _PedidoHorasScreenState();
}

class _PedidoHorasScreenState extends State<PedidoHorasScreen> {
  final Servidor servidor = Servidor();
  final Basededados bd = Basededados();
  int selectedHours = 1;
  File?
      _selectedFile; // Novo: Variável para armazenar o arquivo PDF selecionado

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
        extendBody: true,
        extendBodyBehindAppBar: true,
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
              // Outros itens do menu...
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimaryContainer,
                image: DecorationImage(
                  image: AssetImage(ImageConstant.imgLogin),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80.0),
                  Text(
                    "Horas",
                    style: TextStyle(
                      fontSize: 36.0,
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
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  _buildPedidoHoras(context),
                  SizedBox(height: 20.0),
                  if (_selectedFile != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Arquivo: ${_selectedFile?.path.split('/').last}',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  SizedBox(height: 20.0),
                  CustomElevatedButton(
                    width: double.infinity,
                    text: "Enviar",
                    onPressed: () {
                      onTapEnviar(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPedidoHoras(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.0,
            blurRadius: 2.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Horas",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 120.0,
                child: DropdownButtonFormField<int>(
                  value: selectedHours,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: List.generate(50, (index) => index + 1)
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text("$value"),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedHours = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          _buildUploadButton(
            title: "Comprovativo",
            buttonText: "Upload de documento PDF",
            onPressed: () async {
              await _pickFile();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton({
    required String title,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity, // Aumenta a largura do botão
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0), // Aumenta o padding do botão
              foregroundColor: Colors.black, // Texto na cor preta
              side: BorderSide(
                  color: Colors.green, width: 1.5), // Borda verde fina
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Borda arredondada
              ),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 16.0, // Tamanho do texto
                fontWeight: FontWeight.w400, // Peso do texto
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Permitir apenas arquivos PDF
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    } else {
      print('Nenhum arquivo selecionado');
    }
  }

  void onTapEnviar(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser');
      String estado = 'pendente';
      String horas = selectedHours.toString();
      String comprovativo =
          _selectedFile != null ? _selectedFile!.path.split('/').last : "";

      if (idUser == null) {
        throw Exception('Usuário não identificado');
      }

      var horasData = [(horas, estado, _selectedFile?.path ?? "")];

      // Insere as horas no banco de dados local
      await bd.inserirHoras(horasData);

      // Envia as horas e o comprovativo para o servidor
      await servidor.insertHoras(
        idUser,
        horas,
        comprovativo,
        _selectedFile?.path, // Caminho do arquivo PDF
      );

      // Exibe um diálogo de sucesso
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
      // Captura e exibe o erro no console
      print('Erro ao enviar horas: $e');

      // Exibe um diálogo de erro para o usuário
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro ao enviar Horas!'),
            content: Text(
                'Ocorreu um erro ao enviar as Horas. Tente novamente mais tarde.'),
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
}
