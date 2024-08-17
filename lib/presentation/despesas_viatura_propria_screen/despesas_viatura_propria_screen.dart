import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

// ignore: must_be_immutable
class DespesasViaturaPropriaScreen extends StatelessWidget {
  DespesasViaturaPropriaScreen({Key? key}) : super(key: key);

  TextEditingController partidaController = TextEditingController();
  TextEditingController chegadaController = TextEditingController();
  TextEditingController kmController = TextEditingController();
  TextEditingController portagensController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text('Menu'),
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
                  Navigator.pushNamed(context, AppRoutes.pedidoFeriasScreen);
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
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.v),
                    Text(
                      "Viatura",
                      style: theme.textTheme.displayMedium,
                    ),
                    SizedBox(height: 20.v),
                    _buildInputSection(context),
                    SizedBox(height: 20.v),
                    _buildEnviarButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 21.v),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder35,
        color: Colors.white.withOpacity(0.8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildRowWithInputField(
            context,
            title: "Ponto de partida",
            controller: partidaController,
            hintText: "Insira o ponto de partida",
          ),
          SizedBox(height: 10.v),
          _buildRowWithInputField(
            context,
            title: "Ponto de chegada",
            controller: chegadaController,
            hintText: "Insira o ponto de chegada",
          ),
          SizedBox(height: 10.v),
          _buildRowWithInputField(
            context,
            title: "Kilometros",
            controller: kmController,
            hintText: "Insira a distância em km",
          ),
          SizedBox(height: 10.v),
          _buildRowWithInputField(
            context,
            title: "Portagens",
            controller: portagensController,
            hintText: "Insira o custo das portagens",
          ),
          SizedBox(height: 10.v),
          _buildRowWithButton(
            context,
            title: "Comprovativo",
            buttonText: "Adicionar PDF",
            onPressed: () {
              // adicionar ação para adicionar PDF
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRowWithInputField(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.v),
            child: Text(
              title,
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(
            width: 126.h,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowWithButton(
    BuildContext context, {
    required String title,
    required String buttonText,
    required void Function() onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.v),
            child: Text(
              title,
              style: theme.textTheme.titleLarge,
            ),
          ),
          CustomOutlinedButton(
            height: 32.v,
            width: 126.h,
            text: buttonText,
            onPressed: onPressed,
            buttonStyle: CustomButtonStyles.outlinePrimary,
            buttonTextStyle: theme.textTheme.titleLarge!,
          ),
        ],
      ),
    );
  }

  Widget _buildEnviarButton(BuildContext context) {
    return Center(
      child: CustomOutlinedButton(
        width: 144.h,
        text: "Enviar",
        onPressed: () {
          onTapEnviarButton(context);
        },
      ),
    );
  }

  void onTapEnviarButton(BuildContext context) {
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
