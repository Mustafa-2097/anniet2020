import 'dart:io';
import 'package:anniet2020/core/constant/app_colors.dart';
import 'package:anniet2020/feature/user_flow/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import '../../data/repositories/user_repository.dart';

class CertificateController extends GetxController {
  final UserRepository _repo = UserRepository();
  RxBool isCourseCompleted = false.obs;
  RxString userName = ''.obs;
  RxString completionDate = ''.obs;
  Uint8List? pdfBytes;

  @override
  void onInit() {
    fetchCertificateData();
    super.onInit();
  }

  Future<void> fetchCertificateData() async {
    try {
      final certificates = await _repo.getCertificates();

      if (certificates.isNotEmpty) {
        final cert = certificates.first;
        isCourseCompleted.value = true;
        userName.value = Get.find<ProfileController>().userName.value;
        completionDate.value = _formatDate(cert['completedAt']);
      } else {
        isCourseCompleted.value = false;
      }
    } catch (e) {
      isCourseCompleted.value = false;
      debugPrint("Certificate error: $e");
    }
  }

  String _formatDate(String date) {
    final parsed = DateTime.parse(date);
    return "${parsed.day} ${_month(parsed.month)}, ${parsed.year}";
  }

  String _month(int m) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[m - 1];
  }

  // ---------------- PDF ----------------

  Future<void> generatePdf() async {
    final pdf = pw.Document();
    final bgImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/certificate.png'))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: pw.EdgeInsets.zero,
        build: (_) => pw.Stack(
          children: [
            pw.Positioned.fill(
              child: pw.Image(bgImage, fit: pw.BoxFit.cover),
            ),
            pw.Positioned(
              left: 400,
              top: 130,
              child: pw.Text(
                userName.value,
                style: pw.TextStyle(fontSize: 22.sp, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Positioned(
              left: 400,
              top: 390,
              child: pw.Text(
                completionDate.value,
                style: pw.TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );

    pdfBytes = await pdf.save();
  }

  Future<void> downloadPdf() async {
    try {
      late Directory directory;

      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      final file = File('${directory.path}/certificate.pdf');
      await file.writeAsBytes(pdfBytes!);
    } catch (_) {
      Get.snackbar("Error", "Download failed", backgroundColor: AppColors.redColor);
    }
  }
}

