import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

// ignore_for_file: must_be_immutable
class FaltasScreen extends StatelessWidget {
  FaltasScreen({Key? key}) : super(key: key);

  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
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
                _buildUserProfile(context),
                SizedBox(height: 20),
                Text("Faltas", style: theme.textTheme.displayMedium),
                SizedBox(height: 12),
                _buildFaltasForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.person, size: 45),
          onPressed: () {
            onTapImgDoUtilizador(context);
          },
        ),
        IconButton(
          icon: Icon(Icons.menu, size: 45),
          onPressed: () {
            // Implement menu action
          },
        ),
      ],
    );
  }

  /// Section Widget
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
          Text("Data", style: theme.textTheme.titleLarge),
          SizedBox(height: 10),
          CustomTextFormField(
            controller: dateController,
            hintText: 'DD/MM/YYYY',
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 20),
          Text("Descrição", style: theme.textTheme.titleLarge),
          SizedBox(height: 10),
          CustomTextFormField(
            controller: descriptionController,
            hintText: 'Descrição da falta',
            textInputAction: TextInputAction.done,
            maxLines: 4,
          ),
          SizedBox(height: 20),
          Row(
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
          ),
          SizedBox(height: 20),
          Center(
            child: CustomOutlinedButton(
              text: "Enviar",
              onPressed: () {
                onTapEnviar(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }

  /// Displays a dialog with the [PushNotificationDialog] content.
  onTapEnviar(BuildContext context) {
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
