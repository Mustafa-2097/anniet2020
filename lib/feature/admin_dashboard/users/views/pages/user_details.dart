import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../dashboard/controllers/dashboard_single_user_controller.dart';
import '../../../dashboard/controllers/dashboard_user_suspended_controller.dart';
import '../../../dashboard/model/dashboard_single_user_model.dart';

class UserDetails extends StatelessWidget {
  final String userId; // Pass ID instead of the whole Map

  UserDetails({super.key, required this.userId});

  // Initialize the controller
  final controller = Get.put(DashboardSingleUserController());
  final dashboardSuspendedUsers = Get.put(DashboardUserSuspendedController());

  @override
  Widget build(BuildContext context) {
    // Fetch data when the widget is built
    controller.fetchUserDetail(userId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: AppColors.blackColor),
        elevation: 0,
        title: Text(
          "User Details",
          style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w600, fontSize: 18.sp),
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

        final user = controller.userDetail.value;
        if (user == null) {
          return const Center(child: Text("No user data found"));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ==== USER BASIC INFO CARD ====
              _buildInfoCard(user),

              SizedBox(height: 20.h),

              /// ==== COURSE PROGRESS SECTION ====
              Text("Course Progress",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 10.h),
              ...user.courseProgress.map((course) => _buildCourseCard(course)).toList(),

              SizedBox(height: 20.h),

              /// ==== PAYMENT CARD ====
              _buildPaymentCard(user),

              SizedBox(height: 30.h),

              /// SUSPEND BUTTON
              _buildSuspendButton(userId),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoCard(UserDetail user) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFD2D6D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user.name,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              _statusChip(user.certification ? "Certified" : "Pending"),
            ],
          ),
          SizedBox(height: 4.h),
          Text("User ID: #${user.id.substring(0, 8)}"),
          SizedBox(height: 10.h),
          _infoIconRow(Icons.email, user.email),
          _infoIconRow(Icons.phone, user.phone ?? "Not provided"),
          _infoIconRow(Icons.calendar_today, "Joined: ${user.paidAt != null ? DateFormat('MMM dd, yyyy').format(user.paidAt!) : 'N/A'}"),
        ],
      ),
    );
  }

  Widget _buildCourseCard(CourseProgress course) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFD2D6D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${course.lessons.completed}/${course.lessons.total} Lessons"),
              Text("${course.progress}%"),
            ],
          ),
          SizedBox(height: 6.h),
          LinearProgressIndicator(
            value: course.progress / 100,
            color: course.completed ? Colors.green : Colors.blue,
            backgroundColor: Colors.grey[200],
          ),
          if (course.completed) ...[
            SizedBox(height: 8.h),
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 16),
                SizedBox(width: 4),
                Text("Complete", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            )
          ]
        ],
      ),
    );
  }

  Widget _buildPaymentCard(UserDetail user) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFD2D6D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment Information",
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 12.h),
          _paymentRow("Amount Paid:", "\$${user.amount.toStringAsFixed(2)}"),
          _paymentRow("Subscription:", user.subscribed ? "Active" : "Inactive"),
          _paymentRow("Date:", user.paidAt != null ? DateFormat('MMM dd, yyyy').format(user.paidAt!) : "N/A"),
        ],
      ),
    );
  }

  Widget _infoIconRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          SizedBox(width: 8.w),
          Text(text, style: TextStyle(fontSize: 13.sp)),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    bool isPositive = status == "Certified" || status == "Received";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPositive ? const Color(0xffddedc8) : const Color(0xffdce4ff),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
            color: isPositive ? Colors.green[700] : Colors.blue[700],
            fontSize: 12.sp,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _paymentRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSuspendButton(String userId) {
    // Access the suspended controller
    final suspendController = Get.find<DashboardUserSuspendedController>();

    return Obx(() {
      return InkWell(
        onTap: suspendController.isLoading.value
            ? null // Disable button while loading
            : () => _confirmSuspension(userId, suspendController),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: suspendController.isLoading.value ? Colors.grey[200] : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red),
          ),
          child: Center(
            child: suspendController.isLoading.value
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.red),
            )
                : Text(
              "Suspend Account",
              style: GoogleFonts.plusJakartaSans(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }

// Confirmation Dialog before API call
  void _confirmSuspension(String userId, DashboardUserSuspendedController controller) {
    Get.defaultDialog(
      title: "Confirm Suspension",
      middleText: "Are you sure you want to suspend this user? This action will restrict their access.",
      textConfirm: "Confirm",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back(); // Close dialog
        controller.suspendUser(userId);
      },
    );
  }

}