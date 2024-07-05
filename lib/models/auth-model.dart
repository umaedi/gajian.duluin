class AuthModel {
  final String accessToken;
  final String typeToken;
  final String message;
  final String isApproved;

  AuthModel({
    required this.accessToken,
    required this.typeToken,
    required this.message,
    required this.isApproved,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['access_token'] ?? '',
      typeToken: json['token_type'] ?? '',
      message: json['message'] ?? '',
      isApproved: json['is_approved'] ?? '',
    );
  }
}
