import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
    useMaterial3: false,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.whiteBlue,
      foregroundColor: ColorsManager.blue,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.blue,
      ),
    ),
    scaffoldBackgroundColor: ColorsManager.whiteBlue,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.gray, width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue, width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.red, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.red, width: 1.w),
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.gray,
      ),
      prefixIconColor: ColorsManager.gray,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: ColorsManager.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: ColorsManager.blue,
      shape: CircularNotchedRectangle(),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.blue,
      foregroundColor: ColorsManager.white,
      shape: StadiumBorder(
        side: BorderSide(color: ColorsManager.white, width: 4.w),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: REdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: ColorsManager.blue,
        foregroundColor: ColorsManager.white,
        textStyle: GoogleFonts.inter(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: ColorsManager.white,
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white,
      ),
      headlineLarge:GoogleFonts.inter(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: ColorsManager.white,
    ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.blue,
      ),
      titleSmall:GoogleFonts.inter(fontSize:14.sp ,fontWeight: FontWeight.bold , color: ColorsManager.black1C),
      bodySmall: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.black,
      ),
    ),
  );
  static final ThemeData dark = ThemeData();
}
