import 'package:flutter/material.dart';
import 'package:leafwatch/remote.dart';

class Vehicle {
  Vehicle({required this.name, required this.username, required this.password});

  String name;

  String username;
  String password;

  CarState? _cachedState;
  Future<CarState> state() {
    if (_cachedState == null) {
      var get = CarState().get();
      get.then((value) {
        _cachedState = value;
      });
      return get;
    } else {
      return Future.value(_cachedState);
    }
  }
}

class CarState {
  Future<CarState> get() {
    return Future<CarState>(
      () {
        return CarState();
      },
    );
  }
}

final testVehicle = Vehicle(name: "placeholder", username: "", password: "");

class VehicleWidget extends StatefulWidget {
  const VehicleWidget({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  State<VehicleWidget> createState() => _VehicleState();
}

class _VehicleState extends State<VehicleWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                child: Text(
                  widget.vehicle.name,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4),
                    child: Text("Charge"),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: LinearProgressIndicator(
                        value: (() => 0.5)(),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
