import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';

class CertificateController extends GetxController {
  RxBool isCourseCompleted = false.obs;
  RxString userName = ''.obs;
  RxString completionDate = ''.obs;

  Uint8List? pdfBytes;

  @override
  void onInit() {
    fetchCertificateData();
    super.onInit();
  }

  void fetchCertificateData() {
    // backend response
    isCourseCompleted.value = true;
    userName.value = "Denise Plummer";
    completionDate.value = "31 January 2025";
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    final bgImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/certificate.png'))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape, // 🔥 IMPORTANT
        margin: pw.EdgeInsets.zero,             // 🔥 NO MARGIN
        build: (_) {
          return pw.Stack(
            children: [
              // FULL WIDTH IMAGE
              pw.Positioned.fill(
                child: pw.Image(
                  bgImage,
                  fit: pw.BoxFit.cover, // 🔥 cover full page
                ),
              ),

              // NAME
              pw.Positioned(
                left: 260,
                top: 150,
                child: pw.Text(
                  userName.value,
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),

              // DATE
              pw.Positioned(
                left: 260,
                top: 360,
                child: pw.Text(
                  completionDate.value,
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
            ],
          );
        },
      ),
    );

    pdfBytes = await pdf.save();
  }



}
