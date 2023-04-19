import 'package:application/views/styles.dart';
import 'package:lottie/lottie.dart ' as lot;
import 'package:flutter/material.dart';

class HealthStatus extends StatefulWidget {
  var bpm;
  var spo2;

  HealthStatus({
    required bpm,
    required spo2,
  }) {
    this.bpm = bpm;
    this.spo2 = spo2;
  }

  @override
  State<HealthStatus> createState() => _HealthStatusState();
}

class _HealthStatusState extends State<HealthStatus>
    with TickerProviderStateMixin {
  late AnimationController _heartbeat;

  @override
  void initState() {
    super.initState();
    _heartbeat =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    if (_heartbeat.isAnimating) {
      // _bellController.stop();
      _heartbeat.reset();
    } else {
      _heartbeat.repeat();
    }
  }

  void dispose() {
    _heartbeat.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // for (int i = 0; i < GetData.data.length; i++)
        Row(
          children: [
            Expanded(
              child: healthStatusItem(
                  Color.fromARGB(255, 88, 158, 255),
                  this.widget.bpm,
                  "bpm ",
                  'assests/heart.json',
                  "Heart Rate",
                  72,
                  19),
            ),
            Expanded(
              child: healthStatusItem(Style.darkblue, this.widget.spo2, "%",
                  'assests/oxygen.json', "Oxygen Saturation", 70, 16),
            ),
            Expanded(
              child: healthStatusItem(Color.fromARGB(255, 247, 208, 67), "30",
                  " m ", 'assests/distance.json', "Distance", 70, 19),
            ),
          ],
        ),
      ],
    );
  }

  AnimatedContainer healthStatusItem(Color color, data, String measuringUnit,
      String iconPath, title, double iconsize, double fontsize) {
    return AnimatedContainer(
      margin: EdgeInsets.only(top: 15),
      height: 190,
      duration: Duration(milliseconds: 50),
      child: InkWell(
        radius: 200,
        child: Card(
          color: color,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    data,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    measuringUnit,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              IconButton(
                splashRadius: 50,
                iconSize: iconsize,
                onPressed: () {},
                icon: lot.Lottie.asset(iconPath,
                    controller: _heartbeat, height: 100, fit: BoxFit.cover),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontsize,
                ),
              )
            ]),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
