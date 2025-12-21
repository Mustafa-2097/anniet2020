import 'package:anniet2020/core/constant/app_text_styles.dart';
import 'package:anniet2020/core/constant/widgets/primary_button.dart';
import 'package:anniet2020/feature/user_flow/home_page/controllers/home_controller.dart';
import 'package:anniet2020/feature/user_flow/home_page/views/pages/read_more_page.dart';
import 'package:anniet2020/feature/user_flow/payment/views/payment_page.dart';
import 'package:anniet2020/feature/user_flow/profile/controllers/profile_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());
  final profile= Get.put(ProfileController());
  final profileController = Get.find<ProfileController>();

  final List<Map<String, String>> items = [
    {
      "title": "The Don’t Blow Your License Info Video Program",
      "subtitle": "Approximately 30 mins in total",
      "image": "assets/images/home_img01.png",
    },
    {
      "title": "The Don’t Blow Your License Info Video Program",
      "subtitle": "Approximately 30 mins in total",
      "image": "assets/images/home_img02.png",
    },
    {
      "title": "The Don’t Blow Your License Info Video Program",
      "subtitle": "Approximately 30 mins in total",
      "image": "assets/images/home_img03.png",
    },
    {
      "title": "The Don’t Blow Your License Info Video Program",
      "subtitle": "Approximately 30 mins in total",
      "image": "assets/images/home_img04.png",
    },
  ];
  final List<Map<String, dynamic>> driverTypes = [
    {
      "icon": ImagePath.icon01,
      "title": "Professional Drivers",
      "image": ImagePath.homeImg03,
      "description":
      "If you are a Professional Drivers and your livelihood depends on you having Your Licence but you also don’t mind a drink and or you use drugs (illicit or prescribed) then the information the The DBYL Video Info Program is crucial for you. These days Professional Drivers are often randomly tested for Alcohol and Drugs by their employer or Police which is fair enough given the safety implications so having as much information as possible about how long substances stay in your body and the consequences of a Drink or Drug Drive offence is really important for you.\n\n"
          "If you are an Employer and you Employ Drivers (eg Truck Drivers, Couriers, Delivery Drivers, Bus Drivers, Taxi or Uber Drivers etc) then providing the The Don’t Blow Your Licence Info Videos for your Employees  will not only help them make informed decisions about their Alcohol and Drug use in relation to Driving but will also ensure that you as their Employer support them to do so whilst also protecting yourself as any employees in a motor vehicle accident who are subsequently charged with Drink or Drug Driving will not be covered by your insurance and you as their Employer could also be liable to other legal consequences.",
    },
    {
      "icon": ImagePath.icon02,
      "title": "Young Drivers",
      "image": ImagePath.homeImg02,
      "description":
      "Wow getting your licence and becoming independent is so exciting however it’s typically at a time when you may also be experimenting or exposed to Alcohol and Drugs so the timing couldn’t be worse …..especially for your parents!\n\n"
        "So the The Don’t Blow Your Licence Info Video Program has in part been created especially for YOU. To help YOU to navigate this fabulous time of your life which is also unfortunately a potentially a dangerous time in your life.\n\n"
          "So whether you are the Young Person going for your licence or  you are a Parent of someone getting their licence The DBYL Info Video Program is invaluable.",
    },
    {
      "icon": ImagePath.icon03,
      "title": "Female Driver",
      "image": ImagePath.homeImg04,
      "description":
      "There are lots of fabulous things about being a female but how we metabolise Alcohol and Drugs is not one of them. Unfortunately we are more likely to have higher readings even when we consume smaller amounts of alcohol than men and we can also store illicit and prescribed substances in our bodies for longer making the decision to Drive after consuming even small amounts of Alcohol or Drugs potentially unsafe and illegal. So the The DBYL Info Video Program will provide you with the information you need to understand how you could be at risk of a Drink or Drug Drive offence even when you think you are OK to drive.",
    },
    {
      "icon": ImagePath.icon04,
      "title": "Other Drivers",
      "image": ImagePath.homeImg01,
      "description":
      "The DBYL Info Video Program is actually for anyone who Drives and Drinks Alcohol or takes Drugs regardless of age, gender, profession or nationality. The information presented is from the experiences of those who have lost their licences for Drink and Drug Driving and highlights the negative impact such an offence has on any individual Personally Professionally and Legally.\n\n"
      "This program is particularly important for drivers from other countries who in our experience are often unfortunately unaware of our Drink and Drug Drive laws and the Personal Professional and Legal Consequences of such offences. The DBYL Info Video Program ensures they get all the information they need in relation to substance use and driving so they are able to make informed decisions without unknowningly risking their licence.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            /// USER (Image + Name)
            Padding(
              padding: EdgeInsets.only(left: 24.w, top: 16.h, bottom: 20.h),
              child: Row(
                children: [
                  // Profile Image
                  Obx(() {
                    final avatar = profileController.avatarUrl.value;
                    return CircleAvatar(
                      radius: 18.r,
                      backgroundColor: AppColors.boxTextColor,
                      backgroundImage: avatar != null && avatar.isNotEmpty
                          ? NetworkImage(avatar)
                          : null,
                      child: avatar == null || avatar.isEmpty
                          ? Icon(Icons.person, size: 20.r, color: Colors.white)
                          : null,
                    );
                  }),
                  SizedBox(width: 4.w),
                  // User Name
                  Text(
                    "Hello ${profileController.userName.value}",
                    style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
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
                                          color: AppColors.whiteColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        item['subtitle']!,
                                        style: GoogleFonts.plusJakartaSans(color: AppColors.whiteColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 8.h),

                                      // Dot indicators (only this needs Obx)
                                      Obx(() => Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: List.generate(
                                            items.length,
                                            (dotIndex) => Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                                              child: Container(
                                                width: 6.w,
                                                height: 6.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: dotIndex == controller.currentPage.value
                                                      ? AppColors.whiteColor
                                                      : Colors.white.withOpacity(0.4),
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
                      PrimaryButton(text: "Join Now", onPressed: () => Get.to(() => PaymentPage())),

                      SizedBox(height: 10.h),

                      /// Text
                      Text(
                        "So who is the The DBYL Info Video Program actually for:",
                        style: AppTextStyles.body3(
                          context,
                        ).copyWith(color: AppColors.blackColor),
                      ),

                      SizedBox(height: 10.h),

                      /// Video Play
                      Container(
                        height: sh * 0.23,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Obx(() {
                            if (!profileController.isInitialized.value || profileController.chewieController == null) {
                              return const Center(
                                child: CircularProgressIndicator(color: Colors.white),
                              );
                            }
                            return Chewie(
                              controller: profileController.chewieController!,
                            );
                          }),
                        ),
                      ),


                      SizedBox(height: 12.h),

                      /// Boxes
                      GridView.builder(
                        itemCount: driverTypes.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 6.h,
                          childAspectRatio: 1.35,
                        ),
                        itemBuilder: (context, index) {
                          final item = driverTypes[index];
                          return Card(
                            color: AppColors.whiteColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xFFE61043),
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.all(6.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: sw*0.1,
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFEF1E9),
                                          borderRadius: BorderRadius.circular(14.r),
                                        ),
                                        child: Image.asset(item["icon"], fit: BoxFit.contain),
                                      ),
                                      SizedBox(width: sw*0.01),
                                      Expanded(
                                        child: Text(
                                          item["title"],
                                          style: AppTextStyles.body3(context).copyWith(color: AppColors.primaryColor),
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Expanded(
                                    child: Text(
                                      item["description"],
                                      style: GoogleFonts.plusJakartaSans(fontSize: 8.sp, fontWeight: FontWeight.w500, color: AppColors.subTextColor),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () => Get.to(() => ReadMorePage(item: item)),
                                      child: Text(
                                        "Read More",
                                        style: GoogleFonts.plusJakartaSans(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Color(0xFF80D676), decoration: TextDecoration.underline, decorationColor: Color(0xFF80D676)),
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
                      PrimaryButton(text: "Join Now", onPressed: () => Get.to(() => PaymentPage())),
                      SizedBox(height: 10.h),
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
