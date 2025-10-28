import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationCard extends StatelessWidget {
 final double city;
 final double country;
  const LocationCard({super.key, required this.city, required this.country ,});

  @override
  Widget build(BuildContext context) {
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
              Icons.gps_fixed_outlined,
              color: ColorsManager.white,
              size: 24,
            ),
          ),
          Expanded(
            child: Text('$city,$country' ,style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).primaryColor,
            ),),
          )

        ],
      ),
    );
  }
}
