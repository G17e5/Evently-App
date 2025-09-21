import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/resource/images_manager/image_manager.dart';
import 'package:event_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EventItem extends StatelessWidget {
   EventItem({super.key , required this.event});
  final EventModel event ;
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
     "Dec"
   ];
   @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: REdgeInsets.all(16),
          margin: REdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          height: 203.h,
          decoration: BoxDecoration(
            image:DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(ImageAssets.birthdayLight)),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
                color: ColorsManager.blue ,width: 1.w)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Card(
               child: Padding(
                 padding: REdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     Text(event.dateTime.day.toString() , style:GoogleFonts.inter(fontSize:20.sp ,fontWeight: FontWeight.bold , color: ColorsManager.blue)),
                     Text(monthsEnglish[event.dateTime.month - 1], style:GoogleFonts.inter(fontSize:14.sp ,fontWeight: FontWeight.bold , color: ColorsManager.blue)),
                   ],
                 ),
               ),
             ),
             Spacer(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0 ,vertical: 10),
                  child: Row(
                    children: [
                      Expanded(child: Text(event.title , style:Theme.of(context).textTheme.titleSmall),)
                      ,IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border ,color: ColorsManager.blue,))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

      ],
    );
  }
}
