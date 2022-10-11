import 'dart:convert';
import 'package:ride_hailer/src/user/data/endpoints/api.dart';
import 'package:ride_hailer/src/user/data/models/RegistrationSuccessRes.dart';
import 'package:http/http.dart' as http;

class RestMethod {
  Future<RegistrationSuccessRes> registerUser(
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
      "device_token": "",
      "user_type": mobileNumber,
      "profile_pic_url": profilePicUrl,
      "location": locationName,
      "location_latlong": locationLatLong,
      "vehicle_type": vehicleType,
      "vehicle_registration_number": vehicleRegisterationNumber
    };
    String jsonBody = jsonEncode(body);
    final response = await http.post(Uri.parse(API.registerUser), body: body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return RegistrationSuccessRes.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
