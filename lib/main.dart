import 'package:birthdates/firebase_services/firebase_notification.dart';
import 'package:birthdates/providers/birthday_provider.dart';
import 'package:birthdates/providers/navprovider.dart';
import 'package:birthdates/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_services/firebase_services.dart';
import 'managers/preference_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PreferenceManager().init();
  await FirebaseServices().getDeviceToken();
  await FirebaseNotification().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<BirthDayProvider>(
              create: (context) => BirthDayProvider(),
            ),
            ChangeNotifierProvider<NavProvider>(
              create: (context) => NavProvider(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            initialRoute: AppRoutes.nav,
            theme: ThemeData(
              textTheme: GoogleFonts.rubikTextTheme(),
            ),
          ),
        );
      },
    );
  }
}
