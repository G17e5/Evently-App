import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          decorationColor: ColorsManager.blue,
          textStyle: TextStyle(
            fontStyle: FontStyle.italic,
            color: ColorsManager.blue,
          ),
        ),
      ),
    );
  }
}
