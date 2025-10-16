import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/feature/main_layout/tabs/home/event_item.dart';
import 'package:event_app/firebase_services/firebase_services.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteTap extends StatelessWidget {
  const FavoriteTap({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Column(
          children: [
      Container(
      margin: REdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: ColorsManager.blue)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: ColorsManager.blue)
          ),
          prefixIcon: Icon(Icons.search),
          prefixIconColor: ColorsManager.blue,
          hintText: appLocalizations.search_for_event,
          hintStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.blue,
          ),
        ),
      ),
    ),
    SizedBox(height: 16.h,),
    FutureBuilder(
    future: FirebaseServices.getFavouriteEvents(context), builder: (context ,snapshot){
    if(snapshot.connectionState == ConnectionState.waiting){
    return Center(child: CircularProgressIndicator());
    }
    if(snapshot.hasError){
    return Center(child: Text(snapshot.error.toString()));
    }
    List<EventModel> favouriteEvents = snapshot.data ?? [] ;
    return Expanded(child: favouriteEvents.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, color: Colors.grey, size: 80),
          SizedBox(height: 16),
          Text(
            "No Favourite Events Available",
            style: TextStyle(
              color: ColorsManager.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Check back later for add Favourite events",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    )
        : ListView.separated(
    itemBuilder: (context,index) => EventItem(event: favouriteEvents[index] ,favouriteEvent: true,),
    separatorBuilder: (context,index) =>SizedBox(height: 16.h,),
    itemCount: favouriteEvents.length));
    },)],),);
  }
}
