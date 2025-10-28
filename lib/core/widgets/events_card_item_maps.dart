import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventMapCard extends StatefulWidget {
  final EventModel event;

  const EventMapCard({required this.event});

  @override
  State<EventMapCard> createState() => _EventMapCardState();
}

class _EventMapCardState extends State<EventMapCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        spacing: 8,
        children: [
          AspectRatio(
            aspectRatio: 138 / 78,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image(image: AssetImage(widget.event.category.imagePath)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.event.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.black, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'Location: ${widget.event.lat.floor()}, ${widget.event.long.floor()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.sp, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
