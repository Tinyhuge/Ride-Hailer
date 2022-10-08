import 'package:flutter/material.dart';

class MapGoScreen extends StatefulWidget {
  MapGoScreen({Key? key}) : super(key: key);

  @override
  State<MapGoScreen> createState() => _MapGoScreenState();
}

class _MapGoScreenState extends State<MapGoScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: Center(
              child: Text("Map Go Screen..", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            )));
  }
}
