import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hava_durumu/screens/main_screen.dart';
import 'package:flutter_hava_durumu/utils/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_hava_durumu/utils/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper? locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData!.getCurrentLocation();
    if (locationData!.longitude == null) {
    } else {
      print("Latitude: " + locationData!.latitude.toString());
      print("Longitude: " + locationData!.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(locationData: locationData!);
    await weatherData.getCurrentTemperature();
    if (weatherData.currentCondition == null ||
        weatherData.currentTemperature == null) {
      print("Apiden sıcaklık ve durum bilgisi boş dönüyor");
    }
    // mainscren e gitmek için kulllandık 
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(weatherData: weatherData,);
    }));
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.yellow, Colors.green])),
        child: const Center(
          child: SpinKitCubeGrid(
            color: Colors.white,
            size: 150,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<LocationHelper>('locationData', locationData));
    properties
        .add(DiagnosticsProperty<LocationHelper>('locationData', locationData));
    properties
        .add(DiagnosticsProperty<LocationHelper>('locationData', locationData));
    properties
        .add(DiagnosticsProperty<LocationHelper>('locationData', locationData));
  }
}
