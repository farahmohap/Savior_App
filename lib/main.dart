import 'package:application/controllers/locale_controller.dart';
import 'package:application/models/getdata.dart';
import 'package:application/views/auth/Form_sign_in.dart';
import 'package:application/views/auth/login.dart';
import 'package:application/views/auth/signin.dart';
import 'package:application/views/features/devices.dart';
import 'package:application/views/features/dragabble.dart';
import 'package:application/views/features/info.dart';
import 'package:application/views/reusable.dart';
import 'package:application/views/settings/settings.dart';
import 'package:application/views/widgets/test.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'models/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().initialize(
      'resource://drawable/blue.png',//icon || null
      [
        NotificationChannel(
            channelKey: 'Basic Key',
            channelName: 'Test Channel',
            channelDescription: 'Emergency Notification',
            playSound: true,
            channelShowBadge: true,
            importance: NotificationImportance.High,
            vibrationPattern: Int64List(50)
            //icon: 'resource://drawable/blue.png'
            //soundSource: "assests/row/emergency.mp3",
            )
      ],
     );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    MyLocaleController controller = Get.put(MyLocaleController());
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
      // locale: Get.deviceLocale,
      //locale: controller.initialLang,
      //  translations: MyLocale(),
    );
  }
}
