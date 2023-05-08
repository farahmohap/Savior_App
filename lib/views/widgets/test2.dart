import 'package:flutter/src/widgets/async.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:application/controllers/emergencyCondition.dart';
import 'package:flutter/src/widgets/framework.dart';

class StreamGlobal extends StatefulWidget {
  const StreamGlobal({super.key});

  @override
  State<StreamGlobal> createState() => _StreamGlobalState();
}

class _StreamGlobalState extends State<StreamGlobal> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: EmergencyCondition.infoRef.onValue,
      builder: (context, AsyncSnapshot snapshot) {
        return Container();
      }
    );
  }
}


