// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hava_durumu/utils/weather.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    required this.weatherData,
  }) : super(key: key);

  final WeatherData weatherData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late int temperatureFeel;
  late Icon weatherDisplatIcon;
  late AssetImage backgroundImage;
  late String city;
  late var sunrise;
  late var cntr;

  void updateDisplatInfo(WeatherData weatherData) {
    setState(() {
      temperatureFeel = weatherData.currentTemperatureFeel.round();
      temperature = weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplatIcon = weatherDisplayData.weatherIcon;
      city = weatherData.city;
      cntr = weatherData.cntr.toString();
      sunrise = weatherData.sunrise;
    });
  }

  String currentTime = '';

  @override
  void initState() {
    updateDisplatInfo(widget.weatherData);

    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => updateClock());
  }

  void updateClock() {
    setState(() {
      currentTime = DateFormat.Hm().format(DateTime.now());
    });
  }

  /* @override
  void initState() {
    super.initState();
    updateDisplatInfo(widget.weatherData);
  } */

  @override
  Widget build(BuildContext context) {
    //String formattedTime = DateFormat.Hm().format(DateTime.parse(sunrise));
    return Scaffold(
      body: Container(
        constraints: BoxConstraints
            .expand(), // farklı çözünürlükte ki cihazlarda çalışması için
        decoration: BoxDecoration(
          image: DecorationImage(image: backgroundImage, fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(child: weatherDisplatIcon),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                " Sıcaklık \n     $temperature°",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                " Hissedilen Sıcaklık \n               $temperature°",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                currentTime,
                style: TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "$city ,$cntr",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
