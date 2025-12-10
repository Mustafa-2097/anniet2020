import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

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
        title: Text("Legal and Policies", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
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
                    /// TITLE
                    Text(
                      "Terms",
                      style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                    ),
                    SizedBox(height: 10.h),

                    /// PARAGRAPH (REPEATABLE)
                    Text(
                      _dummyText,
                      style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.subTextColor, height: 1.5),
                    ),
                    SizedBox(height: 25.h),

                    /// SECTION TITLE
                    Text(
                      "Changes to the Service and/or Terms:",
                      style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                    ),
                    SizedBox(height: 10.h),

                    /// MORE TEXT
                    Text(
                      _dummyText,
                      style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.subTextColor, height: 1.5),
                    ),
                    SizedBox(height: 25.h),

                    /// EXTRA TEXT BLOCKS
                    Text(
                      _dummyText,
                      style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.subTextColor, height: 1.5),
                    ),
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

/// Dummy Paragraph Text
const String _dummyText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. "
    "Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. "
    "Odio vulputate est id tincidunt fames.\n\n"
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. "
    "Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. "
    "Odio vulputate est id tincidunt fames.";


