import 'package:flutter/material.dart';
import '../view_models/weather_view_model.dart';
import 'widgets/current_weather_widget.dart';
import 'widgets/forecast_grid_widget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final WeatherViewModel _viewModel = WeatherViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: StreamBuilder<WeatherViewState>(
        stream: _viewModel.state,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final state = snapshot.data!;
            if (state is WeatherLoading) {
              return _buildLoadingView();
            } else if (state is WeatherLoaded) {
              return _buildWeatherView(state);
            } else if (state is WeatherError) {
              return _buildErrorView(state);
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildWeatherView(WeatherLoaded state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CurrentWeatherWidget(weather: state.weatherModel.currentWeather),
          SizedBox(height: 20),
          ForecastGridWidget(forecast: state.weatherModel.forecast),
        ],
      ),
    );
  }

  Widget _buildErrorView(WeatherError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.message, style: TextStyle(color: Colors.red)),
          ElevatedButton(
            child: Text('Retry'),
            onPressed: _viewModel.fetchWeather,
          ),
        ],
      ),
    );
  }
}