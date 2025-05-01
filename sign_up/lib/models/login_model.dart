class AuthUser {
  final int id;
  final String name;
  final String email;
  final String role;

  AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}

class AuthData {
  final String token;
  final AuthUser user;

  AuthData({required this.token, required this.user});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      token: json['token'],
      user: AuthUser.fromJson(json['user']),
    );
  }
}

class LoginResponse {
  final bool? success;
  final String? message;
  final AuthData? data;

  LoginResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      message: json['message'],
      data: AuthData.fromJson(json['data']),
    );
  }
}
