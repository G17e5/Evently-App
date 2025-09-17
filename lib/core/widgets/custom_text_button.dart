import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, required this.onTap,  this.textAlign = TextAlign.center});

  final String text;
  final VoidCallback onTap;
 final  TextAlign textAlign ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign:textAlign,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w900,
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
