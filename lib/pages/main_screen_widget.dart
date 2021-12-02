import 'package:flutter/material.dart';
import 'package:friflex_weather_test/navigation/navigation.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                enabled: true,
                controller: textController,
                decoration: InputDecoration(
                  labelText: "Введите название города",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () => textController.text != ''
                  ? {
                      Navigator.of(context).pushNamed(
                          NavigationRouteNames.weather,
                          arguments: textController.text)
                    }
                  : {},
              child: const Text('Смотреть погоду'),
            )
          ],
        ),
      ),
    );
  }
}
