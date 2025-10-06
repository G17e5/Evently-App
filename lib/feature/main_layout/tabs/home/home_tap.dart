import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/widgets/custom_tab_bar.dart';
import 'package:event_app/core/widgets/tab_item.dart';
import 'package:event_app/feature/main_layout/tabs/home/event_item.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/models/category_model.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/providers/langu_provider.dart';
import 'package:event_app/providers/theme_provider.dart';
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
                          "${appLocalizations.welcome_back}✨",
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
                      onPressed: () {
                        themeProvider.changeAppTheme(themeProvider.isDark ? ThemeMode.light : ThemeMode.dark);
                      },
                      icon: Icon(themeProvider.isDark ? Icons.dark_mode_rounded : Icons.light_mode),
                      color: ColorsManager.white,
                    ),
                    InkWell(
                      onTap: () {
                        languageProvider.changeAppLang(languageProvider.isEnglish ? "ar" : "en");

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
                categories: CategoryModel.getCategoriesWithAll(context),
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
                category: CategoryModel.getCategoriesWithAll(context)[3],
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
