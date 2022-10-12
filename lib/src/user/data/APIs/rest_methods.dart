// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:ride_hailer/src/user/data/endpoints/api.dart';
import 'package:ride_hailer/src/user/data/models/LoginModal.dart';
import 'package:ride_hailer/src/user/data/models/RegistrationFailureRes.dart';
import 'package:ride_hailer/src/user/data/models/RegistrationSuccessRes.dart';
import 'package:http/http.dart' as http;

class RestMethod {
  Future<dynamic> registerUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String deviceToken,
      required String userType,
      required int mobileNumber,
      required String profilePicUrl,
      required String locationName,
      required String locationLatLong,
      required String vehicleType,
      required String vehicleRegisterationNumber}) async {
    Map<String, dynamic> body = {
      "fname": firstName,
      "lname": lastName,
      "email": email,
      "password": password,
      "device_token": deviceToken,
      "user_type": userType,
      "mobile_number": mobileNumber,
      "profile_pic_url": profilePicUrl,
      "location": locationName,
      "location_latlong": locationLatLong,
      "vehicle_type": vehicleType,
      "vehicle_registration_number": vehicleRegisterationNumber
    };
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    String jsonBody = jsonEncode(body);
    final response = await http.post(Uri.parse(API.registerUser),
        headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final String responseString = response.body;
      print("Res : $responseString");
      return RegistrationSuccessRes.fromJson(jsonDecode(response.body));
    } else {
      return RegistrationFailureRes.fromJson(jsonDecode(response.body));
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // throw Exception('Failed registering User');
    }
  }

  Future<LoginModal> loginUser(
      {required String email, required String password}) async {
    Map<String, dynamic> body = {"email": email, "password": password};
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    String jsonBody = jsonEncode(body);
    final response = await http.post(Uri.parse(API.loginUser),
        headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      final String responseString = response.body;
      print("Res : $responseString");
      return LoginModal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed Login User!!');
    }
  }
}
