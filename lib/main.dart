import 'package:application/controllers/locale/locale_controller.dart';
import 'package:application/views/auth/signin.dart';
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
  AwesomeNotifications().initialize(
    'resource://drawable/drowning.jpg', //icon || null
    [
      NotificationChannel(
        channelKey: 'Basic Key',
        channelName: 'Test Channel',
        channelDescription: 'Emergency Notification',
        playSound: true,
        channelShowBadge: true,
        importance: NotificationImportance.High,
        vibrationPattern: Int64List(50),
        soundSource: "asset://row/emergency.mp3",

        //icon: 'resource://drawable/blue.png'
      )
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
      locale: Get.deviceLocale,
      //locale: controller.initialLang,
      translations: MyLocale(),
    );
  }
}
