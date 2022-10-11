class RegistrationFailureRes {
  final String errorCode;
  final String errorMessage;

  const RegistrationFailureRes(
      {required this.errorCode, required this.errorMessage});

  factory RegistrationFailureRes.fromJson(Map<String, dynamic> json) {
    return RegistrationFailureRes(
      errorCode: json['errorCode'],
      errorMessage: json['errorMessage'],
    );
  }
}
