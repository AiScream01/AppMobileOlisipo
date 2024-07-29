import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FaltasScreen extends StatelessWidget {
  FaltasScreen({Key? key}) : super(key: key);

  TextEditingController editTextController = TextEditingController();
  TextEditingController editTextController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/background_image.png'), // Update the image path
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserProfile(context),
                const SizedBox(height: 20),
                Center(
                  child: Text("Faltas",
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                const SizedBox(height: 20),
                _buildFaltasForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.person, size: 30),
          onPressed: () {
            onTapImgDoUtilizador(context);
          },
        ),
        IconButton(
          icon: Icon(Icons.menu, size: 30),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildFaltasForm(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Data", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            TextField(
              controller: editTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text("Descrição", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            TextField(
              controller: editTextController1,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Comprovativo",
                    style: Theme.of(context).textTheme.titleMedium),
                Text("PDF", style: TextStyle(color: Colors.green)),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  onTapEnviar(context);
                },
                child: Text("Enviar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapImgDoUtilizador(BuildContext context) {
    Navigator.pushNamed(context, '/profile'); // Update with your route
  }

  onTapEnviar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text("Notification sent!"),
      ),
    );
  }
}
