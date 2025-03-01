import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController efficiencyController = TextEditingController();

  void addVehicle() {
    FirebaseFirestore.instance.collection('vehicles').add({
      'make': makeController.text.toString(),
      'model': modelController.text.toString(),
      'year': int.parse(yearController.text),
      'fuel Efficiency': double.parse(efficiencyController.text),
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Vehicle', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: makeController,
              decoration: InputDecoration(labelText: 'Make', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: modelController,
              decoration: InputDecoration(labelText: 'Model', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: yearController,
              decoration: InputDecoration(labelText: 'Year', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: efficiencyController,
              decoration: InputDecoration(labelText: 'FuelEfficiency (km/l)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: addVehicle,
              child: Text('Add Vehicle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

