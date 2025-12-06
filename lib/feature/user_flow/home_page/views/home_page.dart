import 'package:anniet2020/core/constant/app_text_styles.dart';
import 'package:anniet2020/core/constant/widgets/primary_button.dart';
import 'package:anniet2020/feature/user_flow/home_page/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomeController());
  final List<Map<String, String>> items = [
    {
      "title": "The Don’t Blow Your License Info Video Program",
      "subtitle": "Approximately 30 mins in total",
      "image": "assets/images/home_img01.png",
    },
    {
      "title": "Next Video Program Title",
      "subtitle": "Approximately 45 mins in total",
      "image": "assets/images/home_img01.png",
    },
    {
      "title": "Another Video Program",
      "subtitle": "Approximately 25 mins in total",
      "image": "assets/images/home_img01.png",
    },
  ];

  final List<Map<String, dynamic>> driverTypes = [
    {
      "icon": Icons.person, // replace with your custom icon or svg if needed
      "title": "Professional Drivers",
      "description":
      "If you drive for a living or if you Employ Drivers and don't mind drink and or you use drugs then this program is a must.",
    },
    {
      "icon": Icons.drive_eta,
      "title": "Young Drivers",
      "description":
      "Young Drivers who are inexperienced on the roads at the same time they are likely to be exposed to and or experimenting with Alcohol and Drugs.",
    },
    {
      "icon": Icons.female,
      "title": "Female Driver",
      "description":
      "Female Drivers of any age as females metabolite Alcohol and Drugs differently to males, we will teach you what you need to be aware of.",
    },
    {
      "icon": Icons.group,
      "title": "Other Drivers",
      "description":
      "Anyone who Drives, Drinks Alcohol and or takes Drugs (illicit and prescribed) including older more experienced drivers.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.textColor,
      body: SafeArea(
        child: Column(
          children: [
            /// USER (Image + Name)
            Padding(
              padding: EdgeInsets.only(left: 24.w, top: 16.h, bottom: 20.h),
              child: Row(
                children: [
                  Image.asset(ImagePath.user, width: sw * 0.08),
                  SizedBox(width: 4.w),
                  Text(
                    "Hello Alisa",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      /// Cards (PageView)
                      SizedBox(
                        height: sh * 0.189,
                        child: PageView.builder(
                          controller: controller.pageController,
                          itemCount: items.length,
                          onPageChanged: (index) =>
                              controller.currentPage.value = index,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Stack(
                              children: [
                                // Background image
                                Container(
                                  width: sw * 0.872,
                                  height: sh * 0.189,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    image: DecorationImage(
                                      image: AssetImage(item['image']!),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.35),
                                        BlendMode.darken,
                                      ),
                                    ),
                                  ),
                                ),

                                // Overlay container
                                Container(
                                  width: 327.w,
                                  height: sh * 0.189,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 8.h,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title']!,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: AppColors.textColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        item['subtitle']!,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: AppColors.textColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),

                                      // Dot indicators (only this needs Obx)
                                      Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                            items.length,
                                            (dotIndex) => Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 3.w,
                                              ),
                                              child: Container(
                                                width: 6.w,
                                                height: 6.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      dotIndex ==
                                                          controller
                                                              .currentPage
                                                              .value
                                                      ? AppColors.textColor
                                                      : Colors.white.withOpacity(
                                                          0.4,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 10.h),

                      /// Join Now Button
                      PrimaryButton(text: "Join Now", onPressed: () {}),

                      SizedBox(height: 10.h),

                      /// Text
                      Text(
                        "So who is the The DBYL Info Video Program actually for:",
                        style: AppTextStyles.body3(
                          context,
                        ).copyWith(color: AppColors.blackColor),
                      ),

                      SizedBox(height: 10.h),

                      ///
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(ImagePath.videoPlay, height: sh * 0.189, width: sw * 0.872, fit: BoxFit.cover),
                      ),

                      SizedBox(height: 12.h),

                      /// Boxes
                      GridView.builder(
                        itemCount: driverTypes.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 6.h,
                          childAspectRatio: 1.3,
                        ),
                        itemBuilder: (context, index) {
                          final item = driverTypes[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xFFE61043),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.r),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade100.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      item["icon"],
                                      color: Colors.red.shade400,
                                      size: 28.sp,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    item["title"],
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Expanded(
                                    child: Text(
                                      item["description"],
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 12.sp,
                                      ),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        // TODO: handle Read More tap, e.g. navigate or expand text
                                        debugPrint(
                                          "Read More tapped on ${item["title"]}",
                                        );
                                      },
                                      child: Text(
                                        "Read More",
                                        style: TextStyle(
                                          color: Colors.green.shade600,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 10.h),

                      /// Join Now Button
                      PrimaryButton(text: "Join Now", onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
