

import '../models/weather_model.dart';

abstract class WeatherState{}





class WeatherInitialState extends WeatherState{}

class WeatherLoadingState extends WeatherState{}

class WeatherLoadedState extends WeatherState{
  final WeatherModel weather;
  WeatherLoadedState(this.weather);
}

class WeatherErrorState extends WeatherState{
  final String message;
  WeatherErrorState(this.message);

}