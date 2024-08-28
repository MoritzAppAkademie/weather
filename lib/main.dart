import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _weather = "Lädt...";

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    var url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=52.5200&longitude=13.4050&current_weather=true');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var currentWeather = jsonData['current_weather'];
      setState(() {
        _weather =
            "Aktuelle Temperatur in Berlin: ${currentWeather['temperature']}°C";
      });
    } else {
      setState(() {
        _weather = "Fehler beim Laden des Wetters";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wetter in Berlin'),
      ),
      body: Center(
        child: Text(_weather),
      ),
    );
  }
}
