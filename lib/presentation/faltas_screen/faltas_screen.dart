import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FaltasScreen extends StatefulWidget {
  const FaltasScreen({Key? key}) : super(key: key);

  @override
  _FaltasScreenState createState() => _FaltasScreenState();
}

class _FaltasScreenState extends State<FaltasScreen> {
  final TextEditingController dateController = TextEditingController();
  final Servidor servidor = Servidor();
  final Basededados bd = Basededados();

  @override
  void dispose() {
    dateController.dispose();
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
        drawer: _buildDrawer(context),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.v),
                  _buildPageTitle(),
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
    return Text(
      "Faltas",
      style: theme.textTheme.displayMedium,
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
        ],
      ),
    );
  }

  Widget _buildDateInputField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Data",
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 5.v),
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
    if (dateController.text.isEmpty) {
      final snackBar = SnackBar(
        content: Text('O campo "Data" é obrigatório.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString(
        'idUser'); // Suponho que o idUser tenha sido salvo como String
    String estado = 'pendente'; // Estado padrão

    try {
      await bd.inserirFalta([
          (
           dateController.text.toString(),
            estado
          )
        ]);

      await servidor.insertFalta(
        idUser.toString(),
        DateTime.parse(dateController.text),
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
