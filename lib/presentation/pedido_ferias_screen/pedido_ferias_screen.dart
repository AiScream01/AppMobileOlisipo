import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

import '../../servidor/basedados.dart';
import '../../servidor/servidor.dart';

class PedidoFeriasScreen extends StatefulWidget {
  const PedidoFeriasScreen({Key? key}) : super(key: key);

  @override
  _PedidoFeriasScreenState createState() => _PedidoFeriasScreenState();
}

class _PedidoFeriasScreenState extends State<PedidoFeriasScreen> {
  DateTime? _startDate; // Inicialize como null
  DateTime? _endDate; // Inicialize como null

  var se = Servidor();
  var bd = Basededados();

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
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            boxShadow: [
              BoxShadow(
                color: appTheme.black900.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(10, 10),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 50),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 21),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      _buildFiftySixStack(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFiftySixStack(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: appTheme.black900.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                _buildDatePickerRow(
                  label: "Data Início",
                  selectedDate: _startDate,
                  onPressed: () async {
                    DateTime firstDate = DateTime.now().add(Duration(days: 7));
                    DateTime initialDate = _endDate ?? firstDate;
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: initialDate.isBefore(firstDate)
                          ? firstDate
                          : initialDate,
                      firstDate: firstDate,
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _startDate = pickedDate;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                _buildDatePickerRow(
                  label: "Data Fim",
                  selectedDate: _endDate,
                  onPressed: () async {
                    DateTime firstDate = _startDate != null ? _startDate!.add(Duration(days: 1)) : DateTime.now().add(Duration(days: 7));
                    DateTime initialDate = _endDate ?? firstDate;
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: initialDate.isBefore(firstDate) ? firstDate : initialDate,
                      firstDate: firstDate,
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _endDate = pickedDate;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                if (_startDate != null && _endDate != null)
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Período Selecionado: ${formatDate(_startDate!)} - ${formatDate(_endDate!)}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                CustomOutlinedButton(
                  width: 144,
                  text: "Enviar",
                  onPressed: () {
                    onTapEnviar(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  Widget _buildDatePickerRow({
    required String label,
    required DateTime? selectedDate,
    required Future<void> Function() onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.titleLarge,
        ),
        CustomOutlinedButton(
          height: 39,
          width: 126,
          text: selectedDate == null ? "Selecionar" : formatDate(selectedDate),
          buttonStyle: CustomButtonStyles.outlinePrimary,
          buttonTextStyle: theme.textTheme.titleLarge!,
          onPressed: onPressed,
        ),
      ],
    );
  }

  void onTapEnviar(BuildContext context) async {
    if (_startDate == null || _endDate == null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Erro'),
          content: Text('Por favor, selecione as datas de início e fim.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return;
    }

    int idUser = 2; // Substitua pelo ID real do usuário

    try {
      // Inserir na base de dados local
      await bd.inserirFerias([
        (
          DateFormat('yyyy-MM-dd').format(_startDate!),
          DateFormat('yyyy-MM-dd').format(_endDate!)
        )
      ]);

      // Enviar para o servidor
      await se.insertFerias(
        idUser.toString(),
        DateFormat('yyyy-MM-dd').format(_startDate!),
        DateFormat('yyyy-MM-dd').format(_endDate!),
      );

      // Se chegar aqui, as operações foram bem-sucedidas
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: PushNotificationDialog(),
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.only(left: 0),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Erro'),
          content: Text('Ocorreu um erro: $e'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

}
