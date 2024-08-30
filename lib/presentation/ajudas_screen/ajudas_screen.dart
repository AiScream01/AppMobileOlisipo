import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_text_form_field.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';

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
            appBar: AppBar(
              actions: [
                // Adicione o IconButton do perfil aqui
                IconButton(
                  icon: Icon(Icons.account_circle), // Ícone do perfil
                  iconSize: 40.0,
                  onPressed: () {
                    // Adicione a lógica que deseja executar ao clicar no ícone do perfil
                    // Por exemplo, abrir a tela de perfil
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
                      Navigator.pushNamed(
                          context, AppRoutes.pedidoFeriasScreen);
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
                      SizedBox(height: 70.v),
                      Text("Ajudas de custo",
                          style: theme.textTheme.displayMedium),
                      SizedBox(height: 1.v),
                      _buildSixtySixStack(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildSixtySixStack(BuildContext context) {
    return SizedBox(
        height: 570.v,
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
                    SizedBox(height: 15.v),
                    CustomTextFormField(controller: descricaoController),
                    SizedBox(height: 32.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Fatura", style: theme.textTheme.titleLarge),
                          SizedBox(height: 15.v),
                          CustomElevatedButton(
                            onPressed: () {},
                            text: ('Upload Documento'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.v),
                    CustomOutlinedButton(
                      text: "Enviar",
                      onPressed: () async {
                        if (!custoController.text.isNotEmpty ||
                            !descricaoController.text.isNotEmpty) {
                          final snackBar = SnackBar(
                            content: Text(
                                'Preencha todos os campos antes de enviar.'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }

                        //try {
                        //  await servidor.inserirAjudaCusto(
                        //      await servidor.obterTokenLocalmente(),
                        //      double.parse(custoController.text),
                        //      descricaoController.text,
                        //      // faturaController.text, // Aqui você pode usar filePath ou lógica para lidar com faturas
                        //      'fatura.pdf'
                        //      //false,
                        //      );
//
                        //  ScaffoldMessenger.of(context).showSnackBar(
                        //    SnackBar(
                        //      content:
                        //          Text('Ajudas de Custo enviadas com sucesso!'),
                        //    ),
                        //  );
                        //} catch (e) {
                        //  print('Erro ao enviar ajudas de custo: $e');
                        //  showDialog(
                        //    context: context,
                        //    builder: (BuildContext context) {
                        //      return AlertDialog(
                        //        title: Text('Erro ao enviar Ajudas de Custo!'),
                        //        content: Text(
                        //          'Dados inválidos para a submissão de ajudas de custo.',
                        //          style: TextStyle(fontSize: 17),
                        //        ),
                        //        actions: <Widget>[
                        //          TextButton(
                        //            onPressed: () {
                        //              Navigator.of(context).pop();
                        //            },
                        //            child: Text('OK'),
                        //          ),
                        //        ],
                        //      );
                        //    },
                        //  );
                        //}
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
