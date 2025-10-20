import 'package:event_app/providers/maps_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapTap extends StatelessWidget {
  const MapTap({super.key});

  @override
  Widget build(BuildContext context) {
    MapsTabProvider mapsTabProvider = Provider.of<MapsTabProvider>(context);
    return Center(child: Text(
      mapsTabProvider.locationMessage
    ));
  }
}
