import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_irrigation_iot/firebase_options.dart';
import 'package:smart_irrigation_iot/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<String> waterPumpLogs = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Irrigation App',
      home: HomePage(waterPumpLogs: waterPumpLogs),
      debugShowCheckedModeBanner: false,
    );
  }
}
