import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';

class ReunioesScreen extends StatefulWidget {
  const ReunioesScreen({Key? key}) : super(key: key);

  @override
  _ReunioesScreenState createState() => _ReunioesScreenState();
}

class _ReunioesScreenState extends State<ReunioesScreen> {
  var bd = Basededados();

  final List<(String, String)> reunioes = [];

  @override
  void initState() {
    super.initState();
    _fetchReunioes();
  }

  Future<void> _fetchReunioes() async {
    var resultado = await bd.listarReunioesAceitas();
    print("Resultado das reuniões: $resultado");

    setState(() {
      reunioes.clear();
      for (var reuniao in resultado) {
        reunioes.add((
          reuniao['titulo'] as String,
          reuniao['data'] as String,
        ));
      }
    });
  }

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
        drawer: _buildDrawer(context),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                    "Reuniões",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: reunioes.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(35.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(35.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 600, // Ajusta a largura da tabela
                                    ),
                                    child: _buildMeetingTable(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              CustomElevatedButton(
                                width: double.infinity,
                                text: "Faça um pedido de reunião",
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.pedidoReuniaoScreen);
                                },
                              ),
                            ],
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
              Navigator.pushNamed(context, AppRoutes.despesasViaturaPropriaScreen);
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

  Widget _buildMeetingTable() {
    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(color: Color(0xFF1ED700), width: 1.0),
      ),
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Color(0xFF1ED700),
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Título da Reunião',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        for (var reuniao in reunioes)
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    reuniao.$1,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    reuniao.$2,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
