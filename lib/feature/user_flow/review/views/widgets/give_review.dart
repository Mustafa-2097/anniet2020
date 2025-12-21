import 'package:anniet2020/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/review_page_controller.dart';

class GiveReview extends StatefulWidget {
  final String lessonId;
  const GiveReview({super.key, required this.lessonId});
  @override
  State<GiveReview> createState() => _GiveReviewState();
}

class _GiveReviewState extends State<GiveReview> {
  int selectedStars = 0;
  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h, bottom: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Close button + Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, size: 22.r, color: AppColors.blackColor),
              ),
              Text(
                "Give a Review",
                style: GoogleFonts.plusJakartaSans(fontSize: 20.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
              ),
              SizedBox(width: 30),
            ],
          ),
          SizedBox(height: 16.h),

          /// Star Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    selectedStars = index + 1;
                  });
                },
                icon: Icon(
                  selectedStars > index ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 40.r,
                ),
              );
            }),
          ),
          SizedBox(height: 20.h),

          Text("Detail Review", style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor)),
          SizedBox(height: 8.h),

          /// Review TextField
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: TextField(
              controller: reviewController,
              maxLines: 5,
              style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Your review…",
                hintStyle: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.boxTextColor),
              ),
            ),
          ),
          SizedBox(height: 30.h),

          /// Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (selectedStars == 0) {
                  Get.snackbar("Error", "Please select a rating!",backgroundColor: AppColors.redColor);
                  return;
                }

                if (reviewController.text.trim().isEmpty) {
                  Get.snackbar("Error", "Please write a review!", backgroundColor: AppColors.redColor);
                  return;
                }

                final controller =
                Get.find<ReviewUserController>(tag: widget.lessonId);

                if (controller.isSubmitting.value) return;

                await controller.submitReview(
                  rating: selectedStars,
                  comment: reviewController.text.trim(),
                );
              },

              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                backgroundColor: AppColors.primaryColor,
              ),
              child: Text(
                "Send Review",
                style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.whiteColor),
              ),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
