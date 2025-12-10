import 'package:anniet2020/core/constant/image_path.dart';
import 'package:anniet2020/feature/user_flow/courses/views/courses_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/widgets/primary_button.dart';
import '../../../dashboard/customer_dashboard.dart';

class PaymentMethod extends StatelessWidget {
  PaymentMethod({super.key});
  final List<Map<String, String>> cards = [
    {
      "logo": ImagePath.mastercard,
      "title": "Mastercard",
      "masked": "Master Card ****2",
    },
    {
      "logo": ImagePath.visa,
      "title": "Visa",
      "masked": "Master Card ****2",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.r),
          child: const BackButton(color: Colors.black),
        ),
        title: Text("Payment Method", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30.r),
            child: Icon(Icons.add, size: 24.r, color: AppColors.blackColor),
          )
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: cards.map((card) {
                return paymentCardTile(
                  logo: card["logo"]!,
                  title: card["title"]!,
                  masked: card["masked"]!,
                  onEdit: () {},
                );
              }).toList(),
            ),

            const Spacer(),

            /// Pay Now Button
            PrimaryButton(onPressed: () => Get.to(() => CustomerDashboard(initialIndex: 1)), text: "Pay Now"),
            SizedBox(height: 10.h),
          ],
        ),
      ),

    );
  }
}

Widget paymentCardTile({
  required String logo,
  required String title,
  required String masked,
  required VoidCallback onEdit,
}) {
  return Column(
    children: [
      Row(
        children: [
          // Logo
          Container(
            height: 48.h,
            width: 48.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(width: 1.3.w, color: AppColors.greyColor)
            ),
            child: Image.asset(logo, width: 20.w, fit: BoxFit.contain),
          ),

          const SizedBox(width: 12),

          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                ),
                SizedBox(height: 2),
                Text(
                  masked,
                  style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.subTextColor),
                ),
              ],
            ),
          ),

          // Edit Icon
          GestureDetector(
            onTap: onEdit,
            child: Image.asset(ImagePath.editIcon, width: 20.w, fit: BoxFit.contain, color: AppColors.blackColor),
          ),
        ],
      ),

      SizedBox(height: 14.h),

      Divider(
        thickness: 1.w,
        color: AppColors.greyColor,
      ),

      SizedBox(height: 10.h),
    ],
  );
}
