import 'package:flutter/material.dart';

class PermissionScreen extends StatefulWidget {
  PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child:const Text("Give Permission Screen..."));
  }
}