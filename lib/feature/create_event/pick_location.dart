import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/providers/maps_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/pick_location_provider.dart';

class PickLocation extends StatelessWidget {
  const PickLocation({super.key});

  @override
  Widget build(BuildContext context) {
    PickLocationProvider provider = Provider.of<PickLocationProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onTap: (latLng){
                provider.changePickLocation(latLng);
                Navigator.pop(context);
              },
              initialCameraPosition: provider.cameraPosition,
              onMapCreated: (controller) => {
                provider.googleMapController = controller,
              },
              mapType: MapType.normal,
              markers: provider.markers,
            ),
          ),
          Container(
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            padding: REdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text("Tap On Location to Select" ,style: TextTheme.of(context).labelSmall?.copyWith(color: ColorsManager.ofWhite),),
          )
        ],
      ),
    );
  }
}
