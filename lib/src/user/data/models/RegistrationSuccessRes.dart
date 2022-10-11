class RegistrationSuccessRes {
  final String successCode;
  final String successMessage;

  const RegistrationSuccessRes(
      {required this.successCode, required this.successMessage});

  factory RegistrationSuccessRes.fromJson(Map<String, dynamic> json) {
    return RegistrationSuccessRes(
      successCode: json['successCode'],
      successMessage: json['successMessage'],
    );
  }
}
