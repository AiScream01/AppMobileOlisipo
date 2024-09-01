import '../parcerias_screen/widgets/parceriasgrid_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import '../../servidor/basedados.dart';

class ParceriasScreen extends StatefulWidget {
  const ParceriasScreen({Key? key}) : super(key: key);

  @override
  _ParceriasScreenState createState() => _ParceriasScreenState();
}

class ParceriasgridItemWidget extends StatelessWidget {
  final String titulo;
  final String logotipo;
  final VoidCallback onTapWidget;
  final VoidCallback onTapImgImageThree;

  const ParceriasgridItemWidget({
    Key? key,
    required this.logotipo,
    required this.titulo,
    required this.onTapWidget,
    required this.onTapImgImageThree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapWidget,
      child: Card(
        child: Column(
          children: [
            Image.network(logotipo), // ou outro tipo de imagem
            Text(titulo),
            IconButton(
              icon: Icon(Icons.image),
              onPressed: onTapImgImageThree,
            ),
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
              // Menu Items...
            ],
          ),
        ),
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            boxShadow: [
              BoxShadow(
                color: appTheme.black900.withOpacity(0.3),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(10, 10),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgLogin),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.v),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.v), // Espaçamento para descer o conteúdo
                Container(
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageConstant.imgLogin),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    "Parcerias",
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontSize: 38.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.v), // Espaçamento entre o título e o grid
                Container(
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20.h),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.black900.withOpacity(0.25),
                        spreadRadius: 2.h,
                        blurRadius: 2.h,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _buildParceriasGrid(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParceriasGrid(BuildContext context) {
    // Verifica se já há parcerias carregadas
    if (parcerias.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.v),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 120.v,
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.h,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: parcerias.length,
        itemBuilder: (context, index) {
          // Desestrutura a tupla
          var (logotipo, titulo, descricao, categoria) = parcerias[index];
          return ParceriasgridItemWidget(
            titulo: titulo,
            logotipo: logotipo,
            onTapWidget: () {
              onTapWidget(context,
                  index.toString()); // Usa o índice ou ID correspondente
            },
            onTapImgImageThree: () {
              onTapImgImageThree(context, index.toString());
            },
          );
        },
      ),
    );
  }

  void onTapWidget(BuildContext context, String idParceria) {
    Navigator.pushNamed(
      context,
      AppRoutes.parceriasPormenorOneScreen,
      arguments: idParceria,
    );
  }

  void onTapImgImageThree(BuildContext context, String idParceria) {
    Navigator.pushNamed(
      context,
      AppRoutes.parceriasPormenorOneScreen,
      arguments: idParceria,
    );
  }
}
