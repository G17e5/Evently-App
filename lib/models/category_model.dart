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

  static List<CategoryModel> categoriesWithAll = [
    CategoryModel(
      name: "All",
      id: "0",
      iconData: Icons.all_inclusive_rounded,
      imagePath: "",
    ),
    CategoryModel(
      name: "Sport",
      id: "1",
      iconData: Icons.sports_football_rounded,
      imagePath: "",
    ),
    CategoryModel(
      name: "Birthday",
      id: "2",
      iconData: Icons.celebration_rounded,
      imagePath: "",
    ),
    CategoryModel(
      name: "meeting",
      id: "3",
      iconData: Icons.laptop_mac_rounded,
      imagePath: "",
    ),
    CategoryModel(
      name: "Gaming",
      id: "4",
      iconData: Icons.gamepad_rounded,
      imagePath: "",
    ),
    CategoryModel(
      name: "Eating",
      id: "5",
      iconData: Icons.local_pizza_rounded,
      imagePath: "",
    ),
    CategoryModel(
      name: "Holiday",
      id: "6",
      iconData: Icons.holiday_village_rounded,
      imagePath: "",
    ),
    CategoryModel(
      name: "Exhibition",
      id: "7",
      iconData: Icons.water_drop_rounded,
      imagePath: "",
    ),
    CategoryModel(
      name: "WorkShop",
      id: "8",
      iconData: Icons.workspaces_rounded,
      imagePath: "",
    ),
    CategoryModel(
      name: "BockClub",
      id: "9",
      iconData: Icons.book_outlined,
      imagePath: "",
    ),
  ];
}
