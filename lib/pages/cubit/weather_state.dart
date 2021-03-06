part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class Weatherloading extends WeatherState {}

class WeatherLoaded extends WeatherState {
   final Data data;
  WeatherLoaded(this.data);
}

class WeatherError extends WeatherState {
  final String errorMessage;
  WeatherError(this.errorMessage);
}
