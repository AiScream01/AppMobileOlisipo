import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/presentation/parcerias_pormenor_one_screen/parcerias_pormenor_one_screen.dart';
import '../../servidor/basedados.dart';

class ParceriasScreen extends StatefulWidget {
  const ParceriasScreen({Key? key}) : super(key: key);

  @override
  _ParceriasScreenState createState() => _ParceriasScreenState();
}

class ParceriasgridItemWidget extends StatelessWidget {
  final String logotipo; // Nome do arquivo da imagem
  final String titulo;
  final VoidCallback onTapWidget;

  const ParceriasgridItemWidget({
    Key? key,
    required this.logotipo,
    required this.titulo,
    required this.onTapWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Construa a URL completa da imagem
    final String baseUrl =
        'https://pi4-api.onrender.com/uploads/'; // Substitua pela URL base real
    final String imageUrl = '$baseUrl$logotipo';

    return GestureDetector(
      onTap: onTapWidget,
      child: Card(
        color: Colors.white, // Cor de fundo branca
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exibe o logotipo a partir da URL completa
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 120, // Ajuste a altura conforme necessário
              width: 120, // Ajuste a largura conforme necessário
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Icon(Icons.error, size: 80),
            ),
            SizedBox(height: 8), // Espaçamento entre a imagem e o texto
            Text(titulo,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _ParceriasScreenState extends State<ParceriasScreen> {
  var bd = Basededados();

  // Lista de tuplas para armazenar as parcerias
  final List<(String, String, String, String)> parcerias = [];

  @override
  void initState() {
    super.initState();
    _fetchParcerias();
  }

  // Função para buscar as parcerias do banco de dados
  Future<void> _fetchParcerias() async {
    var resultado = await bd.listarTodasParcerias();

    setState(() {
      parcerias.clear(); // Limpa a lista antes de adicionar novos resultados
      for (var parceria in resultado) {
        parcerias.add((
          parceria['logotipo'] as String,
          parceria['titulo'] as String,
          parceria['descricao'] as String,
          parceria['categoria'] as String
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
        extendBody: true,
        extendBodyBehindAppBar: true,
        drawer: _buildDrawer(context),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 60), // Espaçamento para descer o conteúdo
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Parcerias",
                  style: TextStyle(
                    fontSize: 36,
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
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 15), // Espaçamento entre o título e o grid
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: _buildParceriasGrid(context),
                ),
              ),
            ],
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

  Widget _buildParceriasGrid(BuildContext context) {
    if (parcerias.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1, // Mantém o aspecto da imagem quadrada
      ),
      itemCount: parcerias.length,
      itemBuilder: (context, index) {
        var (logotipo, titulo, descricao, categoria) = parcerias[index];
        return ParceriasgridItemWidget(
          logotipo: logotipo,
          titulo: titulo,
          onTapWidget: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ParceriasPormenorOneScreen(
                  logotipo: logotipo,
                  titulo: titulo,
                  descricao: descricao,
                  categoria: categoria,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
