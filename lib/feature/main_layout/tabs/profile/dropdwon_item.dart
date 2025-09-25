import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdwonItem extends StatelessWidget {
   DropdwonItem({super.key, required this.title, required this.selectedItem, required this.menuItem , required this.onChange});
 final String title ;
 final String selectedItem;
  final List<String> menuItem;
  void Function(String?) onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: 16.h),
          Container(
            height: 66.h,
            padding: REdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color:ColorsManager.blue ,width: 1.w)
            ),
            child: Row(
              children: [
                Text(selectedItem,style:Theme.of(context).textTheme.displayMedium),
                Spacer(),
                DropdownButton(
                  underline: SizedBox(),
                  items:menuItem.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: onChange,
                ),
              ],
            ),

          )
        ],
      ),
    );
  }
}
