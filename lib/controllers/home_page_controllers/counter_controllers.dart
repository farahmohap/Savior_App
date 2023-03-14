
import 'package:application/models/home_page_models/counter_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CounterController extends ControllerMVC {
  factory CounterController() {
    _this ??= CounterController._();
    return _this!;
  }
  static CounterController? _this;

  CounterController._();


  DatabaseReference ref = FirebaseDatabase.instance.ref("esp32-v1/");


  int get counter => CounterModel.counter;

  void incrementCounter()async {
    /// The Controller knows how to 'talk to' the Model. It knows the name, but Model does the work.
    CounterModel.incrementCounter();
  }

  void decrementCounter() {
    /// The Controller knows how to 'talk to' the Model. It knows the name, but Model does the work.
    CounterModel.decrementCounter();
  }
}