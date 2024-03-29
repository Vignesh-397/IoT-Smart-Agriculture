import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MoistureSensorWidget extends StatefulWidget {
  const MoistureSensorWidget({Key? key}) : super(key: key);

  @override
  _MoistureSensorWidgetState createState() => _MoistureSensorWidgetState();
}

class _MoistureSensorWidgetState extends State<MoistureSensorWidget> {
  late DatabaseReference moistureReference;
  int moistureLevel = 0;
  String wateringStatus = "Loading...";
  List<Color> colors = const [
    Color(0xFFADD8E6),
    Color(0xFF90EE90),
  ];

  @override
  void initState() {
    super.initState();
    moistureReference = FirebaseDatabase.instance.ref().child('soilMoisture');
    moistureReference.onValue.listen((event) {
      setState(() {
        moistureLevel = event.snapshot.value as int;
      });
    });
  }

  IconData determineStatusIcon(int moistureLevel) {
    return moistureLevel > 30 ? Icons.warning : Icons.water_drop;
  }

  @override
  Widget build(BuildContext context) {
    IconData statusIcon = determineStatusIcon(moistureLevel);
    if (moistureLevel > 50 && moistureLevel <= 70) {
      colors = const [
        Color(0xFF4682B4), // Medium Blue
        Color(0xFF3CB371), // Medium Green
      ];
    } else if (moistureLevel > 70) {
      colors = const [
        Color(0xFFFF6347), // Tomato Red
        Color(0xFFFFA07A), // Light Salmon
      ];
    } else {
      colors = const [
        Color(0xFF000080), // Dark Blue
        Color(0xFF006400), // Dark Green
      ];
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      statusIcon,
                      color: moistureLevel > 30 ? Colors.red : Colors.blue,
                      size: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Moisture Level',
                      style: moistureLevel < 30
                          ? const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 221, 210, 210))
                          : const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$moistureLevel%',
                      style: moistureLevel < 30
                          ? const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 221, 210, 210))
                          : const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    moistureLevel > 80
                        ? const Text(
                            'Very low moisture level: Immediate watering required',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          )
                        : moistureLevel > 60
                            ? const Text(
                                'Low moisture level: Watering required',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red),
                              )
                            : moistureLevel > 40
                                ? const Text(
                                    'Moderate moisture level: Check if watering is needed',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  )
                                : const Text(
                                    'High moisture level: Soil is well-watered',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.green),
                                  ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
