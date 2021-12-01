import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friflex_weather_test/pages/cubit/weather_cubit.dart';

class WeatherSecreenWidget extends StatelessWidget {
  const WeatherSecreenWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<WeatherCubit>().city),
      ),
      body: _Weather(),
    );
  }
}

class _Weather extends StatelessWidget {
  const _Weather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitial) {
          context.read<WeatherCubit>().internial();
          return _DownloadWidget(
            state: state,
          );
        }
        if (state is WeatherLoaded) {
          // context.read<PicturesCubit>().loadPictures();
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
  Widget build(
    BuildContext context,
  ) {
    return Container();
  }
}

class _LoadedWidget extends StatelessWidget {
  const _LoadedWidget({Key? key, required this.state}) : super(key: key);
  final WeatherLoaded state;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({Key? key, required this.state}) : super(key: key);
  final WeatherError state;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
