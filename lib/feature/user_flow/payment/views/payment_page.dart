import 'package:anniet2020/core/constant/image_path.dart';
import 'package:anniet2020/core/constant/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../about/controller/payment_controller.dart';
import '../controllers/stripe_controller.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final StripeController stripeController = Get.put(StripeController());

  var controller = Get.put(PaymentPageController());


  @override
  void initState() {
    super.initState();
    controller.fetchPaymentPage();
  }

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.r),
          child: BackButton(color: AppColors.blackColor),
        ),
        title: Text(
          "Payment",
          style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchPaymentPage();
        },
        child: Obx((){
          final paymentData = controller.paymentPageData.value;

          if (paymentData == null) {
            return const Center(child: CircularProgressIndicator());
          }

          int totalSeconds = paymentData.totalTime ?? 0;
        
          int minutes = totalSeconds ~/ 60;
          int seconds = totalSeconds % 60;
        
          String formattedTime = '${minutes}m $seconds ${seconds == 1 ? 'second' : 'seconds'}';
        
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  /// Profile Section
                  Row(
                    children: [
                      // Avatar Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: Image.asset(ImagePath.payment, height: sh*0.172, width: sw*0.4, fit: BoxFit.cover),
                      ),
            
                      SizedBox(width: sw*0.03),
            
                      // Text Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              paymentData.title ?? 'No title',
                              style: GoogleFonts.plusJakartaSans(fontSize: sw*0.043, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                            ),
            
                            SizedBox(height: 6.h),
            
                            // Text(
                            //   "Dr. Andrew Collins",
                            //   style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600),
                            // ),
            
                            Text(
                              paymentData.description ?? '',
                              style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.subTextColor, fontWeight: FontWeight.w400),
                            ),
            
                            SizedBox(height: 10.h),
            
                            // Rating Row
                            // Row(
                            //   children: [
                            //     Icon(Icons.star, color: Colors.amber, size: 18),
                            //     SizedBox(width: 4),
                            //     Text(
                            //       "4.4",
                            //       style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: Color(0xFFFFCD1A), fontWeight: FontWeight.w600),
                            //     ),
                            //     SizedBox(width: 4),
                            //     Text(
                            //       "(532)",
                            //       style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.subTextColor),
                            //     ),
                            //   ],
                            // ),
            
                            // Time & Lesson Row
                            Row(
                              children: [
                                Text(
                                  formattedTime,
                                  style: GoogleFonts.plusJakartaSans(fontSize: sw*0.032, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                                ),
                                SizedBox(width: sw*0.01),
                                Text(
                                  "•",
                                  style: TextStyle(fontSize: sw*0.064, color: AppColors.primaryColor),
                                ),
                                SizedBox(width: sw*0.01),
                                Text(
                                  "${paymentData.lessons ?? ''} Lesson",
                                  style: GoogleFonts.plusJakartaSans(fontSize: sw*0.032, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            
                  SizedBox(height: 30.h),
            
                  ///
                  Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2.w, color: AppColors.greyColor),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    elevation: 0,
                    color: AppColors.whiteColor,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 24.h, top: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Subtotal
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Cost (GST Included)",
                                style: TextStyle(color: AppColors.subTextColor, fontSize: sw*0.032, fontWeight: FontWeight.w600),
                              ),
            
                              Text(
                                "\$${paymentData.price ?? ''}",
                                style: TextStyle(color: AppColors.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          // SizedBox(height: 24.h),
                          /// Discount
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Discount",
                          //       style: TextStyle(color: AppColors.subTextColor, fontSize: 12.sp, fontWeight: FontWeight.w600),
                          //     ),
                          //     Text(
                          //       "-\$40",
                          //       style: TextStyle(color: AppColors.redColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                          //     ),
                          //   ],
                          // ),
                          //
                          // SizedBox(height: 12.h),
                          // Divider(color: AppColors.greyColor),
                          // SizedBox(height: 12.h),
                          //
                          // Total Cost
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Total Cost",
                          //       style: TextStyle(color: AppColors.blackColor, fontSize: 12.sp, fontWeight: FontWeight.w400),
                          //     ),
                          //
                          //     Text(
                          //       "\$208",
                          //       style: TextStyle(color: AppColors.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),
                  /// Payment Button
                  PrimaryButton(
                    onPressed: () {
                      stripeController.setupStripeAccount();
                    },
                    text: "Payment",
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
