import 'package:application/views/home_page/home_page_components/home_page_primary_text.dart';
import 'package:application/views/home_page/home_page_components/home_page_second_text.dart';
import 'package:flutter/material.dart';

import '../../controllers/home_page_controllers/counter_controllers.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final CounterController _counterController = CounterController();

  void _incrementCounter() {
    setState(() {
      _counterController.incrementCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const HomePagePrimaryText(),
            HomePageSecondText(counter: _counterController.counter)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
