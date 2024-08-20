import 'package:weather/weather.dart';

class WeatherModel {
  final Weather currentWeather;
  final List<Weather> forecast;

  WeatherModel({required this.currentWeather, required this.forecast});
}