import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: "Enter City Name"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final city = cityController.text;
                context.read<WeatherBloc>().add(FetchWeather(city));
              },
              child: Text("Search"),
            ),
            SizedBox(height: 20),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitialState) {
                  return Text("Enter a city to begin");
                } else if (state is WeatherLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is WeatherLoadedState) {
                  return Column(
                    children: [
                      Text("Temperature: ${state.weather.temperature} °C",
                          style: TextStyle(fontSize: 20)),
                      Text("Condition: ${state.weather.condition}",
                          style: TextStyle(fontSize: 20)),
                    ],
                  );
                } else if (state is WeatherErrorState) {
                  return Text(state.message, style: TextStyle(color: Colors.red));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
