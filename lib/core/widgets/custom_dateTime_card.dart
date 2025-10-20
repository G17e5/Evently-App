import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/providers/event_details_date_time.dart';
import 'package:event_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomDatetimeCard extends StatelessWidget {
  final DateTime dateTime;

  const CustomDatetimeCard({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    // EventDetailsProvider eventDetailsProvider =
    //     Provider.of<EventDetailsProvider>(context);

    return Container(
      padding: REdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1.w,
        ), // Subtle light blue border
      ),
      child: Row(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: REdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.calendar_month_outlined,
              color: ColorsManager.white,
              size: 24,
            ),
          ),
          Flexible(
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Provider.of<EventDetailsProvider>(
                    context,
                    listen: false,
                  ).formatEventDate(dateTime),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  Provider.of<EventDetailsProvider>(
                    context,
                    listen: false,
                  ).formatEventTime(dateTime),

                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: ColorsManager.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
