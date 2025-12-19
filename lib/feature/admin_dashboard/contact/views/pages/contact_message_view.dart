import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constant/app_colors.dart';
import '../../controllers/single_contact_controller.dart';

class ContactMessageView extends StatelessWidget {
  final String contactId;

  ContactMessageView({super.key, required this.contactId});

  // Initialize Controller
  final controller = Get.put(ContactDetailController());

  // Controller for the reply text field
  final TextEditingController replyTextController = TextEditingController();


  void _showDeleteConfirmation(BuildContext context) {
    Get.defaultDialog(
      title: "Delete Contact",
      middleText: "Are you sure you want to delete this contact request? This action cannot be undone.",
      textConfirm: "Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back(); // Close dialog
        controller.deleteContact(contactId); // Call delete method
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchContactDetail(contactId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.blackColor),
        title: Obx(() {
          final data = controller.contactDetail.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact Request",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
              if (data != null)
                Text(
                  DateFormat('MMMM dd, yyyy at hh:mm a').format(data.createdAt),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.sp,
                    color: AppColors.subTextColor,
                  ),
                ),
            ],
          );
        }),
        actions: [
          Obx(() => IconButton(
            icon: controller.isDeleting.value
                ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.red))
                : const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _showDeleteConfirmation(context),
          )),
          const SizedBox(width: 16),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1.h, color: Colors.grey.shade300),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.isError.value) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final data = controller.contactDetail.value;
        if (data == null) {
          return const Center(child: Text("No details found."));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactInfoCard(data),
              SizedBox(height: 20.h),
              _buildMessageBox(data.message),
              SizedBox(height: 20.h),
              _buildReplySection(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildContactInfoCard(dynamic data) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.blue),
                  const SizedBox(width: 6),
                  Text("Contact Information",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp, fontWeight: FontWeight.w600)),
                ],
              ),
              _buildStatusBadge(),
            ],
          ),
          const SizedBox(height: 16),
          _infoTitle("Full Name"),
          _infoText(data.name),
          const SizedBox(height: 12),
          _infoTitle("Email"),
          _rowIconText(Icons.email_outlined, data.email),
          const SizedBox(height: 12),
          _infoTitle("Phone"),
          _rowIconText(Icons.phone, data.phone ?? "N/A"),
          const SizedBox(height: 12),
          _infoTitle("Contact ID"),
          _rowIconText(Icons.tag, data.id),
        ],
      ),
    );
  }

  Widget _buildReplySection() {
    return Column(
      children: [
        TextField(
          controller: replyTextController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Type your reply here...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Obx(() {
                final isReplying = controller.isReplying.value;
                return ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFF4A90E2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  icon: isReplying
                      ? SizedBox(
                      height: 20.r,
                      width: 20.r,
                      child: const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2))
                      : const Icon(Icons.send, size: 18, color: Colors.white),
                  label: Text(
                    isReplying ? "Sending..." : "Send Reply",
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16, color: Colors.white),
                  ),
                  onPressed: isReplying
                      ? null
                      : () async {
                    final success = await controller.sendReply(
                        contactId, replyTextController.text);
                    if (success) replyTextController.clear();
                  },
                );
              }),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Text("Close",
                  style: GoogleFonts.plusJakartaSans(fontSize: 15)),
              onPressed: () => Get.back(),
            ),
          ],
        )
      ],
    );
  }

  // --- Helper Widgets ---

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text("Received",
          style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp, color: const Color(0xFF3B82F6))),
    );
  }

  Widget _buildMessageBox(String message) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.chat_bubble_outline, color: Colors.blue),
              const SizedBox(width: 6),
              Text("Message",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8)),
            child: Text(message,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp, color: Colors.grey.shade700)),
          ),
        ],
      ),
    );
  }

  Widget _infoTitle(String text) => Text(text,
      style: GoogleFonts.plusJakartaSans(
          fontSize: 12.sp, color: Colors.grey.shade600));

  Widget _infoText(String text) => Text(text,
      style: GoogleFonts.plusJakartaSans(
          fontSize: 14.sp, fontWeight: FontWeight.w600));

  Widget _rowIconText(IconData icon, String text) => Row(
    children: [
      Icon(icon, color: Colors.grey, size: 18),
      const SizedBox(width: 6),
      Expanded(child: _infoText(text)),
    ],
  );
}