import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_weather_test/entities/weather.dart';
import 'package:friflex_weather_test/pages/cubit/weather_cubit.dart';
import 'package:intl/intl.dart';

class WeatherSecreenWidget extends StatelessWidget {
  const WeatherSecreenWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<WeatherCubit>().city.toUpperCase()),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Container(
        child: const _Weather(),
        color: const Color(0xfff2f2f2),
      ),
    );
  }
}

class _Weather extends StatelessWidget {
  const _Weather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final weatherCubit = context.read<WeatherCubit>();
        if (state is WeatherInitial) {
          weatherCubit.internial();
          return _DownloadWidget(
            state: state,
          );
        }
        if (state is WeatherLoaded) {
          return _LoadedWidget(
            state: state,
          );
        }
        if (state is WeatherError) {
          return _ErrorWidget(
            state: state,
          );
        }
        return Container();
      },
    );
  }
}

class _DownloadWidget extends StatelessWidget {
  const _DownloadWidget({Key? key, required this.state}) : super(key: key);
  final WeatherInitial state;
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _LoadedWidget extends StatelessWidget {
  const _LoadedWidget({Key? key, required this.state}) : super(key: key);
  final WeatherLoaded state;

  @override
  Widget build(BuildContext context) {
    return _ListWievBuilder(weatherList: state.data.list);
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({Key? key, required this.state}) : super(key: key);
  final WeatherError state;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        state.errorMessage,
        style: const TextStyle(fontSize: 16, color: Colors.red),
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  _WeatherCard({Key? key, required this.weather}) : super(key: key);
  final WeatherList weather;
  final dT = DateTime.now();
  String dataTime(DateTime dt) {
    final minutes = dt.minute < 10 ? '0${dt.minute}' : dt.minute.toString();
    final hours = dt.hour < 10 ? '0${dt.hour}' : dt.hour.toString();
    return '${dt.day}/${dt.month} $hours:$minutes';
  }

  int celsius(double temperature) {
    return (temperature - 273.15).truncate();
  }

  @override
  Widget build(BuildContext context) {
    final weatherCubit = context.read<WeatherCubit>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffea6e4b),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                dataTime(weather.dtTxt),
                style: const TextStyle(fontSize: 14, color: Color(0xffea6e4b)),
              ),
            ),
            Text(
              '?????????????????? ?????? ${celsius(weather.main.feelsLike)}\u2103. ${weather.weather[0].description}',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff48484a)),
            ),
            Row(
              children: [
                Container(
                  child: weatherCubit.getIcon(weather.weather[0].icon),
                  height: 50,
                  width: 50,
                ),
                Column(
                  children: [
                    Text(
                      '${celsius(weather.main.temp).toString()}\u2103',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w100,
                        color: Color(0xff48484a),
                      ),
                    ),
                    Text(
                      '${celsius(weather.main.tempMax)}\u2103/${celsius(weather.main.tempMin)}\u2103',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff48484a),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '??????????: ${weather.wind.speed.toString()} ??/??',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff48484a),
                        ),
                      ),
                      Text(
                        '??????????????????: ${weather.main.humidity.toString()}%',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff48484a),
                        ),
                      ),
                      Text(
                        '??????????????????: ${weather.visibility / 1000}????',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff48484a),
                        ),
                      ),
                      Text(
                        '????????????????????: ${weather.clouds.all.toString()}%',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff48484a),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ListWievBuilder extends StatelessWidget {
  const _ListWievBuilder({Key? key, required this.weatherList})
      : super(key: key);
  final List<WeatherList> weatherList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: weatherList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: _WeatherCard(
            weather: weatherList[index],
          ),
        );
      },
    );
  }
}
