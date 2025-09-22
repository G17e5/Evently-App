import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/feature/main_layout/tabs/home/event_item.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/models/category_model.dart';
import 'package:event_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteTap extends StatelessWidget {
  const FavoriteTap({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: REdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: ColorsManager.blue)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(color: ColorsManager.blue)
                ),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: ColorsManager.blue,
                hintText: appLocalizations.search_for_event,
                hintStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.blue,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h,),
          Expanded(child: ListView.separated(
              itemBuilder: (context,index) => EventItem(event: EventModel(
                  dateTime: DateTime.now(),
                  category: CategoryModel.getCategoriesWithAll(context)[3],
                  title: "This is a Birthday Party ",
                  description: "description",
                  timeOfDay: TimeOfDay.now())),
              separatorBuilder: (context,index) =>SizedBox(height: 16.h,),
              itemCount: 20))
        ],
      ),
    );
  }
}
