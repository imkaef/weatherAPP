import 'package:flutter/material.dart';
import 'package:friflex_weather_test/page/weather_screen_widget.dart';

abstract class NavigationRouteNames {
  static const mainScreen = '/';
  static const weather = '/weather';
}

 class MainNavigation {
  Route<Object> onGenerateRoute(RouteSettings settings) {
        final arguments = settings.arguments;
        final youTubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => WeatherSecreenWidget(message:  youTubeKey),
        );
  }
}