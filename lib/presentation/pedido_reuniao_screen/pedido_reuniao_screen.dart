import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rui_pedro_s_application11/presentation/push_notification_dialog/push_notification_dialog.dart';

class PedidoReuniaoScreen extends StatefulWidget {
  const PedidoReuniaoScreen({Key? key}) : super(key: key);

  @override
  _PedidoReuniaoScreenState createState() => _PedidoReuniaoScreenState();
}

class _PedidoReuniaoScreenState extends State<PedidoReuniaoScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
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
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.black87),
              iconSize: 40.0,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
              },
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu, color: Colors.black87),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text('Menu de Navegação',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
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
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageConstant.imgLogin),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      "Pedido de Reunião",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 3.0,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 21.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildEditableRowItem(
                              context,
                              label: "Título",
                              child: _buildTextField(
                                controller: _tituloController,
                                hintText: "Digite o título",
                              ),
                            ),
                            SizedBox(height: 15.0),
                            _buildEditableRowItem(
                              context,
                              label: "Descrição",
                              child: _buildTextField(
                                controller: _descricaoController,
                                hintText: "Digite a descrição",
                              ),
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
                              child: _buildTimePicker(context),
                            ),
                            SizedBox(height: 20.0),
                            Center(
                              child: CustomOutlinedButton(
                                width: 144.0,
                                text: "Enviar",
                                onPressed: () {
                                  onTapEnviar(context);
                                },
                              ),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
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
            ? _formatTimeOfDay(_selectedTime!)
            : "Selecionar Hora",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

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
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildUserDropdown() {
    return DropdownButton<String>(
      value: _selectedUserId,
      hint: Text(
        "Selecione Utilizador",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      items: _users.map<DropdownMenuItem<String>>((user) {
        return DropdownMenuItem<String>(
          value: user['id_user'].toString(),
          child: Text(
            user['nome'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
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

  Widget _buildEditableRowItem(BuildContext context,
      {required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller, required String hintText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
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
          content: const Text("Preencha todos os campos!"),
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

      List<(String, String, String, String)> dadosReuniao = [
        (
          _tituloController.text,
          _descricaoController.text,
          _selectedDate.toString(),
          _formatTimeOfDay(_selectedTime!),
        )
      ];

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
          content: const Text("Reunião marcada com sucesso!"),
        ),
      );
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const PushNotificationDialog(),
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
