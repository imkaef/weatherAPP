import 'package:bloc/bloc.dart';
import 'package:friflex_weather_test/entities/weather.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.city}) : super(WeatherInitial());

  final String city;

  void internial() {}
}
