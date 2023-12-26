import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'location.dart';

const apiKey = "298b5112ffd03c910e3a7dc46d9d6d3e";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;
  WeatherDisplayData({
    required this.weatherIcon,
    required this.weatherImage,
  });
}

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  late double currentTemperature;
  late double currentTemperatureFeel;
  late int currentCondition;
  late String city;
  late var sunrise;
  late var cntr;

  Future<void> getCurrentTemperature() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric');
    var response = await get(url);

    if (response.statusCode == 200) {
      var data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather["main"]["temp"];
        currentTemperatureFeel = currentWeather["main"]["feels_like"];
        currentCondition = currentWeather["weather"][0]["id"];
        city = currentWeather["name"];
        cntr = currentWeather["sys"]["country"];
        sunrise = currentWeather["sys"]["sunrise"];
      } catch (e) {
        print(e);
      }
    } else {
      print("Api den değer gelmiyor");
    }
  }

  getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloudSun,
            size: 75,
            color: Colors.white,
          ),
          weatherImage: AssetImage("assets/kapalı.jpg"));
    } else {
      var now = new DateTime.now();
      if (now.hour >= 19) {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 75,
              color: Colors.white,
            ),
            weatherImage: AssetImage("assets/gecee.jpg"));
      } else {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 75,
              color: Colors.yellow,
            ),
            weatherImage: AssetImage("assets/gunesli.jpg"));
      }
    }
  }
}
