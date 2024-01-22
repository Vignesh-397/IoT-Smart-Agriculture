import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_irrigation_iot/Widgets/distance_widget.dart';
import 'package:smart_irrigation_iot/Widgets/humidity_widget.dart';
import 'package:smart_irrigation_iot/Widgets/moisture_sensor_widget.dart';
import 'package:smart_irrigation_iot/Widgets/temperature_widget.dart';
import 'package:smart_irrigation_iot/Widgets/water_control_button.dart';
import 'package:smart_irrigation_iot/screens/water_pump_logs.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.waterPumpLogs});
  List<String> waterPumpLogs;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start the timer to automatically swipe every 5 seconds (adjust as needed)
    Timer.periodic(const Duration(seconds: 5), (timer) {
      _currentPageIndex =
          (_currentPageIndex + 1) % 2; // 2 is the total number of pages
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF6495ED),
        title: const Text(
          'Eco Connect',
          style: TextStyle(
            fontFamily: 'Pacifico',
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WaterPumpLogs(
                    waterPumpLogs: widget.waterPumpLogs,
                  ),
                ));
              },
              icon: const Icon(Icons.history))
        ],
      ),
      backgroundColor: const Color(0xFF6495ED),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: PageView(
                  controller: _pageController,
                  children: const [
                    TemperatureWidget(),
                    HumidityWidget(),
                  ],
                ),
              ),
              const MoistureSensorWidget(),
              const AnimalDetectionWidget(),
              const SizedBox(height: 20),
              WaterControlButton(waterPumpLogs: widget.waterPumpLogs),
            ],
          ),
        ),
      ),
    );
  }
}
