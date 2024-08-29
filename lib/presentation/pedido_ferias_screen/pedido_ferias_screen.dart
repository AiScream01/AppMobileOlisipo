import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

import '../../servidor/basedados.dart';

class PedidoFeriasScreen extends StatefulWidget {
  const PedidoFeriasScreen({Key? key}) : super(key: key);

  @override
  _PedidoFeriasScreenState createState() => _PedidoFeriasScreenState();
}

class _PedidoFeriasScreenState extends State<PedidoFeriasScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  final Basededados _basededados = Basededados();

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
              color: theme.colorScheme.background,
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
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _startDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
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
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _endDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
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
                CustomOutlinedButton(
                  width: 144,
                  text: "Verificar Férias",
                  onPressed: () {
                    _verificarFerias();
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
    // Verifica se as datas foram selecionadas
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

  int idUser = 1; // Substitua pelo ID real do usuário

  try {
    // Inserir na base de dados local
    await _basededados.InsertFerias(_startDate!, _endDate!, idUser);

    // Enviar para o servidor
    bool sucesso = await _basededados.enviarPedidoFeriasParaServidor(
      dataInicio: _startDate!,
      dataFim: _endDate!,
      idUser: idUser,
    );

    if (sucesso) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: PushNotificationDialog(),
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.only(left: 0),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Erro'),
          content: Text('Não foi possível enviar o pedido de férias para o servidor.'),
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
  } catch (e) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Erro'),
        content: Text('Ocorreu um erro ao processar o pedido de férias.'),
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


  /// Função para verificar as férias registradas na base de dados
  void _verificarFerias() async {
    List<Map<String, dynamic>> ferias = await _basededados.listarTodasFerias();
    if (ferias.isNotEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Férias Registradas'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: ferias.length,
              itemBuilder: (context, index) {
                final feriasItem = ferias[index];
                return ListTile(
                  title: Text('Início: ${formatDate(DateTime.parse(feriasItem['data_inicio']))}'),
                  subtitle: Text('Fim: ${formatDate(DateTime.parse(feriasItem['data_fim']))}'),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Nenhuma Férias Registrada'),
          content: Text('Não há férias registradas na base de dados.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}

