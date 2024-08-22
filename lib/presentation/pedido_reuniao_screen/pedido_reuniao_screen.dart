import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

class PedidoReuniaoScreen extends StatelessWidget {
  const PedidoReuniaoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        drawer:
            _buildDrawer(context), // Adiciona o Drawer como a Navbar lateral
      ),
    );
  }

  /// Section: Body Content
  Widget _buildBody(BuildContext context) {
    return Container(
      width: SizeUtils.width,
      height: SizeUtils.height,
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        image: DecorationImage(
          image: AssetImage(ImageConstant.imgLogin),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 9.v),
        child: Column(
          children: [
            Text(
              "Pedido de reunião",
              style: theme.textTheme.displayMedium?.copyWith(
                color: const Color.fromARGB(255, 0, 0, 0),
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.v),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 25.v),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.h),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(66, 0, 0, 0),
                      spreadRadius: 2.h,
                      blurRadius: 8.h,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30.v),
                    _buildRowItem(
                      context,
                      label: "Com",
                      value: "Recursos Humanos",
                    ),
                    SizedBox(height: 35.v),
                    _buildRowItem(
                      context,
                      label: "Data Reunião",
                      value: "Calendário",
                    ),
                    SizedBox(height: 40.v),
                    _buildRowItem(
                      context,
                      label: "Hora",
                      value: "10:00",
                    ),
                    Spacer(),
                    CustomOutlinedButton(
                      width: 144.h,
                      text: "Enviar",
                      onPressed: () {
                        onTapEnviar(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.v),
          ],
        ),
      ),
    );
  }

  /// Section: Drawer (Navbar Lateral)
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
    );
  }

  /// Section: AppBar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle),
          iconSize: 40.h,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
          },
        ),
      ],
    );
  }

  /// Section: Helper Functions
  Widget _buildRowItem(BuildContext context,
      {required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.v),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.h),
              border: Border.all(
                color: theme.colorScheme.primary,
                width: 1.h,
              ),
            ),
            child: Text(value,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                )),
          ),
        ],
      ),
    );
  }

  /// Displays a dialog with the [PushNotificationDialog] content.
  onTapEnviar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: PushNotificationDialog(),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.only(left: 0),
      ),
    );
  }
}
