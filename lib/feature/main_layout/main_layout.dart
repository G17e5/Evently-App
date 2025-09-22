import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:event_app/feature/main_layout/tabs/favorite/Favorite_tap.dart';
import 'package:event_app/feature/main_layout/tabs/home/home_tap.dart';
import 'package:event_app/feature/main_layout/tabs/map/map_tap.dart';
import 'package:event_app/feature/main_layout/tabs/profile/profile_tap.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  List<Widget> tabs = [HomeTap(), MapTap(), FavoriteTap(), ProfileTap()];
  int selectIndex = 0;
 late  AppLocalizations appLocalizations = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      extendBody: true,
      body: tabs[selectIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:_buildFab(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildFab()
  {
   return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, RouteManager.createEvent);
      },
      child: Icon(Icons.add),
    );
  }
  BottomAppBar _buildBottomNavigationBar() {
    return BottomAppBar(
      notchMargin: 8,

      child: BottomNavigationBar(
        onTap: _onTabs,
        currentIndex: selectIndex,

        items: [
          BottomNavigationBarItem(
            icon: Icon(selectIndex == 0 ? Icons.home : Icons.home_outlined),
            label: appLocalizations.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectIndex == 1 ? Icons.location_on : Icons.location_on_outlined,
            ),
            label: appLocalizations.map,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectIndex == 2 ? Icons.favorite : Icons.favorite_outline,
            ),
            label: appLocalizations.favorites,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectIndex == 3 ? Icons.person : Icons.person_2_outlined,
            ),
            label: appLocalizations.profile,
          ),
        ],
      ),
    );
  }

  void _onTabs(int newIndex) {
    setState(() {
      selectIndex = newIndex;
    });
  }
}
