import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

// ignore: must_be_immutable
class PedidoHorasScreen extends StatelessWidget {
  PedidoHorasScreen({Key? key}) : super(key: key);

  TextEditingController descricaoController = TextEditingController();
  TextEditingController tempoController = TextEditingController();

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
                title: const Text('Noticias'),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.noticiaScreen);
                },
              ),
              ListTile(
                title: const Text('Parcerias'),
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.parceriasScreen);
                },
              ),
              ListTile(
                title: const Text('Ferias'),
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
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.v),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80
                      .v, // Espaçamento para descer o conteúdo abaixo da AppBar
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPedidoHoras(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: Colors.white, // Caixa branca
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
                child: CustomTextFormField(
                  controller: tempoController,
                  hintText: "HH:MM", // Sugere o formato de entrada
                  textInputAction: TextInputAction.done,
                  borderDecoration: TextFormFieldStyleHelper.outlineBlackTL10,
                  filled: true,
                  fillColor:
                      theme.colorScheme.onPrimaryContainer.withOpacity(0.9),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Descrição",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 20.h,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          SizedBox(height: 10.v),
          CustomTextFormField(
            controller: descricaoController,
            textInputAction: TextInputAction.done,
            maxLines: 5, // Aumentando o campo de descrição
            borderDecoration: TextFormFieldStyleHelper.outlineBlackTL10,
            filled: true,
            fillColor: theme.colorScheme.onPrimaryContainer.withOpacity(0.9),
          ),
          SizedBox(height: 20.v),
          CustomOutlinedButton(
            width: 144.h,
            text: "Enviar",
            onPressed: () {
              onTapEnviar(context);
            },
          ),
        ],
      ),
    );
  }

  void onTapEnviar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: PushNotificationDialog(),
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.only(left: 0),
      ),
    );
  }
}
