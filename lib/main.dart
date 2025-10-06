import 'package:event_app/config/theme/theme_manager.dart';
import 'package:event_app/core/prefs_manager/prefs_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/providers/langu_provider.dart';
import 'package:event_app/providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await PrefsManager.init();
await Firebase.initializeApp();


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => LanguageProvider()),


    ],
      child: const EventApp()));
}
class EventApp extends StatelessWidget {
  const EventApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    LanguageProvider languProvider = Provider.of<LanguageProvider>(context);
    return ScreenUtilInit(
      designSize: Size(393,841),
      minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child) =>MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute:FirebaseAuth.instance.currentUser  == null ? RouteManager.login : RouteManager.mainLayout ,
          onGenerateRoute :RouteManager.router ,
          theme:ThemeManager.light ,
          darkTheme:ThemeManager.dark ,
          themeMode:themeProvider.currentTheme,
          locale: Locale(languProvider.currentLang),
          localizationsDelegates:AppLocalizations.localizationsDelegates,
          supportedLocales: [
            Locale('en'), // English
            Locale('ar'), // Spanish
          ],
        ),
    );
  }
}

