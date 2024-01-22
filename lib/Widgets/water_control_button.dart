import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WaterControlButton extends StatefulWidget {
  WaterControlButton({super.key, required this.waterPumpLogs});
  List<String> waterPumpLogs;
  @override
  State<WaterControlButton> createState() {
    return _WaterControlButtonState();
  }
}

class _WaterControlButtonState extends State<WaterControlButton> {
  late final DatabaseReference databaseReference;
  bool isWaterPumpOn = false;

  @override
  void initState() {
    super.initState();
    databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("water_pump_control").onValue.listen((event) {
      setState(() {
        isWaterPumpOn = (event.snapshot.value as bool?) ?? false;
      });
    });
  }

  void addLog(String log) {
    setState(() {
      widget.waterPumpLogs.add(log);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.waterPumpLogs);
    return ElevatedButton.icon(
      onPressed: toggleWaterPumpControl,
      icon: isWaterPumpOn
          ? const Icon(Icons.power_off, color: Color.fromARGB(255, 7, 2, 82))
          : const Icon(Icons.power, color: Color.fromARGB(255, 7, 2, 82)),
      label: Text(
        isWaterPumpOn ? 'Turn Off Water Pump' : 'Turn On Water Pump',
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 7, 2, 82),
        ),
      ),
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        backgroundColor: MaterialStateProperty.all(
          isWaterPumpOn ? Colors.red : Colors.green,
        ),
      ),
    );
  }

  void toggleWaterPumpControl() async {
    isWaterPumpOn
        ? addLog('Water pump turned off at ${DateTime.now()}')
        : addLog('Water pump turned on at ${DateTime.now()}');
    await databaseReference.update({"water_pump_control": !isWaterPumpOn});
  }

  @override
  void dispose() {
    databaseReference.child("water_pump_control").onValue.listen((event) {});
    super.dispose();
  }
}
