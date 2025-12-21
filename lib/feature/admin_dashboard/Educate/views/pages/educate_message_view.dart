import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constant/app_colors.dart';
import '../../controllers/education_single_controller.dart';

class EducateMessageView extends StatefulWidget {
  final String educateId;

  const EducateMessageView({
    super.key,
    required this.educateId,
  });

  @override
  State<EducateMessageView> createState() => _EducateMessageViewState();
}

class _EducateMessageViewState extends State<EducateMessageView> {

  final controller = Get.put(EducationSingleController());

  final TextEditingController replyTextController = TextEditingController();


  @override
  void initState() {
    super.initState();
    controller.fetchEducateEmployeeDetail(widget.educateId);
  }

  void _showDeleteConfirmation(BuildContext context) {
    Get.defaultDialog(
      title: "Delete Contact",
      middleText: "Are you sure you want to delete this contact request? This action cannot be undone.",
      textConfirm: "Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
        controller.deleteContact(widget.educateId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: AppColors.blackColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Educate Request",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            Obx(() {
              final data = controller.educateDetail.value;
              if (data == null) return const SizedBox();

              // Format the DateTime directly
              final createdAt = data.createdAt;
              final formattedDate = createdAt != null
                  ? "${createdAt.day}/${createdAt.month}/${createdAt.year} at ${createdAt.hour}:${createdAt.minute.toString().padLeft(2, '0')}"
                  : "";

              return Text(
                formattedDate,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.sp,
                  color: AppColors.subTextColor,
                ),
              );
            }),
          ],
        ),
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
          preferredSize: Size.fromHeight(1),
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

        final user = controller.educateDetail.value;
        if (user == null) {
          return const Center(child: Text("No data found"));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// CONTACT INFO
              _contactInfoCard(user),

              SizedBox(height: 20),

              /// MESSAGE
              _messageBox(user.message),

              SizedBox(height: 20),

              /// REPLY
              _replySection(),
            ],
          ),
        );
      }),
    );
  }

  // --------------------------------------------------
  // CONTACT CARD
  // --------------------------------------------------
  Widget _contactInfoCard(user) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.blue),
                  SizedBox(width: 6),
                  Text(
                    "Contact Information",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              _statusChip(),
            ],
          ),

          SizedBox(height: 16),

          _infoTitle("Full Name"),
          _infoText(user.name),

          SizedBox(height: 12),

          _infoTitle("Email"),
          _iconRow(Icons.email_outlined, user.email),

          SizedBox(height: 12),

          _infoTitle("Phone"),
          _iconRow(Icons.phone, user.phone),

          SizedBox(height: 12),

          _infoTitle("Company"),
          _iconRow(Icons.business, user.company),

          SizedBox(height: 12),

          _infoTitle("Interested Employees"),
          _iconRow(Icons.group_outlined, user.employeeCount.toString()),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // MESSAGE BOX
  // --------------------------------------------------
  Widget _messageBox(String? message) {
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
              SizedBox(width: 6),
              Text(
                "Message",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message?.isNotEmpty == true ? message! : loremText,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // REPLY SECTION
  // --------------------------------------------------
  Widget _replySection() {
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
                        widget.educateId, replyTextController.text);
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

  // --------------------------------------------------
  // SMALL HELPERS
  // --------------------------------------------------
  Widget _statusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "Unread",
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12.sp,
          color: const Color(0xFF3B82F6),
        ),
      ),
    );
  }

  Widget _iconRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        SizedBox(width: 6),
        Expanded(child: _infoText(text)),
      ],
    );
  }

  Widget _infoTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 12.sp,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _infoText(String text) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

/// Placeholder
String loremText =
    "The standard lorem ipsum passage has been a printer's friend for centuries...";
