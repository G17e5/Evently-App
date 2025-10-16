import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/widgets/custom_tab_bar.dart';
import 'package:event_app/core/widgets/tab_item.dart';
import 'package:event_app/feature/main_layout/tabs/home/event_item.dart';
import 'package:event_app/firebase_services/firebase_services.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/models/category_model.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/models/user_model.dart';
import 'package:event_app/providers/langu_provider.dart';
import 'package:event_app/providers/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeTap extends StatefulWidget {
  HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  int selectedIndex = 0;
  List<EventModel> events = [];
  late CategoryModel selectedCategory = CategoryModel.getCategoriesWithAll(
    context,
  )[0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      children: [
        Container(
          padding: REdgeInsets.only(top: 40),
          width: double.infinity,

          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
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
                          "${appLocalizations.welcome_back}✨",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          UserModel.currentUser!.name,
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
                      onPressed: () {
                        themeProvider.changeAppTheme(
                          themeProvider.isDark
                              ? ThemeMode.light
                              : ThemeMode.dark,
                        );
                      },
                      icon: Icon(
                        themeProvider.isDark
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode,
                      ),
                      color: ColorsManager.white,
                    ),
                    InkWell(
                      onTap: () {
                        languageProvider.changeAppLang(
                          languageProvider.isEnglish ? "ar" : "en",
                        );
                      },
                      child: Card(
                        color: ColorsManager.ofWhite,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            languageProvider.isEnglish ? "en" : "ar",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomTapBar(
                onCategoryItemClicked: (Category) {
                  selectedCategory = Category;
                  setState(() {});
                },
                categories: CategoryModel.getCategoriesWithAll(context),
                selectedTaBbgColors: ColorsManager.whiteBlue,
                selectedTaFgColors: ColorsManager.blue,
                unselectedTaBbgColors: Colors.transparent,
                unselectedTaFgColors: ColorsManager.whiteBlue,
              ),
            ],
          ),
        ),
        StreamBuilder(
          stream: FirebaseServices.getEventsWithRealTime(context, selectedCategory),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            List<EventModel> events = snapshot.data ?? [];
            return Expanded(
              child: events.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_busy, color: Colors.grey, size: 80),
                          SizedBox(height: 16),
                          Text(
                            "No Events Available",
                            style: TextStyle(
                              color: ColorsManager.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Check back later for new events",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: MediaQuery.of(context).padding.bottom + 16, // ← padding إضافي لآخر عنصر
                ),
                      itemBuilder: (context, index) => EventItem(
                        event: events[index],
                        favouriteEvent: UserModel
                            .currentUser!
                            .favouriteEventsIds
                            .contains(events[index].eventId),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount: events.length,
                    ),
            );
          },
        ),
      ],
    );
  }

  void getEvents() async {
    events = await FirebaseServices.getEvents(context, selectedCategory);
    setState(() {});
  }
}
