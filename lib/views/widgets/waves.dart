import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';


class Waves extends StatelessWidget {
  const Waves({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 630, bottom: 0),

        // alignment: Alignment.centerRight,
        child: WaveWidget(
          //user Stack() widget to overlap content and waves
          config: CustomConfig(
            colors: [
              Color.fromARGB(255, 190, 196, 255).withOpacity(0.3),
              Color.fromARGB(255, 15, 56, 110).withOpacity(.4),
              Color.fromARGB(255, 35, 148, 214).withOpacity(.5),
              //the more colors here, the more wave will be
            ],
            durations: [4000, 5000, 7000],
            //durations of animations for each colors,
            // make numbers equal to numbers of colors
            heightPercentages: [0.01, 0.05, 0.03],
            //height percentage for each colors.
            blur: MaskFilter.blur(BlurStyle.solid, 5),
            //blur intensity for waves
          ),
          waveAmplitude: 35.00, //depth of curves
          waveFrequency: 3, //number of curves in waves
          //backgroundColor: Colors.white, //background colors
          size: Size(double.infinity, 150),
        ));
  }
}
