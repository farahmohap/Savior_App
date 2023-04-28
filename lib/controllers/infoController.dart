import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class InfoController extends GetxController {
  static RxInt bpm = 0.obs;

  static getData() {
    DatabaseReference locationRef = FirebaseDatabase.instance.ref('ESP32-v1');
    locationRef.onValue.listen((DatabaseEvent event) {
      bpm =
          RxInt(int.parse(event.snapshot.child("heartrate").value.toString()));
      bpm.refresh();
      bpm.update((val) {});
    });
  }
}
