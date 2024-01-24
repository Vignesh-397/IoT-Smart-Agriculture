import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HumidityWidget extends StatefulWidget {
  const HumidityWidget({Key? key}) : super(key: key);

  @override
  _HumidityWidgetState createState() => _HumidityWidgetState();
}

class _HumidityWidgetState extends State<HumidityWidget> {
  late DatabaseReference sensorReference;
  String humidityData = "Loading...";
  double humidity = 0.0; // Change data type to double

  @override
  void initState() {
    super.initState();
    sensorReference = FirebaseDatabase.instance.ref().child('humidity');
    sensorReference.onValue.listen((event) {
      final dynamic value = event.snapshot.value;
      if (value != null) {
        setState(() {
          humidity = value.toDouble();
          humidityData =
              humidity.toInt().toString(); // Convert to int and then to string
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          humidity > 50
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/hum1.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/hum2.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  humidity > 50
                      ? const Icon(
                          Icons.opacity,
                          color: Colors.blue,
                          size: 40,
                        )
                      : const Icon(
                          Icons.cloud_off,
                          color: Colors.orange,
                          size: 40,
                        ),
                  const SizedBox(height: 8),
                  const Text(
                    'Humidity',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$humidityData%', // Display formatted humidity
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    humidity > 50
                        ? 'High humidity level'
                        : 'Low humidity level',
                    style: const TextStyle(
                        fontSize: 16, color: Color.fromARGB(214, 8, 34, 90)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
