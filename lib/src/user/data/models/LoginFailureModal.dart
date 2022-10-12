// ignore_for_file: file_names

class LoginFailureModal {
  int? statusCode;
  String? message;
  String? error;

  LoginFailureModal({this.statusCode, this.message, this.error});

  LoginFailureModal.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
