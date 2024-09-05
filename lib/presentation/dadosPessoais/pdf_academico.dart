import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';

Future<void> createPDFA(
  String name,
  String contribuinte,
) async {
  // Create a new PDF document
  PdfDocument document = PdfDocument();

  // Add a new page
  PdfPage page = document.pages.add();

  // Set font
  PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);

  Future<PdfBitmap> _loadImage(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    final Uint8List bytes = data.buffer.asUint8List();
    return PdfBitmap(bytes);
  }

  final PdfBitmap image = await _loadImage('images/olisipo.png');

  // Calculate the center of the page
  double centerX = page.getClientSize().width / 2;
  double centerY = page.getClientSize().height / 2;
  String nomeText = name; // Use the actual value from the controller
  String contribuinteText =
      contribuinte; // Use the actual value from the controller
  // Text content
  String texto1 =
      'Nós, Olisipo, localizada em Rua Carlos Aleluia, 4, Loja 3 3810-077 Aveiro, vimos por meio desta declarar, de forma oficial e em conformidade com as normas vigentes, que o colaborador $nomeText, portador do número de contribuinte $contribuinteText, encontra-se atualmente vinculado e desempenhando suas funções de maneira efetiva na nossa organização. Ressaltamos que estamos à disposição para prestar quaisquer esclarecimentos adicionais que se fizerem necessários, bem como para colaborar com eventuais consultas por parte de entidades competentes.';

  String texto2 =
      'Além disso, esclarecemos que a presente declaração tem por finalidade atestar a veracidade da relação empregatícia entre a empresa e o colaborador mencionado, sendo válida para todos os fins legais, em especial para as instituições académicas que necessitem de comprovação da situação laboral do mesmo.';

  String texto3 = 'Atenciosamente';

  page.graphics.drawImage(
    image,
    Rect.fromLTWH(
        centerX - 100, centerY - 300, 200, 100), // Ajuste de posição e tamanho
  );

// Draw título
  String titulo = 'Declaração para fins académicos';
  page.graphics.drawString(
    titulo,
    PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    format: PdfStringFormat(
      alignment: PdfTextAlignment.center,
      lineAlignment: PdfVerticalAlignment.middle,
    ),
    bounds: Rect.fromLTWH(centerX - 250, centerY - 250, 500, 200),
  );

// Draw texto1
  page.graphics.drawString(
    texto1,
    font,
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    format: PdfStringFormat(
      alignment: PdfTextAlignment.center,
      lineAlignment: PdfVerticalAlignment.middle,
    ),
    bounds: Rect.fromLTWH(centerX - 250, centerY - 160, 500, 200),
  );

// Draw texto2 abaixo de texto1
  page.graphics.drawString(
    texto2,
    font,
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    format: PdfStringFormat(
      alignment: PdfTextAlignment.center,
      lineAlignment: PdfVerticalAlignment.middle,
    ),
    bounds: Rect.fromLTWH(centerX - 250, centerY - 60, 500, 200),
  );

// Draw texto3 abaixo de texto2
  page.graphics.drawString(
    texto3,
    font,
    brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    format: PdfStringFormat(
      alignment: PdfTextAlignment.center,
      lineAlignment: PdfVerticalAlignment.middle,
    ),
    bounds: Rect.fromLTWH(centerX - 250, centerY, 500, 200),
  );

// Draw line abaixo de texto3
  page.graphics.drawLine(
    PdfPen(PdfColor(0, 0, 0), width: 1),
    Offset(centerX - 250, centerY + 160), // Ajuste de altura
    Offset(centerX + 250, centerY + 160), // Ajuste de altura
  );

  // Save the document
  List<int> bytes = await document.save();

  // Dispose the document
  document.dispose();

  // Get external storage directory
  final directory = await getApplicationSupportDirectory();

  // Get directory path
  final path = directory.path;

  // Create an empty file to write PDF data
  File file = File('$path/DeclaracaoFinsBancarios.pdf');

  // Write PDF data
  await file.writeAsBytes(bytes, flush: true);

  // Open the PDF document in a viewer
  OpenFile.open('$path/DeclaracaoFinsBancarios.pdf');
}
