import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer; // declare a timer variable
  int _seconds = 13; // declare a variable to store the remaining seconds

  @override
  void initState() {
    super.initState();
    _startTimer(); // start the timer when the widget is initialized
  }

  @override
  void dispose() {
    _timer?.cancel(); // cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1); // define a duration of one second
    _timer = Timer.periodic(oneSec, (timer) { // create a periodic timer
      if (_seconds == 0) { // if the remaining seconds is zero
        setState(() {
          timer.cancel(); // cancel the timer
        });
      } else { // otherwise
        setState(() {
          _seconds--; // decrement the remaining seconds by one
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Scanning for Devices $_seconds', // display the remaining seconds
        
      ),
    );
  }
}
