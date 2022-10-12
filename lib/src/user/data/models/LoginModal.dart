// ignore_for_file: file_names

class LoginModal {
  int? successCode;
  String? successMessage;
  Response? response;

  LoginModal({this.successCode, this.successMessage, this.response});

  LoginModal.fromJson(Map<String, dynamic> json) {
    successCode = json['successCode'];
    successMessage = json['successMessage'];
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['successCode'] = successCode;
    data['successMessage'] = successMessage;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class Response {
  String? id;
  String? email;
  String? name;
  String? userType;
  String? accessToken;
  String? deviceToken;

  Response(
      {this.id,
      this.email,
      this.name,
      this.userType,
      this.accessToken,
      this.deviceToken});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    userType = json['user_type'];
    accessToken = json['accessToken'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['user_type'] = userType;
    data['accessToken'] = accessToken;
    data['device_token'] = deviceToken;
    return data;
  }
}
