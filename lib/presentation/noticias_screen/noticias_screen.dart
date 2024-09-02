import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/presentation/noticia_screen/noticia_screen.dart';
import '../../servidor/basedados.dart';

// Modelo de Noticia
class Noticia {
  final String data;
  final String titulo;
  final String descricao;
  final String imagem;

  Noticia({
    required this.data,
    required this.titulo,
    required this.descricao,
    required this.imagem,
  });
}

class NoticiasScreen extends StatefulWidget {
  const NoticiasScreen({Key? key}) : super(key: key);

  @override
  _NoticiasScreenState createState() => _NoticiasScreenState();
}

class NoticiasgridItemWidget extends StatelessWidget {
  final String titulo;
  final VoidCallback onTapWidget;

  const NoticiasgridItemWidget({
    Key? key,
    required this.titulo,
    required this.onTapWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapWidget,
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              titulo,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _NoticiasScreenState extends State<NoticiasScreen> {
  final Basededados bd = Basededados();

  final List<Noticia> noticias = [];

  @override
  void initState() {
    super.initState();
    _fetchNoticias();
  }

  Future<void> _fetchNoticias() async {
    final resultado = await bd.listarTodasNoticias();

    setState(() {
      noticias.clear();
      for (var noticia in resultado) {
        noticias.add(Noticia(
          data: noticia['data'] as String,
          titulo: noticia['titulo'] as String,
          descricao: noticia['descricao'] as String,
          imagem: noticia['imagem'] as String,
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
              icon: Icon(Icons.account_circle, color: Colors.black87),
              iconSize: 32.0,
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Text(
                  "Notícias",
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
                SizedBox(height: 20),
                _buildNoticiasGrid(context),
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
    );
  }

  Widget _buildNoticiasGrid(BuildContext context) {
    if (noticias.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 140.0,
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: noticias.length,
        itemBuilder: (context, index) {
          var noticia = noticias[index];
          return NoticiasgridItemWidget(
            titulo: noticia.titulo,
            onTapWidget: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoticiaScreen(
                    titulo: noticia.titulo,
                    descricao: noticia.descricao,
                    imagem: noticia.imagem,
                    data: noticia.data,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
