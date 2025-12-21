import 'package:anniet2020/feature/admin_dashboard/reivew/models/dashboard_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';

class ReviewCard extends StatelessWidget {
  final CourseReview review; // single review
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundImage: review.user.avatar != null
                    ? NetworkImage(review.user.avatar!)
                    : null,
                child: review.user.avatar == null
                    ? Text(
                  review.user.name[0],
                  style: TextStyle(color: Colors.white),
                )
                    : null,
              ),
              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.user.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "${review.createdAt.toLocal().toString().split(' ')[0]}  •  Lesson ${review.lesson.order}",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        color: AppColors.boxTextColor,
                      ),
                    ),
                    SizedBox(height: 2.h),

                    /// Stars
                    Row(
                      children: List.generate(
                        5,
                            (index) => Icon(
                          index < review.rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 16.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Icon(Icons.more_vert, size: 18, color: Colors.grey),
            ],
          ),

          SizedBox(height: 8.h),

          /// Comment
          Text(
            review.comment,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.sp,
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
