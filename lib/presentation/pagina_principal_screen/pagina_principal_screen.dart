import '../pagina_principal_screen/widgets/contentslider_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart';
import 'package:rui_pedro_s_application11/presentation/noticia_screen/noticia_screen.dart';

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

class PaginaPrincipalScreen extends StatefulWidget {
  PaginaPrincipalScreen({Key? key}) : super(key: key);

  @override
  _PaginaPrincipalScreenState createState() => _PaginaPrincipalScreenState();
}

class _PaginaPrincipalScreenState extends State<PaginaPrincipalScreen> {
  int sliderIndex = 0;
  var bd = Basededados();
  final List<Noticia> noticias = [];
  String estadoFerias = 'Carregando...';
  String estadoReuniao = 'Carregando...';
  String estadoAjudas = 'Carregando...';
  String estadoContas = 'Carregando...';

  @override
  void initState() {
    super.initState();
    _fetchNoticias();
    //_fetchStates();
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

/*
  Future<void> _fetchStates() async {
    final estadoF = await bd.getEstadoFerias();
    final estadoR = await bd.getEstadoReuniao();
    final estadoA = await bd.getEstadoAjudas();
    final estadoC = await bd.getEstadoContas();

    setState(() {
      estadoFerias = estadoF;
      estadoReuniao = estadoR;
      estadoAjudas = estadoA;
      estadoContas = estadoC;
    });
  }
*/
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
                    title: const Text('Ferias'),
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.pedidoFeriasScreen);
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
            body: SizedBox(
                height: SizeUtils.height,
                width: double.maxFinite,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgFundo,
                      height: 893.v,
                      width: 411.h,
                      radius: BorderRadius.circular(30.h),
                      alignment: Alignment.bottomCenter),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.h, right: 20.h, bottom: 20.v),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder30),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 34.v),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.h, vertical: 11.v),
                                        decoration: AppDecoration.outlineGray
                                            .copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder35),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Conteúdo",
                                                  style: CustomTextStyles
                                                      .titleLargeInterSemiBold),
                                              SizedBox(height: 13.v),
                                              _buildContentSlider(context),
                                              SizedBox(height: 27.v),
                                              SizedBox(
                                                  height: 8.v,
                                                  child: AnimatedSmoothIndicator(
                                                      activeIndex: sliderIndex,
                                                      count: noticias.length,
                                                      axisDirection:
                                                          Axis.horizontal,
                                                      effect:
                                                          ScrollingDotsEffect(
                                                              spacing: 8,
                                                              activeDotColor:
                                                                  appTheme
                                                                      .green400,
                                                              dotColor: appTheme
                                                                  .gray200,
                                                              dotHeight: 8.v,
                                                              dotWidth: 8.h))),
                                              SizedBox(height: 13.v),
                                              _buildUserStatusColumn(context),
                                              SizedBox(height: 10.v),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.h),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        _buildRequestRow(
                                                            context,
                                                            pedidoDeReuniaoText:
                                                                "Pedido de férias",
                                                            reprovadoText:
                                                                estadoFerias),
                                                        SizedBox(height: 10.v),
                                                        _buildRequestRow(
                                                            context,
                                                            pedidoDeReuniaoText:
                                                                "Pedido de reunião",
                                                            reprovadoText:
                                                                estadoReuniao),
                                                        SizedBox(height: 10.v),
                                                        _buildRequestRow(
                                                            context,
                                                            pedidoDeReuniaoText:
                                                                "Pedido de ajudas",
                                                            reprovadoText:
                                                                estadoAjudas),
                                                        SizedBox(height: 10.v),
                                                        _buildRequestRow(
                                                            context,
                                                            pedidoDeReuniaoText:
                                                                "Pedido de Contas",
                                                            reprovadoText:
                                                                estadoContas)
                                                      ]))
                                            ])),
                                    SizedBox(height: 10.v)
                                  ]))))
                ]))));
  }

  Widget _buildContentSlider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 240.v,
          initialPage: 0,
          autoPlay: true,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {
            setState(() {
              sliderIndex = index;
            });
          },
        ),
        itemCount: noticias.length,
        itemBuilder: (context, index, realIndex) {
          final noticia = noticias[index];
          return GestureDetector(
            onTap: () {
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.v),
              decoration: BoxDecoration(
                color: Colors.white, // Personalize o fundo aqui
                borderRadius: BorderRadius.circular(15.h),
              ),
              child: Center(
                child: Text(
                  noticia.titulo,
                  style: CustomTextStyles.titleLargeInterSemiBold.copyWith(
                    fontSize: 20.h, // Personalize o tamanho do texto aqui
                    color: Colors.black, // Personalize a cor do texto aqui
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserStatusColumn(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 3.h, right: 1.h),
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v),
        decoration: AppDecoration.fillLightGreenA
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 4.v),
              Text("Estado das suas submissões/pedidos",
                  style: CustomTextStyles.titleMediumNunitoOnPrimaryContainer)
            ]));
  }

  Widget _buildRequestRow(
    BuildContext context, {
    required String pedidoDeReuniaoText,
    required String reprovadoText,
  }) {
    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'aprovado':
          return Colors.green;
        case 'reprovado':
          return Colors.red;
        case 'pendente':
          return Colors.yellow;
        case 'enviado':
        case 'em análise':
          return Colors.grey;
        default:
          return Colors.black;
      }
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 7.v),
        decoration: AppDecoration.fillGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: EdgeInsets.only(left: 4.h, bottom: 2.v),
              child: Text(pedidoDeReuniaoText,
                  style: CustomTextStyles.titleLargeInter
                      .copyWith(color: appTheme.black900))),
          Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Text(reprovadoText,
                  style: CustomTextStyles.titleLargeInterPrimaryContainer
                      .copyWith(color: getStatusColor(reprovadoText))))
        ]));
  }

  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paginaPerfilScreen);
  }
}
