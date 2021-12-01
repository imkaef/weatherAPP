part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class Weatherloading extends WeatherState {}

class WeatherLoaded extends WeatherState {}

class WeatherError extends WeatherState {}
