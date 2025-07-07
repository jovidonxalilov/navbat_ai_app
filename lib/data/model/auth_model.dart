class AuthModel {
  final String idToken;
  final String email;
  final String refreshToken;
  final String expiresIn;
  final String localId;

  AuthModel({
    required this.idToken,
    required this.email,
    required this.refreshToken,
    required this.expiresIn,
    required this.localId,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      idToken: json['idToken'],
      email: json['email'],
      refreshToken: json['refreshToken'],
      expiresIn: json['expiresIn'],
      localId: json['localId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
      'email': email,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'localId': localId,
    };
  }
}
