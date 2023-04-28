import 'package:flutter/material.dart';
import 'package:leafwatch/accounts.dart';
import 'package:leafwatch/main.dart';

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
  bool updating = false;

  @override
  Widget build(BuildContext context) {
    print("Building?");
    // Accounts.instance.getAccounts().then(print);

    return TextButton(
        onPressed: () {
          setState(() {
            updating = true;
          });
          widget.vehicle.getCharge().then((value) {
            print(value);
            setState(() {
              charge = value;
              updating = false;
            });
          });
        },
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  updating
                      ? const Text("Updating...")
                      : Text("Last updated ${widget.vehicle.lastUpdated}"),
                  const Spacer(),
                  IconButton(
                      onPressed: () => showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text("Delete ${widget.vehicle.username}?"),
                              content: const Text(
                                  'Don\'t delete this unless you need to readd it, or don\'t need it anymore'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Accounts.instance.remove(widget.vehicle.id);
                                    Accounts.instance.saveAccounts();
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          ),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 35,
                      )),
                ],
              ),
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
