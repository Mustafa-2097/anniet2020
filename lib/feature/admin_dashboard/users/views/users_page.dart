import 'package:anniet2020/feature/admin_dashboard/users/views/pages/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../dashboard/controllers/dashboard_user_controller.dart';
import '../../dashboard/model/dashboard_user_model.dart';

class UsersPage extends StatefulWidget {
  UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  // Ensure naming matches your controller class
  final controller = Get.put(DashboardUserController());

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch data when the page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("All Users",
            style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchUsers();
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
                  hintText: "Search users...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const Divider(thickness: 1, color: Color(0xFFD2D6D8)),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.users.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.isError.value) {
                  return Center(child: Text(controller.errorMessage.value));
                }

                return Container(
                  margin: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFD2D6D8)),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      /// Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3F3F3),
                          border: Border(bottom: BorderSide(color: Color(0xFFD2D6D8))),
                        ),
                        child: Text(
                          "Showing Page ${controller.currentPage.value} of ${controller.totalPages.value}",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),

                      /// List
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.users.length + 1,
                          itemBuilder: (context, index) {
                            if (index == controller.users.length) {
                              return const PaginationSection();
                            }
                            return UserCard(user: controller.users[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserData user; // Changed from Map to UserData model
  const UserCard({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFD2D6D8))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${user.name}  —  #${user.id.substring(0, 6)}", // Shortened ID
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4E4E4A)
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => Get.to(() => UserDetails(userId: user.id)),
              ),
            ],
          ),
          Text(user.email, style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontSize: 12.sp)),
          SizedBox(height: 10.h),

          _infoRow("Certification:", user.certification ? "Received" : "Pending"),
          SizedBox(height: 4.h),
          _infoRow("Course:", user.course),
          SizedBox(height: 4.h),
          _infoRow("Subscribed:", user.subscribed ? "Yes" : "No"),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w500)),
        statusBadge(value),
      ],
    );
  }

  Widget statusBadge(String status) {
    bool isPositive = status == "Received" || status == "Yes";
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: isPositive ? const Color(0xffddedc8) : const Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(color: isPositive ? Colors.green : Colors.black54, fontSize: 11.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class PaginationSection extends StatelessWidget {
  const PaginationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardUserController>();
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: controller.currentPage.value > 1 ? () => controller.goPreviousPage() : null,
              icon: const Icon(Icons.chevron_left),
            ),

            // Show dynamic page numbers (limited to 5 for UI safety)
            ...List.generate(controller.totalPages.value, (index) {
              int pageNum = index + 1;
              bool isCurrent = pageNum == controller.currentPage.value;
              return GestureDetector(
                onTap: () => controller.goToPage(pageNum),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isCurrent ? Colors.blueGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text("$pageNum", style: TextStyle(color: isCurrent ? Colors.white : Colors.black)),
                ),
              );
            }).take(5), // Limit dots if totalPages is huge

            IconButton(
              onPressed: controller.currentPage.value < controller.totalPages.value ? () => controller.goNextPage() : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      );
    });
  }
}