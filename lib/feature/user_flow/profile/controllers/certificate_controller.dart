import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
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
                child: pw.Image(bgImage, fit: pw.BoxFit.cover),
              ),

              // NAME
              pw.Positioned(
                left: 400,
                top: 130,
                child: pw.Text(
                  userName.value,
                  style: pw.TextStyle(fontSize: 22.sp, fontWeight: pw.FontWeight.bold),
                ),
              ),

              // DATE
              pw.Positioned(
                left: 400,
                top: 390,
                child: pw.Text(
                  completionDate.value,
                  style: pw.TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          );
        },
      ),
    );

    pdfBytes = await pdf.save();
  }

  Future<void> downloadPdf() async {
    try {
      late Directory directory;

      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      final filePath = '${directory.path}/certificate.pdf';
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes!);

      print("PDF saved at: $filePath");
    } catch (e) {
      Get.snackbar(
        "Error",
        "Download failed",
      );
    }
  }

}
