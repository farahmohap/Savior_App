import 'package:application/controllers/locale/locale_controller.dart';
import 'package:application/controllers/notifications_services.dart';
import 'package:application/views/auth/signin.dart';
import 'package:application/views/features/animated_splash.dart';
import 'package:application/views/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'controllers/locale/locale.dart';
import 'models/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationsServices notificationsServices = NotificationsServices();
  notificationsServices.initialiseNotifications();

  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignIn(),
      locale: Get.deviceLocale,
      //locale: controller.initialLang,
      translations: MyLocale(),
    );
  }
}
