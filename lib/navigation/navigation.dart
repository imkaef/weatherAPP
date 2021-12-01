import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_weather_test/pages/cubit/weather_cubit.dart';
import 'package:friflex_weather_test/pages/weather_screen_widget.dart';

abstract class NavigationRouteNames {
  static const mainScreen = '/';
  static const weather = '/weather';
}

class MainNavigation {
  Route<Object> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    final city = arguments is String ? arguments : '';
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => WeatherCubit(city: city),
        child: const WeatherSecreenWidget(),
      ),
    );
  }
}
