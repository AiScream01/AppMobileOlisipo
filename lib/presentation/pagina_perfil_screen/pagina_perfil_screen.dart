import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart';

class PaginaPerfilScreen extends StatefulWidget {
  const PaginaPerfilScreen({Key? key}) : super(key: key);

  @override
  _PaginaPerfilScreenState createState() => _PaginaPerfilScreenState();
}

class _PaginaPerfilScreenState extends State<PaginaPerfilScreen> {
  var bd = Basededados();

  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  String userImageUrl = ''; // URL da imagem do utilizador

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      var listaPerfil = await bd.listarTodosUtilizadores();
      if (listaPerfil.isNotEmpty) {
        var perfil = listaPerfil[0];
        setState(() {
          nameController.text = perfil['nome'] as String? ?? '';
          emailController.text = perfil['email'] as String? ?? '';
          passwordController.text =
              perfil['password'] as String? ?? '**************';
          userImageUrl = perfil['imagem'] as String? ?? ''; // Obtém a URL da imagem
        });
      }
    } catch (e) {
      print("Erro ao buscar dados do perfil: $e");
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Perfil',
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.black87),
              iconSize: 40.0,
              onPressed: () {
                Navigator.pushNamed(context, '/paginaPerfilScreen');
              },
            ),
          ],
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        drawer: _buildDrawer(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: kToolbarHeight),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimaryContainer,
                  image: DecorationImage(
                    image: AssetImage(ImageConstant.imgLogin),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    _buildProfileImage(),
                    SizedBox(height: 50),
                    _buildProfileForm(),
                  ],
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

  Widget _buildProfileImage() {
  return Align(
    alignment: Alignment.center,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: appTheme.gray300,
            borderRadius: BorderRadius.circular(60),
            boxShadow: [
              BoxShadow(
                color: appTheme.black900.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: userImageUrl.isNotEmpty
                ? Image.network(
                    userImageUrl,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Mostra um ícone de erro se a imagem falhar
                      return Center(
                        child: Icon(
                          Icons.error,
                          size: 60,
                          color: Colors.red,
                        ),
                      );
                    },
                  )
                : Center(
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CustomImageView(
            imagePath: ImageConstant.imgEdit,
            height: 19,
            width: 19,
          ),
        ),
      ],
    ),
  );
}


  Widget _buildProfileForm() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              isDense: true,
            ),
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text("Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              isDense: true,
            ),
            obscureText: true,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text("Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              isDense: true,
            ),
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text("Contrato", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          CustomOutlinedButton(
            height: 29,
            width: 81,
            text: "PDF",
            buttonTextStyle: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          CustomOutlinedButton(
            height: 29,
            width: 81,
            text: "Log Out",
            margin: EdgeInsets.only(right: 6),
            buttonTextStyle: TextStyle(fontSize: 16),
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }
}
