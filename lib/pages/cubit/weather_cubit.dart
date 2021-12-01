import 'package:bloc/bloc.dart';
import 'package:friflex_weather_test/api_client/api_client.dart';
import 'package:friflex_weather_test/entities/weather.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.city}) : super(WeatherInitial());

  final String city;
  final _apiClient = ApiClient();
  Future<void> internial() async {
    try {
      emit(WeatherInitial());
      final data = await _apiClient.fetchWeather(city);
      emit(WeatherLoaded(data));
    } on Exception {
      emit(WeatherError('Ошибка получения данных.'));
    }
  }
}
