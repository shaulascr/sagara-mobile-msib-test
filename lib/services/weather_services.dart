import 'package:weather/weather.dart';
import '../models/weather_model.dart';

class WeatherService {
  final WeatherFactory _wf;

  WeatherService(String apiKey) : _wf = WeatherFactory(apiKey);

  Future<WeatherModel> getWeather(double lat, double lon) async {
    Weather currentWeather = await _wf.currentWeatherByLocation(lat, lon);
    List<Weather> forecast = await _wf.fiveDayForecastByLocation(lat, lon);
    return WeatherModel(currentWeather: currentWeather, forecast: forecast);
  }
}