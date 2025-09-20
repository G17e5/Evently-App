import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/widgets/tab_item.dart';
import 'package:event_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTapBar extends StatefulWidget {
  const CustomTapBar({super.key,required this.categories, required this.selectedTaBbgColors,required this.selectedTaFgColors,required this.unselectedTaBbgColors, required this.unselectedTaFgColors});
   final Color selectedTaBbgColors;
   final Color selectedTaFgColors;
   final Color unselectedTaBbgColors;
   final Color unselectedTaFgColors;
   final List<CategoryModel> categories;


  @override
  State<CustomTapBar> createState() => _CustomTapBarState();
}

class _CustomTapBarState extends State<CustomTapBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        onTap: (index){
          selectedIndex =index ;
          setState(() {

          });
        },
        padding: REdgeInsets.symmetric( vertical: 16),
        isScrollable: true,
        indicatorColor: Colors.transparent,
        tabs: widget.categories
            .map(
              (category) => Tab(
            child: TabItem(
              selectedTaBbgColors: widget.selectedTaBbgColors,
              selectedTaFgColors: widget.selectedTaFgColors,
              unselectedTaBbgColors: widget.unselectedTaBbgColors,
              unselectedTaFgColors: widget.unselectedTaFgColors ,
              isSelected: selectedIndex == CategoryModel.categoriesWithAll.indexOf(category),
              category: category,
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}
