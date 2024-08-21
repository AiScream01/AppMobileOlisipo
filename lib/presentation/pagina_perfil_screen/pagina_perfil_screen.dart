import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';

class PaginaPerfilScreen extends StatelessWidget {
  const PaginaPerfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: "Pedro Martins");
    final TextEditingController passwordController =
        TextEditingController(text: "**************");
    final TextEditingController emailController =
        TextEditingController(text: "pedromartins@gmail.com");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
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
        body: SingleChildScrollView(
          // Adiciona um scroll para evitar overflow
          child: Container(
            width: SizeUtils.width,
            height: SizeUtils.height,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimaryContainer,
              boxShadow: [
                BoxShadow(
                  color: appTheme.black900.withOpacity(0.3),
                  spreadRadius: 2.h,
                  blurRadius: 2.h,
                  offset: Offset(
                    10,
                    10,
                  ),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgLogin,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 21.h,
                vertical: 28.v,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 14.v),
                  CustomImageView(
                    imagePath: ImageConstant.imgMegaphone,
                    height: 20.v,
                    width: 39.h,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 4.h),
                  ),
                  SizedBox(
                      height: 20.v), // Diminui o espaçamento entre elementos
                  _buildPaginaPerfil(context, nameController,
                      passwordController, emailController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaginaPerfil(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController passwordController,
      TextEditingController emailController) {
    return Container(
      width: 369.h,
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 15.v, // Reduz a altura do padding
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder35,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              alignment:
                  Alignment.bottomRight, // Alinhamento do ícone de edição
              children: [
                Container(
                  height: 120.v,
                  width: 120.h,
                  decoration: BoxDecoration(
                    color: appTheme.gray300,
                    borderRadius: BorderRadius.circular(
                      60.h,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.black900.withOpacity(0.25),
                        spreadRadius: 2.h,
                        blurRadius: 2.h,
                        offset: Offset(
                          0,
                          4,
                        ),
                      ),
                    ],
                  ),
                  child: Center(
                    child: CustomImageView(
                      imagePath: ImageConstant.imgDoUtilizador,
                      height: 90.adaptSize,
                      width: 90.adaptSize,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0, // Alinha o ícone de edição à borda inferior
                  right: 0, // Alinha o ícone de edição à borda direita
                  child: CustomImageView(
                    imagePath: ImageConstant.imgEdit,
                    height: 19.v,
                    width: 19.h,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 50.v), // Reduz a altura entre a imagem e o primeiro campo
          Text(
            "Nome",
            style: CustomTextStyles.titleLargePrimary,
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              isDense: true,
            ),
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 20.v), // Reduz a altura entre campos de texto
          Text(
            "Password",
            style: CustomTextStyles.titleLargePrimary,
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              isDense: true,
            ),
            obscureText: true,
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 20.v),
          Text(
            "Email",
            style: CustomTextStyles.titleLargePrimary,
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              isDense: true,
            ),
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 15.v),
          Text(
            "Contrato",
            style: CustomTextStyles.titleLargePrimary,
          ),
          SizedBox(height: 8.v),
          CustomOutlinedButton(
            height: 29.v,
            width: 81.h,
            text: "PDF",
            buttonTextStyle: CustomTextStyles.bodyLarge16_1,
          ),
          SizedBox(height: 20.v), // Reduz a altura do espaçamento final
          CustomOutlinedButton(
            height: 29.v,
            width: 81.h,
            text: "Log Out",
            margin: EdgeInsets.only(right: 6.h),
            buttonTextStyle: CustomTextStyles.bodyLarge16,
            alignment: Alignment.centerRight,
          ),
          SizedBox(height: 5.v),
        ],
      ),
    );
  }
}
