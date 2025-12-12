import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constant/app_colors.dart';

class ContactMessageView extends StatelessWidget {
  final Map<String, dynamic> user;
  const ContactMessageView({super.key, required this.user});

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
            Text("Contact Request", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
            /// DATE
            Text(
              "December 1, 2025 at 10:30 AM",
              style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.subTextColor),
            ),
          ],
        ),
        actions: [
          Icon(Icons.delete_outline, color: Colors.red),
          SizedBox(width: 16),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1.h, color: Colors.grey.shade300),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------
            // CONTACT INFORMATION CARD
            // ------------------------------
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.blue),
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

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFFEAF2FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Unread",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.sp,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  /// Full Name
                  _infoTitle("Full Name"),
                  _infoText(user["name"]),

                  SizedBox(height: 12),

                  /// Email
                  _infoTitle("Email"),
                  Row(
                    children: [
                      Icon(Icons.email_outlined, color: Colors.grey),
                      SizedBox(width: 6),
                      Expanded(child: _infoText(user["email"])),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// Phone
                  _infoTitle("Phone"),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.grey),
                      SizedBox(width: 6),
                      Expanded(child: _infoText(user["phone"])),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// Company
                  _infoTitle("Company"),
                  Row(
                    children: [
                      Icon(Icons.business, color: Colors.grey),
                      SizedBox(width: 6),
                      Expanded(child: _infoText(user["Company"])),
                    ],
                  ),

                  SizedBox(height: 12),

                  /// Interested Employees
                  _infoTitle("Interested Employees"),
                  Row(
                    children: [
                      Icon(Icons.group_outlined, color: Colors.grey),
                      SizedBox(width: 6),
                      Expanded(child: _infoText(user["Interested Employees"])),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // ------------------------------
            // MESSAGE BOX
            // ------------------------------
            Container(
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
                      Icon(Icons.chat_bubble_outline, color: Colors.blue),
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
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      user["message"] ?? loremText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // ------------------------------
            // REPLY INPUT + BUTTON
            // ------------------------------
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Type your reply here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Color(0xFF4A90E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: Icon(Icons.send, size: 18),
                    label: Text(
                      "Send Reply",
                      style: GoogleFonts.plusJakartaSans(fontSize: 16),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Close",
                    style: GoogleFonts.plusJakartaSans(fontSize: 15),
                  ),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
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


/// Placeholder message
String loremText =
    "he standard lorem ipsum passage has been a printer's friend for centuries. "
    "Like stock photos today, it served as a placeholder for actual content. "
    "The original text comes from Cicero's philosophical work 'De Finibus Bonorum et Malorum,' written in 45 BC.";
