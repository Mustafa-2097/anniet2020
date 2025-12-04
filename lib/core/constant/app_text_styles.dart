import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle header28(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return TextStyle(
      color: AppColors.textColor,
      fontFamily: 'Roboto',
      fontSize: sw * 0.0712,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle h1Bold_24(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return TextStyle(
      color: AppColors.textColor,
      fontFamily: 'Roboto',
      fontSize: sw * 0.061,
      fontWeight: FontWeight.w700,
    );
  }
  static TextStyle h1Bold24 = TextStyle(
    color: AppColors.textColor,
    fontFamily: 'Roboto',
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle h224 = TextStyle(
    color: AppColors.textColor,
    fontFamily: 'Roboto',
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle h320 = TextStyle(
    color: AppColors.textColor,
    fontFamily: 'Roboto',
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle regular_18(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return TextStyle(
      color: AppColors.textColor,
      fontFamily: 'Roboto',
      fontSize: sw * 0.046,
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle regular18 = TextStyle(
    color: AppColors.textColor,
    fontFamily: 'Roboto',
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle regular16 = TextStyle(
    color: AppColors.textColor,
    fontFamily: 'Roboto',
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle medium16 = TextStyle(
    color: AppColors.textColor,
    fontFamily: "Roboto",
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bold16 = TextStyle(
    color: AppColors.textColor,
    fontFamily: "Roboto",
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle regular14 = TextStyle(
    color: AppColors.textColor,
    fontFamily: 'Roboto',
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle medium14 = TextStyle(
    color: AppColors.subTextColor,
    fontFamily: "Roboto",
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle mediumSub14 = TextStyle(
    color: AppColors.blackColor,
    fontFamily: "Roboto",
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle navBar = TextStyle(
    color: AppColors.textColor,
    fontFamily: "Roboto",
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );


  static TextStyle textStyle30WhiteW600 = GoogleFonts.poppins(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
  // static TextStyle textStyle15WhiteW400 = GoogleFonts.inter(
  //   color: Colors.white,
  //   fontSize: 15,
  //   fontWeight: FontWeight.w400,
  // );
  //
  //
  // /// for item name and user name responsiveness
  // static TextStyle textStyle18black(BuildContext context) {
  //   final screenWidth = MediaQuery.of(context).size.width;
  //   return GoogleFonts.inter(
  //     color: AppColors.black,
  //     fontSize: 18 * (screenWidth / 410),
  //     fontWeight: FontWeight.w600,
  //   );
  // }
  //
  // static TextStyle textStyle14blackW800 = GoogleFonts.inter(
  //   color: AppColors.black,
  //   fontSize: 15,
  //   fontWeight: FontWeight.w700,
  // );
  // static TextStyle textStyle14greenW500(BuildContext context) {
  //   final screenWidth = MediaQuery.of(context).size.width;
  //   return GoogleFonts.inter(
  //     color: AppColors.primaryGreen,
  //     fontSize: 14 * (screenWidth / 400),
  //     fontWeight: FontWeight.w500,
  //   );
  // }

}