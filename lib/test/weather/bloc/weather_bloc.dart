

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tool_nest/test/weather/bloc/weather_event.dart';
import 'package:tool_nest/test/weather/bloc/weather_state.dart';

import '../repository/weather_repository.dart';



class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  final WeatherRepository repository;
  WeatherBloc(this.repository): super(WeatherInitialState()){
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        final weather = await repository.fetchWeather(event.cityName);
        emit(WeatherLoadedState(weather));
      } catch (e) {
        emit(WeatherErrorState("Could not fetch weather"));
      }
    }

    );


  }
}