import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

class PedidoHorasScreen extends StatefulWidget {
  const PedidoHorasScreen({Key? key}) : super(key: key);

  @override
  _PedidoHorasScreenState createState() => _PedidoHorasScreenState();
}

class _PedidoHorasScreenState extends State<PedidoHorasScreen> {
  final Servidor servidor = Servidor();
  int selectedHours = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 40.h,
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
              ListTile(
                title: const Text('Despesas viatura própria'),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.despesasViaturaPropriaScreen);
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
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80.v),
                  Text(
                    "Horas",
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontSize: 32.h,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.v),
                  _buildPedidoHoras(context),
                  SizedBox(height: 20.v),
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
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
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
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 24.h,
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(
                width: 120.h,
                child: DropdownButtonFormField<int>(
                  value: selectedHours,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
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
        ],
      ),
    );
  }

  void onTapEnviar(BuildContext context) async {
  try {
    String userId = '2'; // Substitua pelo ID real do usuário
    String horas = selectedHours.toString();
    
    // Apenas chama a função sem atribuir a uma variável
    await servidor.insertHoras(userId, horas);

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
    print('Erro ao enviar horas: $e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro ao enviar Horas!'),
          content: Text(
            'Ocorreu um erro ao tentar enviar as horas. Verifique os dados e tente novamente.\nErro: $e',
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
