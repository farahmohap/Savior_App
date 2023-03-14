import 'package:flutter/material.dart';

class HomePageSecondText extends StatelessWidget {
  HomePageSecondText({Key? key,required this.counter}) : super(key: key);

  int counter;
  @override
  Widget build(BuildContext context) {
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
