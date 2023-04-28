import 'package:flutter/material.dart';
import 'package:leafwatch/accounts.dart';
import 'package:leafwatch/login.dart';
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

  // test() {
  //   var test = PageView();
  //   test.physics = ScrollPhysics().
  // }

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Widget> pages = [const LoginWidget()];

  update() {
    getDriveWay().then((value) {
      setState(() {
        pages = [
          ...value,
          const LoginWidget(),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getDriveWay().then((value) {
      update();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (PageView(
        scrollDirection: Axis.vertical,
        children: pages,
      )),
    );
  }

  Future<List<Widget>> getDriveWay() async {
    var accounts = await Accounts.instance.getAccounts();
    List<Widget> vehicles = [];
    accounts.forEach((type, values) {
      values.forEach((id, account) {
        vehicles.add(VehicleWidget(vehicle: account));
      });
    });
    return vehicles;
  }
}
