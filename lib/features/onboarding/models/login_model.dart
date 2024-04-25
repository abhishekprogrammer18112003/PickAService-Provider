class LoginModel {
  final int userId;
  final String email;
  final String type;
  final String token;

  LoginModel({
    required this.userId,
    required this.email,
    required this.type,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userId: json['userId'],
      email: json['email'],
      type: json['type'],
      token: json['token'],
    );
  }
}