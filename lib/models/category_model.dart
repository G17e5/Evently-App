import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  String imagePath;
  IconData iconData;

  CategoryModel({
    required this.name,
    required this.id,
    required this.iconData,
    required this.imagePath,
  });


  static List<CategoryModel>  getCategoriesWithAll(BuildContext context){
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return [
      CategoryModel(
        name: appLocalizations.all,
        id: "0",
        iconData: Icons.all_inclusive_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.sport,
        id: "1",
        iconData: Icons.sports_football_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.birthday,
        id: "2",
        iconData: Icons.celebration_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.meeting,
        id: "3",
        iconData: Icons.laptop_mac_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.gaming,
        id: "4",
        iconData: Icons.gamepad_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.eating,
        id: "5",
        iconData: Icons.local_pizza_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.holiday,
        id: "6",
        iconData: Icons.holiday_village_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name:appLocalizations.exhibition,
        id: "7",
        iconData: Icons.water_drop_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name:appLocalizations.work_shop,
        id: "8",
        iconData: Icons.workspaces_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.book_club,
        id: "9",
        iconData: Icons.book_outlined,
        imagePath: "",
      ),
    ];
  }
  static List<CategoryModel>  getCategories(BuildContext context){
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return [
      CategoryModel(
        name: appLocalizations.sport,
        id: "1",
        iconData: Icons.sports_football_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.birthday,
        id: "2",
        iconData: Icons.celebration_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.meeting,
        id: "3",
        iconData: Icons.laptop_mac_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.gaming,
        id: "4",
        iconData: Icons.gamepad_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.eating,
        id: "5",
        iconData: Icons.local_pizza_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.holiday,
        id: "6",
        iconData: Icons.holiday_village_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name:appLocalizations.exhibition,
        id: "7",
        iconData: Icons.water_drop_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name:appLocalizations.work_shop,
        id: "8",
        iconData: Icons.workspaces_rounded,
        imagePath: "",
      ),
      CategoryModel(
        name: appLocalizations.book_club,
        id: "9",
        iconData: Icons.book_outlined,
        imagePath: "",
      ),
    ];
  }

}
