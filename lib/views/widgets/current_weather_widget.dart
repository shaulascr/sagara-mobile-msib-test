import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final Weather weather;

  const CurrentWeatherWidget({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Weather', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            Text('Description: ${weather.weatherDescription}'),
            Text('Temperature: ${weather.temperature?.celsius?.toStringAsFixed(1)}°C'),
          ],
        ),
      ),
    );
  }
}