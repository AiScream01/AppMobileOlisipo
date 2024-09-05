import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_outlined_button.dart';
import 'package:rui_pedro_s_application11/servidor/servidor.dart';
import 'package:rui_pedro_s_application11/servidor/basedados.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaPerfilScreen extends StatefulWidget {
  const PaginaPerfilScreen({Key? key}) : super(key: key);

  @override
  _PaginaPerfilScreenState createState() => _PaginaPerfilScreenState();
}

class _PaginaPerfilScreenState extends State<PaginaPerfilScreen> {
  final Servidor servidor = Servidor();
  final Basededados bd = Basededados();

  // Controladores dos campos de texto
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    // Inicializando os controladores dos campos de texto
    nameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();

    // Carregar os dados do perfil ao inicializar a tela
    _fetchProfileData();
  }

  // Função para buscar os dados do perfil do banco de dados
  Future<void> _fetchProfileData() async {
    try {
      // Simulação de chamada ao banco de dados para buscar o perfil do usuário
      var listaPerfil = await bd.listarTodosUtilizadores();

      // Verifica se há utilizadores na lista e usa o primeiro
      if (listaPerfil.isNotEmpty) {
        var perfil = listaPerfil[
            0]; // Aqui você seleciona o primeiro utilizador da lista

        // Atualiza os controladores com os dados do perfil
        setState(() {
          nameController.text = perfil['nome'] as String? ?? '';
          emailController.text = perfil['email'] as String? ?? '';
          passwordController.text =
              perfil['password'] as String? ?? '**************';
        });
      }
    } catch (e) {
      // Tratar possíveis erros, como falta de conexão com o banco de dados
      print("Erro ao buscar dados do perfil: $e");
    }
  }

  @override
  void dispose() {
    // Garantir a liberação dos controladores ao descartar o widget
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString('idUser');
    int userId = int.tryParse(idUser ?? '') ?? 0; // Convertendo idUser para int

    try {
      // Atualiza o perfil no servidor
      await servidor.updateProfile(
        idUser: idUser.toString(),
        nome: nameController.text,
        email: emailController.text,
        palavrapasse:
            passwordController.text.isNotEmpty ? passwordController.text : null,
        role: 'user', // Substitua pelo role real, se necessário
      );

      // Atualiza o perfil na base de dados local
      await bd.atualizarUtilizador(
          userId,
          nameController.text,
          emailController.text,
          emailController
              .text, // Aqui, a foto é o email, ajuste conforme necessário
          passwordController.text.isNotEmpty
              ? passwordController.text
              : '', // Atualiza a senha somente se fornecida
          '', // Declaracao Academica (não fornecido, colocar um valor vazio ou o valor real)
          '', // Declaracao Bancaria (não fornecido, colocar um valor vazio ou o valor real)
          'user' // Role
          );

      // Mostrar um diálogo de sucesso ou uma mensagem
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Perfil Atualizado!'),
            content: Text('Seu perfil foi atualizado com sucesso.'),
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
    } catch (e) {
      // Mostrar um diálogo de erro
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro ao Atualizar Perfil'),
            content: Text(
                'Ocorreu um erro ao tentar atualizar o perfil. Verifique os dados e tente novamente.\nErro: $e'),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        extendBody: true,
        extendBodyBehindAppBar: true,
        drawer: _buildDrawer(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
              top:
                  kToolbarHeight), // Adiciona padding para não sobrepor a AppBar
          child: Container(
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
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 21.h, vertical: 28.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 14.v),
                  _buildProfileImage(),
                  SizedBox(height: 50.v),
                  _buildProfileForm(),
                ],
              ),
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
            height: 120.v,
            width: 120.h,
            decoration: BoxDecoration(
              color: appTheme.gray300,
              borderRadius: BorderRadius.circular(60.h),
              boxShadow: [
                BoxShadow(
                  color: appTheme.black900.withOpacity(0.25),
                  spreadRadius: 2.h,
                  blurRadius: 2.h,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: CustomImageView(
                imagePath: ImageConstant.imgDoUtilizador,
                height: 90.adaptSize,
                width: 90.adaptSize,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomImageView(
              imagePath: ImageConstant.imgEdit,
              height: 19.v,
              width: 19.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Container(
      width: 369.h,
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.v),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder35,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Nome", style: CustomTextStyles.titleLargePrimary),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            isDense: true,
          ),
          style: theme.textTheme.bodyLarge,
        ),
        SizedBox(height: 20.v),
        Text("Senha", style: CustomTextStyles.titleLargePrimary),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            isDense: true,
          ),
          obscureText: true,
          style: theme.textTheme.bodyLarge,
        ),
        SizedBox(height: 20.v),
        Text("Email", style: CustomTextStyles.titleLargePrimary),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            isDense: true,
          ),
          style: theme.textTheme.bodyLarge,
        ),
        SizedBox(height: 8.v),
        CustomOutlinedButton(
          height: 29.v,
          width: 81.h,
          text: "Editar",
          buttonTextStyle: CustomTextStyles.bodyLarge16_1,
          onPressed:
              _updateProfile, // Chama a função de atualização ao pressionar o botão
        ),
        SizedBox(height: 20.v),
        CustomOutlinedButton(
          height: 29,
          width: 81,
          text: "Log Out",
          margin: EdgeInsets.only(right: 6),
          buttonTextStyle: TextStyle(fontSize: 16),
          alignment: Alignment.centerRight,
          onPressed: () async {
            // Limpe os dados do perfil armazenados
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('idUser');
            await prefs.remove(
                'profileData'); // Supondo que você armazena dados do perfil aqui

            // Redirecione para a tela de login
            Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
          },
        ),
      ]),
    );
  }
}
