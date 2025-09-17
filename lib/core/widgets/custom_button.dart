import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, required this.onPress});
  final String title ;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: REdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)
            ),
            backgroundColor: ColorsManager.blue ,
            foregroundColor: ColorsManager.white,
            textStyle: GoogleFonts.inter(fontSize: 20.sp,fontWeight: FontWeight.w500,color: ColorsManager.white)
        ),
        onPressed: onPress, child:Text(title));
  }
}
