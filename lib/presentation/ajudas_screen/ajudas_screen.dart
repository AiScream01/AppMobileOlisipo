import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';
import 'package:rui_pedro_s_application11/servidor.dart';

class AjudasScreen extends StatefulWidget {
  const AjudasScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AjudasScreen> createState() => _AjudasScreen();
}

// ignore_for_file: must_be_immutable
class _AjudasScreen extends State<AjudasScreen> {

  final TextEditingController custoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController faturaController = TextEditingController();

  @override
  void dispose() {
    custoController.dispose();
    descricaoController.dispose();
    faturaController.dispose();
    super.dispose();
  }

  var servidor = Servidor();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
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
                          offset: Offset(10, 10))
                    ],
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgLogin),
                        fit: BoxFit.cover)),
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(height: 8.v),
                      _buildNinetyThreeRow(context),
                      SizedBox(height: 20.v),
                      Text("Ajudas de custo",
                          style: theme.textTheme.displayMedium),
                      SizedBox(height: 1.v),
                      _buildSixtySixStack(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildNinetyThreeRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomImageView(
              imagePath: ImageConstant.imgDoUtilizador,
              height: 45.adaptSize,
              width: 45.adaptSize,
              onTap: () {
                onTapImgDoUtilizador(context);
              }),
          CustomImageView(
              imagePath: ImageConstant.imgMegaphone,
              height: 20.v,
              width: 39.h,
              margin: EdgeInsets.only(top: 12.v, bottom: 13.v))
        ]));
  }

  /// Section Widget
  Widget _buildSixtySixStack(BuildContext context) {
    return SizedBox(
        height: 622.v,
        width: 370.h,
        child: Stack(alignment: Alignment.center, children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 27.h, vertical: 30.v),
                  decoration: AppDecoration.outlineGray.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder35),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(height: 42.v),
                    Align(
                        alignment: Alignment.centerLeft,
                        child:
                            Text("Custo", style: theme.textTheme.titleLarge)),
                    SizedBox(height: 15.v),
                    CustomTextFormField(controller: custoController),
                    SizedBox(height: 32.v),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Descrição",
                            style: theme.textTheme.titleLarge)),
                    SizedBox(height: 9.v),
                    Padding(
                        padding: EdgeInsets.only(right: 3.h),
                        child: CustomTextFormField(
                            controller: descricaoController,
                            maxLines: null,
                            textInputAction: TextInputAction.done,
                            borderDecoration:
                                TextFormFieldStyleHelper.outlineBlackTL10,
                            filled: true,
                            fillColor: theme.colorScheme.onPrimaryContainer)),
                    SizedBox(height: 34.v),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Fatura",
                            style: theme.textTheme.titleLarge)),
                    SizedBox(height: 9.v),
                    Padding(
                        padding: EdgeInsets.only(right: 3.h),
                        child: CustomTextFormField(
                            controller: faturaController,
                            maxLines: null,
                            textInputAction: TextInputAction.done,
                            borderDecoration:
                                TextFormFieldStyleHelper.outlineBlackTL10,
                            filled: true,
                            fillColor: theme.colorScheme.onPrimaryContainer)),
                    SizedBox(height: 10.v),
                    /*Padding(
                        padding: EdgeInsets.only(left: 4.h, right: 7.h),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 1.v),
                                  child: Text("Comprovativo",
                                      style: theme.textTheme.titleLarge)),
                              Text("PDF",
                                  style: CustomTextStyles.titleLargePrimary)
                            ])),*/
                    SizedBox(height: 85.v),
                    CustomOutlinedButton(
                       text: "Enviar",
                      onPressed: () async {
                      if (!custoController.text.isNotEmpty ||
                          !descricaoController.text.isNotEmpty) {
                        final snackBar = SnackBar(
                          content:
                              Text('Preencha todos os campos antes de enviar.'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }

                      try {
                        await servidor.inserirAjudaCusto(
                          await servidor.obterTokenLocalmente(),
                          double.parse(custoController.text),
                          descricaoController.text,
                          // faturaController.text, // Aqui você pode usar filePath ou lógica para lidar com faturas
                          'fatura.pdf'
                          //false,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Ajudas de Custo enviadas com sucesso!'),
                          ),
                        );
                      } catch (e) {
                        print('Erro ao enviar ajudas de custo: $e');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Erro ao enviar Ajudas de Custo!'),
                              content: Text(
                                'Dados inválidos para a submissão de ajudas de custo.',
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
                    },
                    )
                  ])))
        ]));
  }

  /// Navigates to the paginaPerfilScreen when the action is triggered.
  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }
}
