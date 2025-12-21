import 'package:anniet2020/feature/admin_dashboard/reivew/views/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../Controller/dashboard_review_controller.dart';

class ReviewAdminPage extends StatelessWidget {
  ReviewAdminPage({super.key});

  final controller = Get.put(DashboardReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: (){
            Get.back();
          }
        ),
        title: Text(
          "Lessons Reviews",
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          /// Top Card with Average Rating
          Container(
            height: 300.h,
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff0A4C9C), Color(0xff0A6AC0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Obx(() {
              return Card(
                elevation: 0,
                color: Color(0xFF2074B6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Top Row
                      Row(
                        children: [
                          Text(
                            controller.averageRating.value.toStringAsFixed(1),
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.whiteColor),
                          ),
                          SizedBox(width: 6.w),
                          Icon(Icons.trending_up, color: Colors.white),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              "Excellent",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12.sp,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),

                      /// Stars
                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(
                            index < controller.averageRating.value.floor()
                                ? Icons.star
                                : Icons.star_half,
                            color: Colors.amber,
                            size: 20.r,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),

                      /// Total Reviews
                      Text(
                        "${controller.reviews.length} total reviews",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.sp, color: Colors.white70),
                      ),
                      SizedBox(height: 6.h),

                      /// Rating Breakdown
                      ...controller.ratingCounts.entries.map(
                            (e) => RatingProgressRow(
                          star: e.key,
                          count: e.value,
                          progress: controller.getProgress(e.key),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: 12.h),

          /// Filter Chips
          SizedBox(
            height: 40.h,
            child: Obx(() => ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                ReviewFilterChip(
                  label: "All (${controller.reviews.length})",
                  isSelected: controller.selectedFilter.value == 0,
                  onTap: () => controller.selectedFilter.value = 0,
                ),
                ...controller.ratingCounts.entries.map(
                      (e) => ReviewFilterChip(
                    label: "★ ${e.key} (${e.value})",
                    isSelected: controller.selectedFilter.value == e.key,
                    onTap: () => controller.selectedFilter.value = e.key,
                  ),
                ),
              ],
            )),
          ),

          SizedBox(height: 12.h),

          /// Review List
          Expanded(
            child: Obx(() {
              final reviews = controller.filteredReviews;
              if (reviews.isEmpty) {
                return Center(child: Text("No reviews found"));
              }
              return ListView.separated(
                itemCount: reviews.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1.h, color: Colors.grey.shade300),
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return ReviewCard(review: review);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// Rating Progress Row
class RatingProgressRow extends StatelessWidget {
  final int star;
  final int count;
  final double progress;

  const RatingProgressRow(
      {super.key, required this.star, required this.count, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            child: Text(
              "$star ★",
              style: GoogleFonts.plusJakartaSans(
                  color: AppColors.whiteColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6.h,
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            count.toString(),
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.whiteColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Filter Chip Widget
class ReviewFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ReviewFilterChip(
      {super.key, required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
