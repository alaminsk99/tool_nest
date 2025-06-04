import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherRepository {
  final String apiKey = '7744f21cde5e4dfa6de3249b87d5519f';

  Future<WeatherModel> fetchWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch weather');
    }
  }
}
