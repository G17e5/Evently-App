import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager{
  static final ThemeData light = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor:ColorsManager.whiteBlue,
      foregroundColor: ColorsManager.blue,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(fontSize:22.sp , fontWeight:FontWeight.w400,color: ColorsManager.blue),
    ),
    scaffoldBackgroundColor: ColorsManager.whiteBlue,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.gray ,width: 1.w) ,
      ),
      focusedBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue,width: 1.w),
      ),
      errorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.red ,width: 1.w) ,
      ),
      focusedErrorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.red ,width: 1.w) ,
      ),
      labelStyle: GoogleFonts.inter(fontSize: 16.sp,fontWeight:FontWeight.w500 , color: ColorsManager.gray ),
      prefixIconColor: ColorsManager.gray,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    padding: REdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r)
      ),
      backgroundColor: ColorsManager.blue ,
      foregroundColor: ColorsManager.white,
      textStyle: GoogleFonts.inter(fontSize: 20.sp,fontWeight: FontWeight.w500,color: ColorsManager.white)
  ),
    ),
    textTheme: TextTheme(
      bodySmall:GoogleFonts.inter(fontSize: 16.sp ,fontWeight: FontWeight.w500 , color: ColorsManager.black)
    ),



  );
  static final ThemeData dark = ThemeData();

}