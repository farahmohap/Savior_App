import 'package:application/controllers/locale/locale_controller.dart';
import 'package:application/controllers/notifications_services.dart';
import 'package:application/views/auth/signin.dart';
import 'package:application/views/features/dragabble.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
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
  notificationsServices.senfNotifivation();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: DragHome(),
      locale: Get.deviceLocale,
      //locale: controller.initialLang,
      translations: MyLocale(),
    );
  }
}
