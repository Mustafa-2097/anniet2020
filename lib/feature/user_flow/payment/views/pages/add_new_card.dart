// import 'package:anniet2020/core/constant/app_colors.dart';
// import 'package:anniet2020/core/constant/app_text_styles.dart';
// import 'package:anniet2020/core/constant/widgets/primary_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:get/get.dart';
// import '../../controllers/add_new_card_controller.dart';
//
// class AddNewCard extends StatelessWidget {
//   AddNewCard({super.key});
//
//   final AddNewCardController controller = Get.put(AddNewCardController());
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//
//       /// AppBar
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColors.whiteColor,
//         leading: Padding(
//           padding: EdgeInsets.only(left: 20.r),
//           child: const BackButton(color: Colors.black),
//         ),
//         title: Text(
//           "Add New Card",
//           style: GoogleFonts.plusJakartaSans(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//             color: AppColors.blackColor,
//           ),
//         ),
//         centerTitle: true,
//       ),
//
//       /// Body
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//         child: Column(
//           children: [
//             Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   /// Card Number
//                   _fieldLabel("Card Number", context),
//                   SizedBox(height: 6.h),
//                   TextFormField(
//                     controller: controller.cardNumberController,
//                     keyboardType: TextInputType.number,
//                     maxLength: 16,
//                     decoration: _inputDecoration("1234 5678 1234 5678"),
//                     validator: controller.validateCardNumber,
//                   ),
//
//                   SizedBox(height: 15.h),
//
//                   /// Card Holder Name
//                   _fieldLabel("Card Holder Name", context),
//                   SizedBox(height: 6.h),
//                   TextFormField(
//                     controller: controller.cardHolderNameController,
//                     decoration: _inputDecoration("Enter Holder Name"),
//                     validator: controller.validateHolderName,
//                   ),
//
//                   SizedBox(height: 15.h),
//
//                   /// Expiry + CVV
//                   Row(
//                     children: [
//                       /// Expiry Date
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _fieldLabel("Expiry Date", context),
//                             SizedBox(height: 6.h),
//                             TextFormField(
//                               controller: controller.expiryController,
//                               keyboardType: TextInputType.number,
//                               maxLength: 5,
//                               decoration: _inputDecoration("MM/YY"),
//                               validator: controller.validateExpiry,
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       SizedBox(width: 12.w),
//
//                       /// CVV Code
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _fieldLabel("CVV Code", context),
//                             SizedBox(height: 6.h),
//                             TextFormField(
//                               controller: controller.cvvController,
//                               keyboardType: TextInputType.number,
//                               obscureText: true,
//                               maxLength: 3,
//                               decoration: _inputDecoration("***"),
//                               validator: controller.validateCVV,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             const Spacer(),
//
//             /// Add Card Button
//             PrimaryButton(
//               onPressed: () => controller.saveCard(_formKey),
//               text: "Add Card",
//             ),
//             SizedBox(height: 20.h),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Common Label
//   Widget _fieldLabel(String text, BuildContext context) {
//     return Text(
//       text,
//       style: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor),
//     );
//   }
//
//   /// Common Input Decoration
//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       counterText: "",
//       hintText: hint,
//       hintStyle: AppTextStyles.body3(Get.context!),
//       filled: true,
//       fillColor: const Color(0xFFF6F6F6),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(24.r),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
// }
