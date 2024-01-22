import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AnimalDetectionWidget extends StatefulWidget {
  const AnimalDetectionWidget({Key? key}) : super(key: key);

  @override
  _AnimalDetectionWidgetState createState() => _AnimalDetectionWidgetState();
}

class _AnimalDetectionWidgetState extends State<AnimalDetectionWidget> {
  late DatabaseReference animalDetectionReference;
  bool isAnimalDetected = false;
  int animalDistance = 0;

  @override
  void initState() {
    super.initState();
    animalDetectionReference =
        FirebaseDatabase.instance.ref().child('distance');
    animalDetectionReference.onValue.listen((event) {
      setState(() {
        int distance = event.snapshot.value as int;
        isAnimalDetected =
            distance < 50; // Assuming 50 as the detection threshold
        animalDistance = distance;

        if (isAnimalDetected) {
          // If an animal is detected, show a dialog
          showAnimalDetectedDialog();
        }
      });
    });
  }

  IconData determineDetectionIcon() {
    return isAnimalDetected ? Icons.warning : Icons.eco;
  }

  void showAnimalDetectedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(width: 8),
              Text(
                'Animal Detected!',
              ),
            ],
          ),
          content: Text('An animal is detected at $animalDistance meters.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.white, // Change alert background color
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    IconData detectionIcon = determineDetectionIcon();

    return Container(
      width: double.infinity,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isAnimalDetected
                  ? [Colors.red, Colors.red.shade200] // Detected colors
                  : [
                      Colors.green,
                      Colors.green.shade200
                    ], // Not detected colors
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  detectionIcon,
                  color: Colors.green[100],
                  size: 40,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Animal Detection',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                isAnimalDetected
                    ? Text(
                        'Animal Detected at $animalDistance meters',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      )
                    : const Text(
                        'No Animal Detected',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
