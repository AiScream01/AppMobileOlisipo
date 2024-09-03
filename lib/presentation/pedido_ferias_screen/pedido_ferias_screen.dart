import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart'; // Certifique-se de que Basededados é importado

class PedidoFeriasScreen extends StatefulWidget {
  const PedidoFeriasScreen({Key? key}) : super(key: key);

  @override
  _PedidoFeriasScreenState createState() => _PedidoFeriasScreenState();
}

class _PedidoFeriasScreenState extends State<PedidoFeriasScreen> {
  DateTime? _startDate;
  DateTime? _endDate;

  final Servidor servidor = Servidor();
  final Basededados bd = Basededados();

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
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Férias",
                    style: theme.textTheme.displayMedium,
                  ),
                ),
                SizedBox(height: 20),
                _buildDatePickers(context),
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
                CustomElevatedButton(
                  width: double.infinity,
                  text: "Enviar",
                  onPressed: () {
                    onTapEnviar(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickers(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 21),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDatePickerRow(
            label: "Data Início",
            selectedDate: _startDate,
            onPressed: () async {
              DateTime firstDate = DateTime.now().add(Duration(days: 7));
              DateTime initialDate = _endDate ?? firstDate;
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate:
                    initialDate.isBefore(firstDate) ? firstDate : initialDate,
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
              DateTime firstDate = _startDate != null
                  ? _startDate!.add(Duration(days: 1))
                  : DateTime.now().add(Duration(days: 7));
              DateTime initialDate = _endDate ?? firstDate;
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate:
                    initialDate.isBefore(firstDate) ? firstDate : initialDate,
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
        ],
      ),
    );
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

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
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

      int idUser = 2;
      String estado = 'pendente'; // Estado padrão

      try {
        // Tenta inserir no banco de dados local (bd)
        await bd.inserirFerias([
          (
            DateFormat('yyyy-MM-dd').format(_startDate!), // Data de início
            DateFormat('yyyy-MM-dd').format(_endDate!), // Data de fim
            estado // Estado inicial como 'pendente'
          )
        ]);

        // Se a inserção local foi bem-sucedida, tenta enviar para o servidor
        await servidor.insertFerias(
            idUser.toString(),
            DateFormat('yyyy-MM-dd').format(_startDate!),
            DateFormat('yyyy-MM-dd').format(_endDate!),
            estado);

        // Mostra a notificação de sucesso
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
        // Qualquer erro é capturado aqui e uma mensagem de erro é exibida
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
}
