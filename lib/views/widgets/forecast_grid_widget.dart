import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class ForecastGridWidget extends StatelessWidget {
  final List<Weather> forecast;

  const ForecastGridWidget({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('3-Day Forecast', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
          ),
          itemCount: forecast.take(3).length,
          itemBuilder: (context, index) {
            final weather = forecast[index];
            return Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(weather.date?.toString().split(' ')[0] ?? ''),
                    Text(weather.weatherDescription ?? ''),
                    Text('${weather.temperature?.celsius?.toStringAsFixed(1)}°C'),
                    Text('Min: ${weather.tempMin?.celsius?.toStringAsFixed(1)}°C'),
                    Text('Max: ${weather.tempMax?.celsius?.toStringAsFixed(1)}°C'),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}