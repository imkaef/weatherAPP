import 'package:flutter/material.dart';
import 'package:friflex_weather_test/navigation/navigation.dart';
import 'package:friflex_weather_test/pages/main_screen_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final mainNavigation = MainNavigation();
  // static final mainNavigation = MainNavigation();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.orange
            // const MaterialColor(
            //     0, {0: Color(0xffea6e4b)}), //Color(0xffea6e4b),
            ),
        //home: const MainScreenWidget(),
        initialRoute: NavigationRouteNames.mainScreen,
        routes: {
          NavigationRouteNames.mainScreen: (context) =>
              const MainScreenWidget(),
          // NavigationRouteNames.weather: (context) => const WeatherSecreenWidget(),
        },
        onGenerateRoute: mainNavigation.onGenerateRoute);
  }
}
