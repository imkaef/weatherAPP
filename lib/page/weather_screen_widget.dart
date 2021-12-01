import 'package:flutter/material.dart';

class WeatherSecreenWidget extends StatelessWidget {
  const WeatherSecreenWidget({Key? key, required this.message})
      : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message),
      ),
      body: Container(),
    );
  }
}
