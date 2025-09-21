import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/widgets/custom_tab_bar.dart';
import 'package:event_app/core/widgets/tab_item.dart';
import 'package:event_app/feature/main_layout/tabs/home/event_item.dart';
import 'package:event_app/models/category_model.dart';
import 'package:event_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTap extends StatefulWidget {
  HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: REdgeInsets.only(top: 40),
          width: double.infinity,

          decoration: BoxDecoration(
            color:Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back ✨",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "John Safwat",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: ColorsManager.ofWhite,
                            ),
                            Text(
                              "Cairo , Egypt",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.light_mode),
                      color: ColorsManager.white,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Card(
                        color: ColorsManager.ofWhite,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "EN",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomTapBar(
                categories: CategoryModel.categoriesWithAll,
                selectedTaBbgColors: ColorsManager.whiteBlue,
                selectedTaFgColors: ColorsManager.blue,
                unselectedTaBbgColors: Colors.transparent,
                unselectedTaFgColors: ColorsManager.whiteBlue,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric( vertical:16 ),
            itemBuilder: (context, index) => EventItem(
              event: EventModel(
                dateTime: DateTime.now(),
                category: CategoryModel.categoriesWithAll[3],
                title: "This is a Birthday Party ",
                description: "description",
                timeOfDay: TimeOfDay.now(),
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
            itemCount: 20,
          ),
        ),
      ],
    );
  }
}
