import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/widgets/events_card_item_maps.dart';
import 'package:event_app/feature/main_layout/tabs/home/event_item.dart';
import 'package:event_app/firebase_services/firebase_services.dart';
import 'package:event_app/models/category_model.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/models/user_model.dart';
import 'package:event_app/providers/maps_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTap extends StatefulWidget {
  const MapTap({super.key});

  @override
  State<MapTap> createState() => _MapTapState();
}

class _MapTapState extends State<MapTap> {
  late CategoryModel selectedCategory = CategoryModel.getCategoriesWithAll(
    context,
  )[0];

  @override
  Widget build(BuildContext context) {
    MapsTabProvider provider = Provider.of<MapsTabProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: provider.cameraPosition,
            onMapCreated: (controller) {
              provider.googleMapController = controller;
            },
            mapType: MapType.normal,
            markers: provider.markers,
          ),

          Positioned(
            bottom: 100.h,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 120.h,
              width: double.infinity,
              child: StreamBuilder<List<EventModel>>(
                stream: FirebaseServices.getEventsWithRealTime(
                  context,
                  selectedCategory,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  final events = snapshot.data ?? [];
                  if (events.isEmpty) {
                    return const Center(child: Text("No events available"));
                  }

                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        provider.changeCameraPosition(
                          LatLng(events[index].lat, events[index].long),
                        );

                      },

                      child: EventMapCard(event: events[index]),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 12.w),
                    itemCount: events.length,
                  );
                },
              ),
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.getLocation();
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: ColorsManager.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.gps_fixed_outlined),
      ),
    );
  }
}
