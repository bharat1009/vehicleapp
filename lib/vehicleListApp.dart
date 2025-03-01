import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicleapp/vehicleAddApp.dart';

class VehicleListScreen extends StatelessWidget {
  final CollectionReference vehicles =
      FirebaseFirestore.instance.collection('vehicles');

  Color getColor(int year, double fuelEfficiency) {
    int currentYear = DateTime.now().year;
    int age = currentYear - year;
    if (fuelEfficiency >= 15) {
      return age <= 5 ? Colors.green : Colors.amber;
    }
    return Colors.red;
  }

  void deleteVehicle(String id) {
    FirebaseFirestore.instance.collection('vehicles').doc(id).delete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vehicles List', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: vehicles.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: EdgeInsets.all(10.0),
              children: snapshot.data!.docs.map((document) {
                var data = document.data() as Map<String, dynamic>;
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  color: getColor(data['year'], data['fuelEfficiency']),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    title: Text("${data['make']} ${data['model']}",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      "Year: ${data['year']} - Efficiency: ${data['fuelEfficiency']} km/l",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    leading: Icon(Icons.directions_car, color: Colors.white, size: 30),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () => deleteVehicle(document.id),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('Add Vehicle',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          backgroundColor: Colors.blueAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVehicleScreen()),
          ),
        ));
  }
}
