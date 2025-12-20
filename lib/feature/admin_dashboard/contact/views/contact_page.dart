import 'package:anniet2020/feature/admin_dashboard/contact/views/pages/contact_message_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/popup_button.dart';
import '../controllers/contact_controller.dart';
import '../model/contact_model.dart'; // Ensure this is imported

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
        title: Text("Contact Request",
            style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchContacts();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Search Bar
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search contact requests...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
            const Divider(thickness: 1, color: Color(0xFFD2D6D8)),

            /// Main Content Box
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD2D6D8)),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    /// FIXED HEADER
                    Obx(() {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          border: const Border(bottom: BorderSide(color: Color(0xFFD2D6D8))),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Showing Page ${controller.currentPage.value} of ${controller.totalPages.value}",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      );
                    }),

                    /// SCROLLABLE AREA: User List + Pagination
                    Expanded(
                      child: Obx(() {
                        if (controller.isLoading.value && controller.contactList.isEmpty) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (controller.contactList.isEmpty) {
                          return const Center(child: Text("No contact requests found"));
                        }

                        final items = controller.contactList;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: items.length + 1,
                          itemBuilder: (context, index) {
                            if (index == items.length) {
                              return const PaginationSection();
                            }
                            return Column(
                              children: [
                                UserCard(contact: items[index]),
                                const Divider(height: 1, color: Color(0xFFD2D6D8)),
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
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final ContactData contact; // Changed from Map to ContactData
  const UserCard({required this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                contact.name,
                style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: const Color(0xFF4E4E4A)),
              ),
              PopupButton(
                onTap: () {
                  Get.to(() => ContactMessageView(contactId: contact.id));
                },
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(contact.email, style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontSize: 13.sp)),
          SizedBox(height: 4.h),
          Text(contact.phone ?? "No phone provided", style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontSize: 13.sp)),
          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date: ", style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF4E4E4A))),
              Text(
                  DateFormat('MMM dd, yyyy').format(contact.createdAt),
                  style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w500)
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
              "Message Snippet:",
              style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF4E4E4A))
          ),
          SizedBox(height: 2.h),
          Text(
            contact.message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: Colors.grey.shade700),
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
      final totalPages = controller.totalPages.value;
      final currentPage = controller.currentPage.value;

      if (totalPages <= 1) return const SizedBox.shrink();

      return Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: currentPage > 1 ? () => controller.goPreviousPage() : null,
              icon: Icon(Icons.chevron_left, color: currentPage > 1 ? Colors.black : Colors.grey),
            ),
            ...List.generate(totalPages, (index) {
              final pageNumber = index + 1;
              final isActive = pageNumber == currentPage;
              return GestureDetector(
                onTap: () => controller.goToPage(pageNumber),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF8A9198) : Colors.transparent,
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
            IconButton(
              onPressed: currentPage < totalPages ? () => controller.goNextPage() : null,
              icon: Icon(Icons.chevron_right, color: currentPage < totalPages ? Colors.black : Colors.grey),
            ),
          ],
        ),
      );
    });
  }
}