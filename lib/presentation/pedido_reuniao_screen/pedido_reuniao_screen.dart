import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

class PedidoReuniaoScreen extends StatefulWidget {
  const PedidoReuniaoScreen({Key? key}) : super(key: key);

  @override
  _PedidoReuniaoScreenState createState() => _PedidoReuniaoScreenState();
}

class _PedidoReuniaoScreenState extends State<PedidoReuniaoScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _nomeUtilizadorController = TextEditingController();
  DateTime? _selectedDate;
  final Servidor servidor = Servidor();

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
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.v),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pedido de Reunião",
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
                        horizontal: 20.h, vertical: 10.v),
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
                        SizedBox(height: 20.v),
                        _buildEditableRowItem(
                          context,
                          label: "Título",
                          child: _buildTextField(
                              controller: _tituloController,
                              hintText: "Digite o título"),
                        ),
                        SizedBox(height: 15.v),
                        _buildEditableRowItem(
                          context,
                          label: "Descrição",
                          child: _buildTextField(
                              controller: _descricaoController,
                              hintText: "Digite a descrição"),
                        ),
                        SizedBox(height: 15.v),
                        _buildEditableRowItem(
                          context,
                          label: "Com",
                          child: _buildTextField(
                              controller: _nomeUtilizadorController,
                              hintText: "Digite o nome do utilizador"), // Corrigido
                        ),
                        SizedBox(height: 20.v),
                        _buildEditableRowItem(
                          context,
                          label: "Data Reunião",
                          child: _buildDatePicker(context),
                        ),
                        SizedBox(height: 20.v),
                        CustomOutlinedButton(
                          width: 144.h,
                          text: "Enviar",
                          onPressed: () {
                            onTapEnviar(context);
                          },
                        ),
                        SizedBox(height: 10.v),
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

  /// Campo de texto para os campos editáveis
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
            : "Selecione a data",
        style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
      ),
    );
  }

  /// Função chamada quando o botão "Enviar" é pressionado
  Future<void> onTapEnviar(BuildContext context) async {
    try {
      String userId = '2'; // ID do utilizador fixo
      String nomeUtilizador = _nomeUtilizadorController.text;
      String titulo = _tituloController.text;
      String descricao = _descricaoController.text;
      String dataReuniao = _selectedDate != null
          ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
          : '';

      // Apenas chama a função sem atribuir a uma variável
      await servidor.insertReuniao(titulo, descricao, dataReuniao, userId, nomeUtilizador);

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
      print('Erro ao enviar reunião: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro ao enviar Reunião!'),
            content: Text(
              'Ocorreu um erro ao tentar enviar a reunião. Verifique os dados e tente novamente.\nErro: $e',
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
  }
}
