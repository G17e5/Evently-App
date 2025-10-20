import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/resource/images_manager/image_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:event_app/feature/main_layout/tabs/profile/dropdwon_item.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/models/user_model.dart';
import 'package:event_app/providers/langu_provider.dart';
import 'package:event_app/providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class ProfileTap extends StatefulWidget {
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
            color: ColorsManager.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36.r),
              bottomRight: Radius.circular(36.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundImage: AssetImage(ImageAssets.routeProfile),
                ),
                SizedBox(width: 20.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     UserModel.currentUser!.name,
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      UserModel.currentUser!.email,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
        DropdwonItem(
          onChange: (newTheme) {
            themeProvider.changeAppTheme(
              newTheme == appLocalizations.light ? ThemeMode.light : ThemeMode.dark,
            );
          },
          title: appLocalizations.theme,
          menuItem: [appLocalizations.light, appLocalizations.dark],
          selectedItem: themeProvider.isDark ? appLocalizations.dark : appLocalizations.light,
        ),
        SizedBox(height: 16.h),
        DropdwonItem(
          onChange: (newLang){
            languageProvider.changeAppLang(
              newLang == "English" ? "en" :"ar"
            );
          },
          title: appLocalizations.language,
          menuItem: ["English", "Arabic"],
          selectedItem: languageProvider.isEnglish ? "English" : "عربي",
        ),
        Spacer(flex: 6),
        Container(
          margin: REdgeInsets.symmetric(horizontal: 16, vertical: 120),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.red,
              foregroundColor: ColorsManager.whiteBlue,
              padding: REdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              textStyle: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: _logout,
            child: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 8.w),
                Text(appLocalizations.logout),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _logout() async {
   await  FirebaseAuth.instance.signOut();
   await GoogleSignIn().signOut();
    Navigator.pushReplacementNamed(context , RouteManager.login);
  }
}
