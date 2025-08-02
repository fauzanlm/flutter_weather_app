import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/model/weather_model.dart';
import 'package:my_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherService = WeatherService('YOUR API KEY');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();
    // print('City Name : ' + cityName);

    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error : $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchWeather();
  }

  String getAnimationAsset(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'drizzle':
        return 'assets/rainny.json';
      case 'rain':
        return 'assets/rainny.json';
      case 'snow':
      case 'mist':
        return 'assets/cloud.json';
      case 'smoke':
      case 'haze':
        return 'assets/cloud.json';
      case 'dust':
        return 'assets/cloud.json';
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
      case 'clear':
        return 'assets/sunny.json';
      case 'clouds':
        return 'assets/cloud.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: _weather == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _weather?.cityName ?? "Loading City...",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 50),
                  LottieBuilder.asset(
                    getAnimationAsset(_weather?.mainCondition),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    '${_weather?.temprature.round()}°C',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    _weather?.mainCondition ?? "Loading",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
