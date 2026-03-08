class LoginResponseModel {
  final bool status;
  final int code;
  final String message;
  final LoginData data;

  LoginResponseModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json['status'],
    code: json['code'],
    message: json['message'],
    data: LoginData.fromJson(json['data']),
  );
}

class LoginData {
  final String userId;
  final String email;
  final String fullName;
  final String role;
  final String? profilePicture;
  final String accessToken;
  final String refreshToken;

  LoginData({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.role,
    this.profilePicture,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    userId: json['user_id'],
    email: json['email'],
    fullName: json['full_name'],
    role: json['role'],
    profilePicture: json['profile_picture'],
    accessToken: json['access_token'],
    refreshToken: json['refresh_token'],
  );
}