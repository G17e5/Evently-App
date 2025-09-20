import 'package:event_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TabItem extends StatelessWidget {
  const TabItem({super.key, required this.selectedTaBbgColors, required this.selectedTaFgColors, required this.unselectedTaBbgColors, required this.unselectedTaFgColors , required this.isSelected , required this.category});
  final Color selectedTaBbgColors;
  final Color selectedTaFgColors;
  final Color unselectedTaBbgColors;
  final Color unselectedTaFgColors;
  final CategoryModel category;
  final bool isSelected ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? selectedTaBbgColors : unselectedTaBbgColors,
        borderRadius: BorderRadius.circular(36.r),
        border: Border.all(color: selectedTaBbgColors),
      ),
      child: Row(
        children: [
         Icon(category.iconData , color: isSelected ? selectedTaFgColors :unselectedTaFgColors,),
          SizedBox(width: 8.w,),
          Text(category.name, style:GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w500, color: isSelected ? selectedTaFgColors : unselectedTaFgColors) ,)
        ],
      ),
    );
  }
}
