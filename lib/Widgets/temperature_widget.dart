import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TemperatureWidget extends StatefulWidget {
  const TemperatureWidget({Key? key}) : super(key: key);

  @override
  State<TemperatureWidget> createState() => _TemperatureWidgetState();
}

class _TemperatureWidgetState extends State<TemperatureWidget> {
  late DatabaseReference sensorReference;
  String sensorData = "Loading...";
  double temp = 0.0;

  @override
  void initState() {
    super.initState();
    sensorReference = FirebaseDatabase.instance.ref().child('temperature');
    sensorReference.onValue.listen((event) {
      final dynamic value = event.snapshot.value;
      if (value != null) {
        setState(() {
          temp = value.toDouble();
          sensorData =
              temp.toStringAsFixed(2); // Format to display two decimal places
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
          temp > 20
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/temp1.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/temp2.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  temp > 20
                      ? const Icon(
                          Icons.wb_sunny,
                          color: Colors.orange,
                          size: 40,
                        )
                      : const Icon(
                          Icons.cloud,
                          color: Colors.blue,
                          size: 40,
                        ),
                  const SizedBox(height: 8),
                  const Text(
                    'Temperature',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$sensorData°C',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  temp > 20
                      ? const Text(
                          'Sunny and pleasant',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        )
                      : const Text(
                          'Cloudy',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
