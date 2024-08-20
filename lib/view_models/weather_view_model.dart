import 'dart:async';
import '../models/weather_model.dart';
import '../services/location_services.dart';
import '../services/weather_services.dart';

abstract class WeatherViewState {}

class WeatherLoading extends WeatherViewState {}

class WeatherLoaded extends WeatherViewState {
  final WeatherModel weatherModel;
  WeatherLoaded(this.weatherModel);
}

class WeatherError extends WeatherViewState {
  final String message;
  WeatherError(this.message);
}

class WeatherViewModel {
  final _weatherService = WeatherService('f31ba869e59660f0a9cc4c4ba7ad6386');
  final _locationService = LocationService();
  final _stateController = StreamController<WeatherViewState>.broadcast();

  Stream<WeatherViewState> get state => _stateController.stream;

  Future<void> fetchWeather() async {
    _stateController.add(WeatherLoading());
    try {
      final position = await _locationService.getCurrentLocation();
      final weatherModel = await _weatherService.getWeather(
        position.latitude,
        position.longitude,
      );
      _stateController.add(WeatherLoaded(weatherModel));
    } catch (e) {
      _stateController.add(WeatherError(_getErrorMessage(e)));
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is Exception) {
      if (error.toString().contains('Location permission denied')) {
        return 'Location permission denied. Please enable location services.';
      } else if (error.toString().contains('Network is unreachable')) {
        return 'No internet connection. Please check your network settings.';
      }
    }
    return 'Failed to fetch weather data: ${error.toString()}';
  }

  void dispose() {
    _stateController.close();
  }
}