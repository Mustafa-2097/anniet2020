import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../controllers/dashboard_signle_payemnt_controller.dart';
import '../../model/dashboard_single_payment_model.dart';

class PaymentDetails extends StatelessWidget {
  final String paymentId; // Changed from Map to ID

  PaymentDetails({super.key, required this.paymentId});

  // Initialize Controller
  final controller = Get.put(PaymentDetailController());

  @override
  Widget build(BuildContext context) {
    // Fetch data on build
    controller.fetchPaymentDetail(paymentId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.blackColor),
        title: Text(
          "Payment Details",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.isError.value) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final payment = controller.paymentDetail.value;
        if (payment == null) {
          return const Center(child: Text("No payment data found"));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              // ------------------------------
              // PAYMENT STATUS SECTION
              // ------------------------------
              _buildStatusHeader(payment),

              SizedBox(height: 20.h),

              // ------------------------------
              // TOTAL AMOUNT PAID
              // ------------------------------
              _buildAmountCard(payment),

              SizedBox(height: 20.h),

              // ------------------------------
              // CUSTOMER INFORMATION
              // ------------------------------
              _infoCard(
                titleIcon: Icons.person,
                title: "Customer Information",
                children: [
                  _infoTitle("Full Name"),
                  _infoValue(payment.name),
                  SizedBox(height: 10.h),
                  _infoTitle("Email"),
                  _rowIconText(Icons.email_outlined, payment.email),
                  SizedBox(height: 10.h),
                  _infoTitle("Phone"),
                  _rowIconText(Icons.phone, payment.phone ?? "Not provided"),
                  SizedBox(height: 10.h),
                  _infoTitle("User ID"),
                  _infoValue("#${payment.id.substring(0, 8)}"),
                ],
              ),

              SizedBox(height: 20.h),

              // ------------------------------
              // COURSE INFORMATION
              // ------------------------------
              _infoCard(
                titleIcon: Icons.menu_book_outlined,
                title: "Course Information",
                children: payment.coursesData.isEmpty
                    ? [const Text("No courses associated with this payment")]
                    : payment.coursesData.map((course) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoTitle("Course Name"),
                        _infoValue(course.title),
                        SizedBox(height: 4.h),
                        _infoTitle("Total Duration"),
                        _infoValue("${course.totalLengthInMinutes} minutes"),
                        const Divider(),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatusHeader(PaymentDetail payment) {
    bool isSuccess = payment.status.toLowerCase() == 'paid' || payment.status.toLowerCase() == 'success';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSuccess ? const Color(0xFFE8FBE7) : const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.info,
                color: isSuccess ? Colors.green : Colors.orange,
                size: 26,
              ),
              const SizedBox(width: 8),
              Text(
                "Payment ${payment.status}",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isSuccess ? Colors.green : Colors.orange.shade900,
                ),
              ),
            ],
          ),
          if (payment.transactionId != null) ...[
            SizedBox(height: 6.h),
            Text(
              "Transaction ID: ${payment.transactionId}",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                color: isSuccess ? Colors.green.shade700 : Colors.orange.shade700,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildAmountCard(PaymentDetail payment) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            "Total Amount Paid",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "\$${payment.amount.toStringAsFixed(2)}",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(
                payment.paidAt != null
                    ? DateFormat('dd/MM/yyyy at hh:mm a').format(payment.paidAt!)
                    : "Date Pending",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // UI Helper Widgets
  Widget _infoCard({required IconData titleIcon, required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(titleIcon, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  Widget _infoTitle(String text) => Text(
    text,
    style: GoogleFonts.plusJakartaSans(
      fontSize: 12.sp,
      color: Colors.grey.shade600,
    ),
  );

  Widget _infoValue(String text) => Text(
    text,
    style: GoogleFonts.plusJakartaSans(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    ),
  );

  Widget _rowIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 18),
        const SizedBox(width: 6),
        Expanded(child: _infoValue(text)),
      ],
    );
  }
}