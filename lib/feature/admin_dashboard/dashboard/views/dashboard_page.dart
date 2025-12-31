import 'package:anniet2020/core/constant/app_colors.dart';
import 'package:anniet2020/core/constant/image_path.dart';
import 'package:anniet2020/feature/admin_dashboard/admin_dashboard.dart';
import 'package:anniet2020/feature/admin_dashboard/dashboard/views/widgets/custom_appdrawer.dart';
import 'package:anniet2020/feature/admin_dashboard/users/views/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/widgets/popup_button.dart';
import '../../settings/controllers/get_me_profile_controller.dart';
import '../../users/views/pages/user_details.dart';
import '../controllers/dashboard_overview_controller.dart';
import '../controllers/dashboard_user_controller.dart';
import '../model/dashboard_user_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Initialize Controller
  final controller = Get.put(DashboardOverviewController());
  final dashboardUserController = Get.put(DashboardUserController());

  final TextEditingController searchController = TextEditingController();
  final adminController = Get.put(AdminProfileController());

  @override
  void initState() {
    super.initState();
    // Fetch data when the page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAnalytics();
      dashboardUserController.fetchUsers();
      adminController.fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      drawer: CustomAppDrawer(onLogoutTap: () {}),
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: AppColors.blackColor, size: 24.r),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text("Dashboard", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor)),
        actions: [
          Obx(() {
            final profileData = adminController.profile.value;
            final avatarUrl = profileData?.profile.avatar ?? '';

            return ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: avatarUrl.isNotEmpty
                  ? Image.network(
                avatarUrl,
                height: 40.w,
                width: 40.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  ImagePath.user,
                  height: 40.w,
                  width: 40.w,
                  fit: BoxFit.cover,
                ),
              )
                  : Image.asset(
                ImagePath.user,
                height: 40.w,
                width: 40.w,
                fit: BoxFit.cover,
              ),
            );
          }),

          SizedBox(width: 14.w),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchAnalytics();
            await dashboardUserController.fetchUsers();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Search Bar
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value){
                      dashboardUserController.fetchUsers(
                        // page: 1,
                        searchTerm: value.trim(),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "Search users...",
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
                Divider(thickness: 1.w, color: const Color(0xFFD2D6D8)),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dashboard Overview",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.subTextColor),
                      ),
                      SizedBox(height: 12.h),

                      /// Stat Cards wrapped in Obx to update UI when data arrives
                      Obx(() {

                        if (controller.isError.value) {
                          return Center(child: Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red)));
                        }

                        return Column(
                          children: [
                            StatCard(
                              title: "Total Revenue",
                              value: "\$${controller.totalRevenue.value}",
                              color: const Color(0xFfFFE2E5),
                              icon: Icons.attach_money,
                              circleColor: const Color(0xFF328736),
                              iconColor: AppColors.whiteColor,
                            ),
                            SizedBox(height: 10.h),
                            StatCard(
                              title: "Total Sell",
                              value: "${controller.totalSell.value}",
                              color: const Color(0xFFF9EEE4),
                              icon: Icons.shopping_cart_outlined,
                              circleColor: const Color(0xFFE57931),
                              iconColor: AppColors.whiteColor,
                            ),
                            SizedBox(height: 10.h),
                            StatCard(
                              title: "Total User",
                              value: "${controller.totalUsers.value}",
                              color: const Color(0xFFF3E8FF),
                              icon: Icons.people_outline,
                              circleColor: const Color(0xFF1C2A47),
                              iconColor: AppColors.whiteColor,
                            ),
                            SizedBox(height: 10.h),
                            StatCard(
                              title: "Course Completed By",
                              value: "${controller.totalCompleted.value}",
                              color: const Color(0xFFEBD8FF),
                              icon: Icons.check_circle_outline,
                              circleColor: AppColors.primaryColor,
                              iconColor: AppColors.whiteColor,
                            ),
                          ],
                        );
                      }),

                      SizedBox(height: 16.h),

                      /// User list container
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFD2D6D8)),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F3F3),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.r),
                                  topRight: Radius.circular(12.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Recent User", style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor)),
                                  GestureDetector(
                                    onTap: () {
                                      debugPrint("View All Clicked!");
                                      Get.off(() => UsersPage());
                                    },
                                    child: Text("View All", style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.primaryColor)),
                                  ),
                                ],
                              ),
                            ),

                            Obx(() {
                              if (dashboardUserController.isLoading.value && dashboardUserController.users.isEmpty) {
                                return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
                              }

                              if (dashboardUserController.users.isEmpty) {
                                return const SizedBox(height: 100, child: Center(child: Text("No users found")));
                              }

                              return ListView.separated(
                                shrinkWrap: true, // Use shrinkWrap since it's inside SingleChildScrollView
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: dashboardUserController.users.length > 5 ? 5 : dashboardUserController.users.length,
                                separatorBuilder: (context, index) => Divider(height: 1.h, color: const Color(0xFFD2D6D8)),
                                itemBuilder: (context, index) {
                                  final user = dashboardUserController.users[index];
                                  return UserCard(user: user);
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final Color circleColor;
  final Color iconColor;
  const StatCard({super.key, required this.title, required this.value, required this.color, required this.icon, required this.iconColor, required this.circleColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 30.r,
            backgroundColor: circleColor,
            child: Icon(icon, color: iconColor),
          )
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserData user;
  const UserCard({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${user.name}  —  #${user.id.substring(user.id.length - 5)}", // Showing last 5 chars of ID
                  style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF4E4E4A)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupButton(
                onTap: () {
                  // If UserDetails expects a Map, use user.toJson()
                  Get.to(() => UserDetails(userId: user.id));
                },
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(user.email, style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: Colors.grey)),
          SizedBox(height: 12.h),

          _buildInfoRow("Certification:", user.certification ? "Received" : "Pending"),
          SizedBox(height: 6.h),
          _buildInfoRow("Course:", user.course),
          SizedBox(height: 6.h),
          _buildInfoRow("Subscribed:", user.subscribed ? "Yes" : "No"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w500, color: const Color(0xFF4E4E4A))),
        label == "Certification:"
            ? StatusBadge(status: value)
            : Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF4E4E4A))),
      ],
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    bool isReceived = status == "Received";

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
        color: isReceived ? const Color(0xffddedc8) : const Color(0xffdce4ff),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isReceived ? Colors.green[700] : Colors.blue[700],
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
