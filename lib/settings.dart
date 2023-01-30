import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:leafwatch/main.dart';
import 'package:leafwatch/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({super.key, required this.title});

  final String title;

  @override
  State<MySettingsPage> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettingsPage> {
  // Is this excessive?
  @override
  Widget build(BuildContext context) {
    var edgeInsets = const EdgeInsets.all(4);
    var buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50), // NEW
      padding: edgeInsets,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            Padding(
              padding: edgeInsets,
              child: const Text(
                "Access your linked accounts and cars, and modify the app to your liking.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Column(key: const Key("settings"), children: [
              Padding(
                padding: edgeInsets,
                child: ElevatedButton(
                  onPressed: () {},
                  style: buttonStyle,
                  child: const Text("Accounts"),
                ),
              ),
              Padding(
                padding: edgeInsets,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const MyPreferencesPage(title: "Preferences");
                    }));
                  },
                  style: buttonStyle,
                  child: const Text("Preferences"),
                ),
              )
            ]),
          ]),
        ));
  }
}

class MyPreferencesPage extends StatefulWidget {
  const MyPreferencesPage({super.key, required this.title});

  final String title;

  @override
  State<MyPreferencesPage> createState() => _MyPreferencesState();
}

class _MyPreferencesState extends State<MyPreferencesPage> {
  Shared shared = (Shared.instance as Shared);
  bool isHorizontal =
      (Shared.instance as Shared).scrollDirection == Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    log(shared.scrollDirection.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            children: [
              const Text("Horizontal Scroll"),
              Switch(
                  value: isHorizontal,
                  onChanged: (on) {
                    shared.scrollDirection =
                        on ? Axis.horizontal : Axis.vertical;
                    setState(() => isHorizontal = on);
                  })
            ],
          )
        ]),
      ),
    );
  }
}
