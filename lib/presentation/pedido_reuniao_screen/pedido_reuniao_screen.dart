import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';
import 'package:intl/intl.dart'; // Adicione esta linha para formatar a hora

class PedidoReuniaoScreen extends StatefulWidget {
  const PedidoReuniaoScreen({Key? key}) : super(key: key);

  @override
  _PedidoReuniaoScreenState createState() => _PedidoReuniaoScreenState();
}

class _PedidoReuniaoScreenState extends State<PedidoReuniaoScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime; // Armazena o horário selecionado
  String? _selectedUserId;
  String? _selectedUserName;
  List<Map<String, dynamic>> _users = [];

  final Servidor servidor = Servidor();
  final Basededados bd = Basededados();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    List<Map<String, dynamic>> users = await servidor.getAllUsers();
    setState(() {
      _users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        drawer: _buildDrawer(context),
      ),
    );
  }

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
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
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
                  SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(66, 0, 0, 0),
                          spreadRadius: 2.0,
                          blurRadius: 8.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20.0),
                        _buildEditableRowItem(
                          context,
                          label: "Título",
                          child: _buildTextField(
                              controller: _tituloController,
                              hintText: "Digite o título"),
                        ),
                        SizedBox(height: 15.0),
                        _buildEditableRowItem(
                          context,
                          label: "Descrição",
                          child: _buildTextField(
                              controller: _descricaoController,
                              hintText: "Digite a descrição"),
                        ),
                        SizedBox(height: 15.0),
                        _buildEditableRowItem(
                          context,
                          label: "Utilizador",
                          child: _buildUserDropdown(),
                        ),
                        SizedBox(height: 20.0),
                        _buildEditableRowItem(
                          context,
                          label: "Data Reunião",
                          child: _buildDatePicker(context),
                        ),
                        SizedBox(height: 15.0),
                        _buildEditableRowItem(
                          context,
                          label: "Hora",
                          child: _buildTimePicker(context), // Atualizado aqui
                        ),
                        SizedBox(height: 20.0),
                        CustomOutlinedButton(
                          width: 144.0,
                          text: "Enviar",
                          onPressed: () {
                            onTapEnviar(context);
                          },
                        ),
                        SizedBox(height: 10.0),
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
            ? _formatTimeOfDay(_selectedTime!) // Exibe no formato 00:00
            : "Selecionar Hora",
        style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
      ),
    );
  }

  // Função para formatar a hora no formato HH:mm
  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    return DateFormat('HH:mm').format(dateTime);
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle),
          iconSize: 40.0,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
          },
        ),
      ],
    );
  }

  Widget _buildEditableRowItem(BuildContext context,
      {required String label, required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
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
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.green,
                width: 1.0,
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller, required String hintText}) {
    return Container(
      width: 150.0,
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
            : "Selecionar Data",
        style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
      ),
    );
  }

  Widget _buildUserDropdown() {
    return DropdownButton<String>(
      value: _selectedUserId,
      hint: Text(
        "Selecione o utilizador",
        style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
      ),
      items: _users.map<DropdownMenuItem<String>>((user) {
        return DropdownMenuItem<String>(
          value: user['id_user'].toString(),
          child: Text(
            user['nome'],
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedUserId = newValue;
          _selectedUserName = _users.firstWhere(
              (user) => user['id_user'].toString() == newValue,
              orElse: () => {'nome': 'Nome desconhecido'})['nome'];
        });
      },
    );
  }

  void onTapEnviar(BuildContext context) async {
    if (_tituloController.text.isEmpty ||
        _descricaoController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null ||
        _selectedUserId == null ||
        _selectedUserName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Preencha todos os campos!"),
        ),
      );
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? nomeUtilizador = prefs.getString('nome_utilizador_reuniao');

      print('Dados enviados para o servidor: {'
          'titulo: ${_tituloController.text}, '
          'descricao: ${_descricaoController.text}, '
          'data: ${_selectedDate.toString()}, '
          'hora: ${_formatTimeOfDay(_selectedTime!)}, '
          'id_user: ${_selectedUserId}, '
          'nome_utilizador_reuniao: ${_selectedUserName}'
          '}');

      // Crie a lista com a tupla esperada e sem o estado
      List<(String, String, String, String)> dadosReuniao = [
        (
          _tituloController.text,
          _descricaoController.text,
          _selectedDate.toString(),
          _formatTimeOfDay(_selectedTime!)
        )
      ];

      // Passe a lista para a função
      await bd.inserirReuniao(dadosReuniao);

      await servidor.insertReuniao(
        _tituloController.text,
        _descricaoController.text,
        _selectedDate.toString(),
        _formatTimeOfDay(_selectedTime!),
        _selectedUserId!,
        _selectedUserName!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Reunião marcada com sucesso!"),
        ),
      );
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao marcar reunião: ${e.toString()}"),
        ),
      );
    }
  }
}
