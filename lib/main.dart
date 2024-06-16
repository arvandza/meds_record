import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:meds_record/app/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isFirstInstall = prefs.getBool('isFirstInstall') ?? true;

  if (isFirstInstall) {
    prefs.setBool('isFirstInstall', false);
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      GetMaterialApp(
          title: "Meds Record",
          debugShowCheckedModeBanner: false,
          initialRoute: isFirstInstall ? '/install' : '/login',
          getPages: AppPages.routes,
          theme: Themes.lightTheme),
    );
  });
}
