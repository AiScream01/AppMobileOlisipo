import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

class PedidoReuniaoScreen extends StatefulWidget {
  const PedidoReuniaoScreen({Key? key}) : super(key: key);

  @override
  _PedidoReuniaoScreenState createState() => _PedidoReuniaoScreenState();
}

class _PedidoReuniaoScreenState extends State<PedidoReuniaoScreen> {
  final TextEditingController _recursosHumanosController =
      TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        drawer: _buildDrawer(context), // Navbar lateral
      ),
    );
  }

  /// Corpo principal da tela
  Widget _buildBody(BuildContext context) {
    return Container(
      width: SizeUtils.width,
      height: SizeUtils.height,
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        image: DecorationImage(
          image: AssetImage(ImageConstant.imgLogin),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 9.v),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pedido de reunião",
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 33,
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          offset: Offset(0, 0),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.v),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.h, vertical: 10.v), // Redução no padding
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
                        SizedBox(
                            height: 20.v), // Redução do espaçamento inicial
                        _buildEditableRowItem(
                          context,
                          label: "Com",
                          child: _buildTextField(
                              controller: _recursosHumanosController,
                              hintText: "Digite o nome"),
                        ),
                        SizedBox(
                            height:
                                15.v), // Redução do espaçamento entre os campos
                        _buildEditableRowItem(
                          context,
                          label: "Data Reunião",
                          child: _buildDatePicker(context),
                        ),
                        SizedBox(
                            height:
                                20.v), // Redução do espaçamento entre os campos
                        _buildEditableRowItem(
                          context,
                          label: "Hora",
                          child: _buildTimePicker(context),
                        ),
                        CustomOutlinedButton(
                          width: 144.h,
                          text: "Enviar",
                          onPressed: () {
                            onTapEnviar(context);
                          },
                        ),
                        SizedBox(height: 10.v), // Redução do espaçamento final
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Navbar lateral
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

  /// AppBar
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

  /// Função auxiliar para criar os itens de linha editáveis
  Widget _buildEditableRowItem(BuildContext context,
      {required String label, required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.black,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.v),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.h),
              border: Border.all(
                color: Colors.green,
                width: 1.h,
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  /// Campo de texto para o "Com"
  Widget _buildTextField(
      {required TextEditingController controller, required String hintText}) {
    return Container(
      width: 150.h,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
      ),
    );
  }

  /// Seletor de data
  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (picked != null && picked != _selectedDate) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: Text(
        _selectedDate != null
            ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
            : "Calendário",
        style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
      ),
    );
  }

  /// Seletor de hora
  Widget _buildTimePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: _selectedTime ?? TimeOfDay.now(),
        );
        if (picked != null && picked != _selectedTime) {
          setState(() {
            _selectedTime = picked;
          });
        }
      },
      child: Text(
        _selectedTime != null
            ? _selectedTime!.format(context)
            : "10:00", // Hora padrão caso não selecionada
        style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
      ),
    );
  }

  /// Exibe o diálogo de notificação push
  onTapEnviar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: PushNotificationDialog(),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
