import 'package:anniet2020/feature/admin_dashboard/Educate/views/pages/educate_message_view.dart';
import 'package:anniet2020/feature/admin_dashboard/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/popup_button.dart';
import '../controllers/educate_controller.dart';
import '../model/educated_model.dart';

class EducatePage extends StatelessWidget {
  EducatePage({super.key});

  final controller = Get.put(EducateEmployeeController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: () => Get.to(() => AdminDashboard(initialIndex: 0)),
          icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
        ),
        title: Text(
          "Educate Request",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchEducateEmployees();
        },
        child: Column(
          children: [
            /// Search Bar (UI only for now)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
              child: TextField(
                controller: searchController,
                onChanged: (value){
                  controller.fetchEducateEmployees(
                    searchTerm: value.trim(),
                  );
                },
                decoration: InputDecoration(
                  hintText: "Search educate requests...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),

            const Divider(),

            /// Main Box
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD2D6D8)),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    /// HEADER
                    Obx(() {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3F3F3),
                          border: Border(
                            bottom: BorderSide(color: Color(0xFFD2D6D8)),
                          ),
                        ),
                        child: Text(
                          "Showing Page ${controller.currentPage.value} of ${controller.totalPages.value}",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      );
                    }),

                    /// LIST + PAGINATION
                    Expanded(
                      child: Obx(() {
                        if (controller.isLoading.value &&
                            controller.employeeList.isEmpty) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (controller.employeeList.isEmpty) {
                          return const Center(child: Text("No educate requests found"));
                        }

                        final items = controller.employeeList;

                        return ListView.builder(
                          itemCount: items.length + 1,
                          itemBuilder: (context, index) {
                            if (index == items.length) {
                              return const PaginationSection();
                            }
                            return Column(
                              children: [
                                EducateUserCard(data: items[index]),
                                const Divider(height: 1),
                              ],
                            );
                          },
                        );
                      }),
                    ),
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


class EducateUserCard extends StatelessWidget {
  final EducateEmployeeData data;

  const EducateUserCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Name + Menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.name,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              PopupButton(
                onTap: () {
                  Get.to(() => EducateMessageView(educateId: data.id,));
                },
              ),
            ],
          ),

          SizedBox(height: 6.h),
          Text(data.email, style: const TextStyle(color: Colors.grey)),
          Text(data.phone ?? "No phone", style: const TextStyle(color: Colors.grey)),

          SizedBox(height: 10.h),

          _infoRow("Company", data.company ?? "N/A"),
          _infoRow("Interested Employees", "${data.employeeCount ?? 0}"),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$label:",
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
        Text(value,
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
      ],
    );
  }
}


class PaginationSection extends StatelessWidget {
  const PaginationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EducateEmployeeController>();

    return Obx(() {
      final totalPages = controller.totalPages.value;
      final currentPage = controller.currentPage.value;

      if (totalPages <= 1) return const SizedBox.shrink();

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: currentPage > 1
                  ? controller.goPreviousPage
                  : null,
              icon: const Icon(Icons.chevron_left),
            ),

            ...List.generate(totalPages, (index) {
              final page = index + 1;
              final isActive = page == currentPage;

              return GestureDetector(
                onTap: () => controller.goToPage(page),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF8A9198) : Colors.transparent,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "$page",
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),

            IconButton(
              onPressed: currentPage < totalPages
                  ? controller.goNextPage
                  : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      );
    });
  }
}


