import 'package:flutter/material.dart';

class WaterPumpLogs extends StatefulWidget {
  WaterPumpLogs({Key? key, required this.waterPumpLogs}) : super(key: key);
  final List<String> waterPumpLogs;

  @override
  State<WaterPumpLogs> createState() {
    return _WaterPumpLogsState();
  }
}

class _WaterPumpLogsState extends State<WaterPumpLogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Water Pump Logs",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 37, 94),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showClearConfirmationDialog(),
        child: Icon(Icons.clear_all),
        backgroundColor: Color.fromARGB(255, 97, 138, 215),
      ),
      backgroundColor: const Color.fromARGB(255, 7, 37, 94),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.waterPumpLogs.length,
          itemBuilder: (context, index) {
            return Card(
              color: const Color.fromARGB(255, 185, 154, 223),
              elevation: 5.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  widget.waterPumpLogs[index],
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showClearConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Logs '),
          content:
              const Text('Are you sure you want to clear all water pump logs?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.waterPumpLogs.clear();
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Clear', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
