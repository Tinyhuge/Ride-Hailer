// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ride_hailer/src/user/constants/image_urls.dart';
import 'package:ride_hailer/src/user/pages/extra/login_screen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key, required this.isDriver});

  bool isDriver;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String fName = "";
  String lName = "";
  String email = "";
  String phone = "";
  String password = "";
  String dropdownvalue = 'Car';
  String vehicleRegistrationNumber = "KA${Random().nextInt(6)}";
  double lat = 0.0;
  double long = 0.0;
  String randomProfileUrl = ImageUrls
      .dummyProfileList[Random().nextInt(ImageUrls.dummyProfileList.length)];

  // List of items in our dropdown menu
  var items = ['Car', 'Bike', 'Auto', 'Bus'];

  Map<String, dynamic> requestDataUser = {
    'firstName': 'A',
    'lastName': 'B',
    'email': 'C',
    'password': 'C',
    'deviceToken': 'C',
    'userType': 'C',
    'mobileNumber': 'C',
    'profilePicUrl': 'C',
  };

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              child: parentLayout(context)),
        ));
  }

  Future<String> getDeviceCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lattitude = position.latitude;
    double longitude = position.longitude;
    String latString = lattitude.toString();
    String longString = longitude.toString();
    String latlongString = "$latString,$longString";

    setState(() {
      lat = lattitude;
      long = longitude;
    });

    print("Lattitude : $lattitude");
    print("Longitude : $longitude");
    print("Timestamp : ${position.timestamp}");
    print("Speed : ${position.speed}");

    return latlongString;
  }

  Future<void> getLocationNameFromLatLong() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    for (var place in placemarks) {
      {
        print("Place : $place");
      }
    }
  }

  Widget vehicleDropDown() {
    return Visibility(
      visible: widget.isDriver == true ? true : false,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8, bottom: 6),
            width: MediaQuery.of(context).size.width,
            child: const Text("Choose Your Vehicle Type",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: DropdownButton(
                hint: const Text("Choose Vehicle Type"),
                style: const TextStyle(
                    // fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color.fromARGB(255, 39, 35, 35)),
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(items),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget parentLayout(BuildContext context) {
    return Center(
      child: Container(
          //  height: 400,
          margin: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text("Create Account",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600)),
              const SizedBox(height: 30),
              textFieldWidget(
                  onTextChange: (value) {
                    setState(() {
                      fName = value;
                    });
                  },
                  hintText: "First Name",
                  icon: Icons.person,
                  inputType: TextInputType.name,
                  prefixColor: Colors.yellow,
                  initialValue: ""),
              const SizedBox(height: 15),
              textFieldWidget(
                  onTextChange: (value) {
                    setState(() {
                      lName = value;
                    });
                  },
                  hintText: "Last Name",
                  icon: Icons.person,
                  inputType: TextInputType.name,
                  prefixColor: Colors.yellow,
                  initialValue: ""),
              const SizedBox(height: 15),
              textFieldWidget(
                  onTextChange: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  hintText: "Email",
                  icon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  prefixColor: Colors.yellow,
                  initialValue: ""),
              const SizedBox(height: 15),
              textFieldWidget(
                  onTextChange: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                  hintText: "Phone",
                  icon: Icons.phone,
                  inputType: TextInputType.phone,
                  prefixColor: Colors.yellow,
                  initialValue: ""),
              const SizedBox(height: 15),
              textFieldWidget(
                  onTextChange: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  hintText: "Password",
                  icon: Icons.password,
                  inputType: TextInputType.visiblePassword,
                  prefixColor: Colors.yellow,
                  initialValue: ""),
              const SizedBox(height: 15),
              vehicleDropDown(),
              const SizedBox(height: 30),
              calculateFareButton(context),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Have Account?",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(width: 7),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen(
                                  isDriver: widget.isDriver,
                                )),
                        (route) {
                          return true;
                        },
                      );
                    },
                    child: const Text("Login",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          )),
    );
  }

  Widget calculateFareButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 7, right: 7, top: 7),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: GestureDetector(
        onLongPress: () {
          getLocationNameFromLatLong();
        },
        child: ElevatedButton(
            onPressed: () {
              getDeviceCurrentLocation();
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepPurple[400]!),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ))),
            child: const Text(
              "Create Account",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )),
      ),
    );
  }

  Widget textFieldWidget(
      {required Color prefixColor,
      required String initialValue,
      required IconData icon,
      required TextInputType inputType,
      required String hintText,
      Function()? onTap,
      Function(String)? onTextChange}) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: TextFormField(
            onChanged: onTextChange,
            keyboardType: inputType,
            autofocus: false,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: const Icon(Icons.bookmark_border_outlined),
                prefixIcon: Icon(icon),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                )),
            initialValue: initialValue,
            onTap: onTap));
  }
}
