import 'package:anniet2020/feature/user_flow/profile/controllers/help_support_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/app_colors.dart';

class HelpSupportPage extends StatelessWidget {
  HelpSupportPage({super.key});
  final controller = Get.put(HelpSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.r),
          child: BackButton(color: AppColors.blackColor),
        ),
        title: Text(
          "Help and Support",
          style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
        child: ListView.separated(
          itemCount: controller.faqList.length,
          separatorBuilder: (_, __) => Divider(
            thickness: 1.3.w,
            color: AppColors.boxTextColor,
            height: 40.h,
          ),
          itemBuilder: (context, index) {
            return Obx(() {
              final isExpanded = controller.expandedIndex.value == index;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => controller.toggleExpand(index),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            controller.faqList[index]["title"]!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: isExpanded ? AppColors.primaryColor : AppColors.blackColor,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 24.r,
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                  if (isExpanded) ...[
                    SizedBox(height: 10.h),
                    Text(
                      controller.faqList[index]["content"]!,
                      style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w400, height: 1.5, color: AppColors.boxTextColor),
                    ),
                  ],
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
