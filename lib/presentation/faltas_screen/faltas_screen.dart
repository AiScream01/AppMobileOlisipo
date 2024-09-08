import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class FaltasScreen extends StatefulWidget {
  const FaltasScreen({Key? key}) : super(key: key);

  @override
  _FaltasScreenState createState() => _FaltasScreenState();
}

class _FaltasScreenState extends State<FaltasScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hoursController =
      TextEditingController(); // Novo: Controlador para horas
  File? _justificacao;

  final Servidor servidor = Servidor();
  final Basededados bd = Basededados();
  // Variável para armazenar o arquivo PDF selecionado

  @override
  void dispose() {
    dateController.dispose();
    hoursController.dispose(); // Dispose do controlador de horas
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
          title: null,
        ),
        drawer: _buildDrawer(context),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                image: DecorationImage(
                  image: AssetImage(ImageConstant.imgLogin),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  _buildPageTitle(),
                  SizedBox(height: 20.0),
                  _buildInputSection(context),
                  SizedBox(height: 20.0),
                  _buildUploadButton(),
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

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
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
    );
  }

  Widget _buildPageTitle() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "Faltas",
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
    );
  }

  Widget _buildInputSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 21),
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
          _buildDateInputField(context),
          SizedBox(height: 20.0),
          _buildHoursInputField(context), // Novo: Campo para horas
        ],
      ),
    );
  }

  Widget _buildDateInputField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Data",
            style: Theme.of(context).textTheme.titleMedium, // Estilo ajustado
          ),
          SizedBox(height: 5.0),
          GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  dateController.text = pickedDate.toString().split(" ")[0];
                });
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: dateController,
                decoration: InputDecoration(
                  hintText: "DD/MM/YYYY",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoursInputField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Horas Faltadas",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 5.0),
          TextField(
            controller: hoursController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Número de horas",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.transparent,
              suffixIcon: Icon(Icons.access_time),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Comprovativo",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () async {
              await _pickFile();
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              foregroundColor: Colors.black,
              side: BorderSide(color: Colors.green, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              "Upload da justificação",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        if (_justificacao != null)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Arquivo Selecionado: ${_justificacao?.path.split('/').last}",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
      ],
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _justificacao = File(result.files.single.path!);
      });
    }
  }

  Widget _buildEnviarButton(BuildContext context) {
    return CustomElevatedButton(
      width: double.infinity,
      text: "Enviar",
      onPressed: () {
        onTapEnviar(context);
      },
    );
  }

  void onTapEnviar(BuildContext context) async {
    if (dateController.text.isEmpty || hoursController.text.isEmpty) {
      final snackBar = SnackBar(
        content: Text('Os campos "Data" e "Horas" são obrigatórios.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString('idUser');
    String estado = 'pendente'; // Estado padrão
    String justificacao =
        _justificacao != null ? _justificacao!.path.split('/').last : "";

    // Print dos dados que serão enviados
    print('Dados para enviar:');
    print('ID do usuário: $idUser');
    print('Data: ${dateController.text}');
    print('Horas: ${hoursController.text}');
    print('Estado: $estado');
    print('Comprovativo: $justificacao');
    print(
        'Caminho do arquivo: ${_justificacao?.path ?? 'Nenhum arquivo selecionado'}');

    try {
      await bd.inserirFalta([
        (
          dateController.text.toString(),
          hoursController.text,
          estado,
          justificacao,
        )
      ]);

      // Convert hours to String if necessary
      String hoursString =
          hoursController.text; // Já é uma String, então não precisa converter

      await servidor.insertFalta(
        idUser.toString(),
        DateTime.parse(dateController.text),
        hoursString, // Passe o valor como String
        _justificacao?.path,
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
      print('Erro ao enviar falta: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro ao enviar Falta!'),
            content: Text(
              'Ocorreu um erro ao tentar enviar a falta. Verifique os dados e tente novamente.\nErro: $e',
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
