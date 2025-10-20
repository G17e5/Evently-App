import 'package:event_app/UI_Utiles/Ui_Utiles.dart';
import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/resource/images_manager/image_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:event_app/firebase_services/firebase_services.dart';
import 'package:event_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EventItem extends StatefulWidget {
  EventItem({super.key, required this.event, required this.favouriteEvent});

  final EventModel event;

  final bool favouriteEvent;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  late bool isFavourite = widget.favouriteEvent;
  List<String> monthsEnglish = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteManager.eventDetails,
          arguments: widget.event,
        );
      },
      child: Stack(
        children: [
          Container(
            padding: REdgeInsets.all(16),
            margin: REdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 203.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(widget.event.category.imagePath),
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ColorsManager.blue, width: 1.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: REdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.event.dateTime.day.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.blue,
                          ),
                        ),
                        Text(
                          monthsEnglish[widget.event.dateTime.month - 1],
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.event.title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        IconButton(
                          onPressed: _markEventToFavourite,
                          icon: Icon(
                            isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: ColorsManager.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _markEventToFavourite() async {
    if (isFavourite) {
      UIUtils.showLoading(context);
      await FirebaseServices.removeEventToFavourite(widget.event);
      isFavourite = false;
      UIUtils.hideDialog(context);
      UIUtils.ShowToastMessage("Event Removed form Favourite", Colors.red);
    } else {
      UIUtils.showLoading(context);
      await FirebaseServices.addEventToFavourite(widget.event);
      isFavourite = true;
      UIUtils.hideDialog(context);
      UIUtils.ShowToastMessage("Event added form Favourite", Colors.green);
    }
    setState(() {});
  }
}
