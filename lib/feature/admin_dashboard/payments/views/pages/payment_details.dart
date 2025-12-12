import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';

class PaymentDetails extends StatelessWidget {
  final Map<String, dynamic>? data;
  const PaymentDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
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
          preferredSize: Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [

            // ------------------------------
            // PAYMENT SUCCESS SECTION
            // ------------------------------
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFE8FBE7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 26),
                      SizedBox(width: 8),
                      Text(
                        "Payment Successful",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Transaction ID: Trd-0001113332",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.sp,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // ------------------------------
            // TOTAL AMOUNT PAID
            // ------------------------------
            Container(
              padding: EdgeInsets.all(16),
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
                  SizedBox(height: 8),

                  Text(
                    "\$328.90",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                  ),

                  SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "12/12/2025 at 02:30 PM",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // ------------------------------
            // CUSTOMER INFORMATION
            // ------------------------------
            _infoCard(
              titleIcon: Icons.person,
              title: "Customer Information",
              children: [
                _infoTitle("Full Name"),
                _infoValue("Wilson Levin"),

                SizedBox(height: 10),
                _infoTitle("Email"),
                _rowIconText(Icons.email_outlined, "client000@gmail.com"),

                SizedBox(height: 10),
                _infoTitle("Phone"),
                _rowIconText(Icons.phone, "+1 (555) 123-4567"),

                SizedBox(height: 10),
                _infoTitle("Booking ID"),
                _infoValue("#12345"),
              ],
            ),

            SizedBox(height: 20),

            // ------------------------------
            // COURSE INFORMATION
            // ------------------------------
            _infoCard(
              titleIcon: Icons.menu_book_outlined,
              title: "Course Information",
              children: [
                _infoTitle("Course Name"),
                _infoValue("Don’t Blow Your Licence"),

                SizedBox(height: 10),
                _infoTitle("Duration"),
                _infoValue("1hour 30 minute"),

                SizedBox(height: 10),
                _infoTitle("Payment Type"),
                _infoValue("Full Payment"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({required IconData titleIcon, required String title, required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.all(16),
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
              SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
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
        Icon(icon, color: Colors.grey),
        SizedBox(width: 6),
        Expanded(child: _infoValue(text)),
      ],
    );
  }
}
