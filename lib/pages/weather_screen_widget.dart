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
      ),
      body: const _Weather(),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Сводка погоды'),
          Expanded(
            child: _ListWievBuilder(weatherList: state.data.list),
          ),
        ],
      ),
    );
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
    return '${dt.day}/${dt.month}/${dt.year} $hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    final weatherCubit = context.read<WeatherCubit>();
    return Column(
      children: [
        Text('Температура на: ${dataTime(weather.dtTxt)}'),
        weather.rain == null
            ? Text('Дождя нет')
            : Text(weather.rain!.n3h.toString()),
        weatherCubit.getIcon(weather.weather[0].icon),
        Text('Скорость ветра'),
        Text(weather.wind.speed.toString()),
        Text('Облака'),
        Text(weather.clouds.all.toString()),
        Text('Ощущается как '),
        Text(weather.main.feelsLike.toString()),
        Text('температура сейчас'),
        Text(weather.main.temp.toString()),
        Text('Макс температура '),
        Text(weather.main.tempMax.toString()),
        Text('Мин температура '),
        Text(weather.main.tempMin.toString()),
        Text('Дальность видимости'),
        Text(weather.visibility.toString()),
        Text('Описание'),
        Text(weather.weather[0].description),
      ],
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
        return _WeatherCard(
          weather: weatherList[index],
        );
      },
    );
  }
}
