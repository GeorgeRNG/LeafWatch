import 'package:flutter/material.dart';
import 'package:leafwatch/accounts.dart';

class CarState {
  Future<CarState> get() {
    return Future<CarState>(
      () {
        return CarState();
      },
    );
  }
}

class VehicleWidget extends StatefulWidget {
  const VehicleWidget({super.key, required this.vehicle});

  final Account vehicle;

  @override
  State<VehicleWidget> createState() => _VehicleState();
}

class _VehicleState extends State<VehicleWidget> {
  double charge = -1;

  @override
  Widget build(BuildContext context) {
    print("Building");

    return TextButton(
        onPressed: () {
          widget.vehicle.getCharge().then((value) {
            print(value);
            setState(() {
              charge = value;
            });
          });
        },
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                child: Text(
                  widget.vehicle.username,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text("Charge: ${(charge * 100).floor()}%"),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: LinearProgressIndicator(
                        value: charge,
                        minHeight: 30,
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
