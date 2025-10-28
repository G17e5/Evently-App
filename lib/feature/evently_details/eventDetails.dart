import 'package:event_app/UI_Utiles/Ui_Utiles.dart';
import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:event_app/core/widgets/location_card.dart';
import 'package:event_app/feature/main_layout/tabs/home/event_item.dart';
import 'package:event_app/firebase_services/firebase_services.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/providers/home_provider.dart';
import 'package:event_app/providers/maps_tab_provider.dart';
import 'package:event_app/providers/pick_location_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/custom_dateTime_card.dart';

class EventDetails extends StatefulWidget {
  final EventModel event;

  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    MapsTabProvider provider = Provider.of<MapsTabProvider>(context);
    Provider.of<PickLocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        actions: [
          Visibility(
            visible: widget.event.userId == FirebaseAuth.instance.currentUser?.uid,
            child: IconButton(
              onPressed: ()  {
                Navigator.pushNamed(context, RouteManager.createEvent ,arguments: widget.event );
              },
              icon: Icon(Icons.edit),
              color: ColorsManager.blue,
            ),
          ),
          Visibility(
            visible: widget.event.userId == FirebaseAuth.instance.currentUser?.uid,
            child: IconButton(
              onPressed: () async {
                UIUtils.showLoading(context);
                await FirebaseServices.deleteEvent(widget.event.eventId, context);
                UIUtils.hideDialog(context);
                UIUtils.ShowToastMessage("Deleted Event Successfully", Colors.green);
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete),
              color: ColorsManager.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.all(16),
        child: Column(
          spacing: 16,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EventItem(favouriteEvent: false, event: widget.event),
            Text(
              widget.event.title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            CustomDatetimeCard(dateTime: widget.event.dateTime),
            LocationCard(city: widget.event.lat, country: widget.event.long),
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.34.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: GoogleMap(
                  scrollGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.event.lat, widget.event.long),
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("event_location"),
                      position: LatLng(widget.event.lat, widget.event.long),
                      infoWindow: InfoWindow(title: widget.event.title),
                    ),
                  },
                ),
              ),
            ),
            Text(
              "Description",

              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontWeight:FontWeight.bold ,color: ColorsManager.black),
            ),
            Text(
              widget.event.description,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: ColorsManager.black),
            ),
          ],
        ),
      ),
    );
  }
}
