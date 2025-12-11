import 'package:anniet2020/feature/admin_dashboard/contact/views/pages/message_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/popup_button.dart';
import '../controllers/contact_controller.dart';

class ContactPage extends StatelessWidget {
  ContactPage({super.key});
  final controller = Get.put(ContactController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: const BackButton(color: Colors.black),
        title: Text("Contact Request", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Search Bar
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search contact requests...",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.boxTextColor.withOpacity(0.6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.boxTextColor.withOpacity(0.6)),
                ),
                filled: true,
                fillColor: AppColors.whiteColor,
              ),
            ),
          ),
          Divider(thickness: 1.w, color: Color(0xFFD2D6D8)),

          /// Main Content Box
          Expanded(
            child: Container(
              width: 340.w,
              margin: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD2D6D8)),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  /// FIXED HEADER
                  Obx(() {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3F3F3),
                        border: Border(bottom: BorderSide(color: Color(0xFFD2D6D8))),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        "Showing Page ${controller.currentPage.value}-10 of ${controller.totalPages}",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    );
                  }),

                  /// SCROLLABLE AREA: User List + Pagination
                  Expanded(
                    child: Obx(() {
                      final items = controller.users;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: items.length + 1,   // +1 because last item = pagination
                        itemBuilder: (context, index) {
                          // LAST ITEM = Pagination
                          if (index == items.length) {
                            return Column(
                              children: [
                                PaginationSection(),
                              ],
                            );
                          }
                          // NORMAL USER CARD
                          return Column(
                            children: [
                              UserCard(user: items[index]),
                              Divider(height: 1, color: Color(0xFFD2D6D8)),
                            ],
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final Map<String, dynamic> user;
  const UserCard({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row: Name + Menu Btn
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${user["name"]}",
                style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Color(0xFF4E4E4A)),
              ),
              PopupButton(
                onTap: () {
                  Get.to(() => MessageView(
                    user: {
                      "name": "Wilson Levin",
                      "email": "client000@gmail.com",
                      "phone": "088 3343 32437",
                      "Company": "SM Technology",
                      "Interested Employees": "20",
                      "message": "Your message goes here..."
                    },
                  ));
                },
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(user["email"], style: GoogleFonts.plusJakartaSans(color: Colors.grey)),
          SizedBox(height: 4.h),
          Text(user["phone"], style: GoogleFonts.plusJakartaSans(color: Colors.grey)),
          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Company: ", style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Color(0xFF4E4E4A))),
              Text(user["Company"], style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Color(0xFF4E4E4A))),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Interested Employees: ", style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Color(0xFF4E4E4A))),
              Text(user["Interested Employees"], style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Color(0xFF4E4E4A))),
            ],
          ),
        ],
      ),
    );
  }
}

class PaginationSection extends StatelessWidget {
  const PaginationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ContactController>();
    return Obx(() {
      final totalPages = controller.totalPages;
      final currentPage = controller.currentPage.value;
      return Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// LEFT ARROW
            GestureDetector(
              onTap: currentPage > 1 ? controller.goPreviousPage : null,
              child: Icon(
                Icons.chevron_left,
                size: 22.sp,
                color: currentPage > 1 ? Colors.black : Colors.grey,
              ),
            ),

            SizedBox(width: 12.w),

            /// PAGE NUMBERS
            ...List.generate(totalPages, (index) {
              final pageNumber = index + 1;
              final isActive = pageNumber == currentPage;

              return GestureDetector(
                onTap: () => controller.goToPage(pageNumber),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isActive ? Color(0xFF8A9198) : Colors.transparent,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "$pageNumber",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }),

            SizedBox(width: 12.w),

            /// RIGHT ARROW
            GestureDetector(
              onTap: currentPage < totalPages ? controller.goNextPage : null,
              child: Icon(
                Icons.chevron_right,
                size: 22.sp,
                color: currentPage < totalPages ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      );
    });
  }
}

