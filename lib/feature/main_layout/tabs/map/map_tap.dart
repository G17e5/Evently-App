import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/providers/maps_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTap extends StatelessWidget {
  const MapTap({super.key});

  @override
  Widget build(BuildContext context) {
    MapsTabProvider provider = Provider.of<MapsTabProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: provider.cameraPosition,
              onMapCreated: (controller) => {
                provider.googleMapController = controller,
              },
              mapType: MapType.normal,
              markers: provider.markers,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.gps_fixed_outlined),
      ),
    );
  }
}
