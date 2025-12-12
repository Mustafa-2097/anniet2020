import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';

class UserDetails extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ==== USER BASIC INFO CARD ====
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Color(0xFFD2D6D8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user["name"] ?? "",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      _statusChip(user["cert"]),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text("Booking ID: #${user['id']}"),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(Icons.email, size: 18),
                      SizedBox(width: 6),
                      Text("${user['email']}"),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 18),
                      SizedBox(width: 6),
                      Text("${user['phone'] ?? '+1 (555) 123-4567'}"),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 18),
                      SizedBox(width: 6),
                      Text("Joined: Jan 15, 2024"),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.circle, size: 10, color: Colors.green),
                      SizedBox(width: 6),
                      Text("Last active: 2 hours ago"),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 20.h),

            /// ==== COURSE PROGRESS CARD ====
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Color(0xFFD2D6D8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Course Progress",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  Text("Don't Blow Your Licence"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("06/06 Lessons"),
                      Text("100%"),
                    ],
                  ),
                  SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: 1,
                    color: Colors.green,
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 4),
                      Text("Status: Complete",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.green)),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 20.h),

            /// ==== PAYMENT CARD ====
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Color(0xFFD2D6D8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Information",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 12),
                  _paymentRow("Amount:", "\$299.00"),
                  _paymentRow("Status:", user["payment"]),
                  _paymentRow("Payment Date:", "Jan 15, 2026"),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            /// SUSPEND BUTTON
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red),
              ),
              child: Center(
                child: Text(
                  "Suspend Account",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// STATUS CHIP
  Widget _statusChip(String status) {
    bool received = status == "Received";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: received ? Color(0xffddedc8) : Color(0xffdce4ff),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
            color: received ? Colors.green[700] : Colors.blue[700],
            fontWeight: FontWeight.w600),
      ),
    );
  }

  /// PAYMENT ROW
  Widget _paymentRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
              TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
          Text(value,
              style:
              TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
        ],
      ),
    );
  }
}
