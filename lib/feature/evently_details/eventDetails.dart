import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/feature/main_layout/tabs/home/event_item.dart';
import 'package:event_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widgets/custom_dateTime_card.dart';

class EventDetails extends StatelessWidget {
  final EventModel event;

  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
            color: ColorsManager.blue,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
            color: ColorsManager.red,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.all(16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EventItem(favouriteEvent: false, event: event),
            Text(
              event.title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500
              ),
            ),
            CustomDatetimeCard(dateTime: event.dateTime, )
          ],
        ),
      ),
    );
  }
}
