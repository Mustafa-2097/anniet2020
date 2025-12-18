import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';

class ReadMorePage extends StatelessWidget {
  final Map<String, dynamic> item;
  const ReadMorePage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.r),
          child: const BackButton(color: Colors.black),
        ),
        title: Text(item["title"], style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Stack(
          children: [
            /// The FULL GREY SCROLL TRACK
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 6.w,
                height: double.infinity,
                color: AppColors.greyColor,
              ),
            ),

            RawScrollbar(
              controller: scrollController,
              thumbColor: AppColors.primaryColor,
              radius: Radius.circular(8.r),
              thickness: 6.w,
              minThumbLength: 134.h,
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    /// PARAGRAPH
                    Text(
                      item["description"],
                      style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.subTextColor, height: 1.5),
                    ),
                    //SizedBox(height: 25.h),

                    /// EXTRA TEXT BLOCKS
                    // Text(
                    //   _dummyText,
                    //   style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.subTextColor, height: 1.5),
                    // ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
