import 'package:anniet2020/feature/admin_dashboard/payments/views/pages/payment_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Add for date formatting
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/popup_button.dart';
import '../controllers/dashboard_payment_controller.dart';
import '../model/dashboard_payment_model.dart';

class PaymentListPage extends StatelessWidget {
  PaymentListPage({super.key});

  final controller = Get.put(PaymentsController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        title: Text("Payment List",
            style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor)),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchPayments();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search Bar
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                child: TextField(
                  controller: searchController,
                  onChanged: (value){
                    controller.fetchPayments(
                      searchTerm: value.trim()
                    );
                  },
                  decoration: InputDecoration(
                    hintText: "Search payments...",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.boxTextColor.withOpacity(0.6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.boxTextColor.withOpacity(0.6)),
                    ),
                    filled: true,
                    fillColor: AppColors.whiteColor,
                  ),
                ),
              ),
              const Divider(thickness: 1, color: Color(0xFFD2D6D8)),

              /// Main Content Box
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value && controller.payments.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Container(
                    margin: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD2D6D8)),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        /// FIXED HEADER
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            border: const Border(bottom: BorderSide(color: Color(0xFFD2D6D8))),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              topRight: Radius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Showing Page ${controller.currentPage.value} of ${controller.totalPages.value}",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),

                        /// SCROLLABLE AREA
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.payments.length + 1,
                            itemBuilder: (context, index) {
                              if (index == controller.payments.length) {
                                return const PaginationSection();
                              }
                              return PaymentCard(payment: controller.payments[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final PaymentData payment; // Updated to Model
  const PaymentCard({required this.payment, super.key});

  @override
  Widget build(BuildContext context) {
    String formattedDate = payment.paidAt != null
        ? DateFormat('MMM dd, yyyy').format(payment.paidAt!)
        : "N/A";

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFD2D6D8))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${payment.name}  —  #${payment.id.substring(0, 6)}",
                style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF4E4E4A)),
              ),
              PopupButton(
                onTap: () {
                  // Navigate with full model object
                  Get.to(() => PaymentDetails(paymentId: payment.id));
                },
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(payment.email, style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontSize: 13.sp)),
          SizedBox(height: 12.h),
          _rowItem("Amount Paid:", "\$${payment.amount.toStringAsFixed(2)}"),
          SizedBox(height: 6.h),
          _rowItem("Payment Date:", formattedDate),
          SizedBox(height: 6.h),
          _rowItem("Transaction ID:", payment.transactionId ?? "Pending"),
        ],
      ),
    );
  }

  Widget _rowItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF4E4E4A))),
        Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.black87)),
      ],
    );
  }
}

class PaginationSection extends StatelessWidget {
  const PaginationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentsController>();
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: controller.currentPage.value > 1 ? () => controller.goPreviousPage() : null,
              icon: const Icon(Icons.chevron_left),
            ),
            ...List.generate(controller.totalPages.value, (index) {
              final page = index + 1;
              final isCurrent = page == controller.currentPage.value;
              return GestureDetector(
                onTap: () => controller.goToPage(page),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isCurrent ? const Color(0xFF8A9198) : Colors.transparent,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text("$page",
                      style: TextStyle(color: isCurrent ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
                ),
              );
            }),
            IconButton(
              onPressed: controller.currentPage.value < controller.totalPages.value ? () => controller.goNextPage() : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      );
    });
  }
}