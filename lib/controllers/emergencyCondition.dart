import 'package:application/controllers/notifications_services.dart';
import 'package:firebase_database/firebase_database.dart';

class EmergencyCondition{

  static DatabaseReference infoRef = FirebaseDatabase.instance.ref('ESP32-v1');
  static   NotificationsServices notificationsServices = NotificationsServices();

  static void EmergencyNotification(bpm,spo2){
    if(bpm>100 ||bpm<=60||spo2<90)
    {
  notificationsServices.senfNotifivation();
    }
  }
}