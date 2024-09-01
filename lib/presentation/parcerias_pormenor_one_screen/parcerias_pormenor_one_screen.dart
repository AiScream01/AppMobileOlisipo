import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';

class ParceriasPormenorOneScreen extends StatefulWidget {
  final String? logotipo;
  final String? titulo;
  final String? descricao;
  final String? categoria;

  const ParceriasPormenorOneScreen({
    Key? key,
    this.logotipo,
    this.titulo,
    this.descricao,
    this.categoria,
  }) : super(key: key);

  @override
  _ParceriasPormenorOneScreenState createState() =>
      _ParceriasPormenorOneScreenState();
}

class _ParceriasPormenorOneScreenState
    extends State<ParceriasPormenorOneScreen> {
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
        extendBody: true,
        extendBodyBehindAppBar: true,
        drawer: _buildDrawer(context),
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
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 30.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Column(
                        children: [
                          SizedBox(height: 30.v),
                          Text(
                            "Parcerias",
                            style: theme.textTheme.displayMedium,
                          ),
                          SizedBox(height: 12.v),
                          Container(
                            margin: EdgeInsets.only(left: 1.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.h, vertical: 20.v),
                            decoration: AppDecoration.outlineGray.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder35,
                              // ignore: deprecated_member_use
                              color: theme.colorScheme.background,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.titulo ?? 'Nome da Parceria',
                                  style: theme.textTheme.headlineLarge,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10.v),
                                Padding(
                                  padding: EdgeInsets.only(right: 5.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Container(
                                      //  padding: EdgeInsets.symmetric(
                                      //      horizontal: 9.h, vertical: 12.v),
                                      //  decoration: AppDecoration.fillGray
                                      //      .copyWith(
                                      //          borderRadius: BorderRadiusStyle
                                      //              .roundedBorder8),
                                      //  child: Row(
                                      //    mainAxisAlignment:
                                      //        MainAxisAlignment.spaceBetween,
                                      //    children: [
                                      //      Icon(Icons.arrow_back_ios),
                                      //      Icon(Icons.arrow_forward_ios),
                                      //    ],
                                      //  ),
                                      //),
                                      SizedBox(height: 10.v),
                                      Text(
                                          'Categoria: ${widget.categoria ?? 'Não especificado'}',
                                          style: theme.textTheme.titleMedium),
                                      SizedBox(height: 11.v),
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          widget.descricao ??
                                              'Descrição não disponível.',
                                          maxLines: 9,
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyles
                                              .headlineSmallInter_1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.v),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
}
