import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vehicleapp/vehicleListApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCztFgFWyuLVU1oQK23BTwm228LDjeLt-I",
          appId: "1:1089593777730:android:774098295efc58640c17db",
          messagingSenderId: "1089593777730",
          projectId: "vehicleapp-5867e"
      ),
    );
  runApp(VehicleApp());
}
  catch(error){
    if (kDebugMode) {
      print(error) ;
    }

  }
}



class VehicleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VehicleListScreen(),
    );
  }
}