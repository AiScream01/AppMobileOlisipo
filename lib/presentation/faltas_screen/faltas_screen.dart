import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

class FaltasScreen extends StatelessWidget {
  FaltasScreen({Key? key}) : super(key: key);

  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 29),
            child: Column(
              children: [
                _buildPageTitle(),
                SizedBox(height: 12),
                _buildFaltasForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Drawer with menu options similar to the previous screen.
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
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
    );
  }

  /// Builds the title section for the Faltas page.
  Widget _buildPageTitle() {
    return Text(
      "Faltas",
      style: theme.textTheme.displayMedium,
    );
  }

  /// Builds the form for submitting a "Falta".
  Widget _buildFaltasForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormLabel("Data"),
          CustomTextFormField(
            controller: dateController,
            hintText: 'DD/MM/YYYY',
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 20),
          _buildFormLabel("Descrição"),
          CustomTextFormField(
            controller: descriptionController,
            hintText: 'Descrição da falta',
            textInputAction: TextInputAction.done,
            maxLines: 4,
          ),
          SizedBox(height: 20),
          _buildProofUploadSection(context),
          SizedBox(height: 20),
          _buildEnviarButton(context),
        ],
      ),
    );
  }

  /// Builds the label for form fields.
  Widget _buildFormLabel(String labelText) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        labelText,
        style: theme.textTheme.titleLarge,
      ),
    );
  }

  /// Builds the section for uploading a proof document.
  Widget _buildProofUploadSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Comprovativo", style: theme.textTheme.titleLarge),
        TextButton(
          onPressed: () {
            // Implement file upload
          },
          child: Text(
            "PDF",
            style: TextStyle(
              color: theme.colorScheme.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the send button.
  Widget _buildEnviarButton(BuildContext context) {
    return Center(
      child: CustomOutlinedButton(
        text: "Enviar",
        onPressed: () {
          onTapEnviar(context);
        },
      ),
    );
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  void onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }

  /// Displays a dialog with the PushNotificationDialog content.
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
