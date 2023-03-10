import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:leafwatch/shared.dart';
import 'package:leafwatch/vehicle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leaf Watch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme:
          ThemeData(primarySwatch: Colors.blue, textTheme: const TextTheme()),
      home: const MyHomePage(title: 'My Leaf Watch'),
      color: Colors.blue,
      themeMode: ThemeMode.light, // Dark mode soon.
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (PageView(
        scrollDirection: Axis.vertical,
        children: [
          VehicleWidget(vehicle: testVehicle),
          VehicleWidget(vehicle: testVehicle),
        ],
      )),
    );
  }
}
