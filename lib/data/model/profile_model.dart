import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String id;
  final String firstName, lastName;
  final String status;
  final int navbat;
  final DateTime time;
  final String phone;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.navbat,
    required this.status,
    required this.phone,
    required this.time
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'status': status,
      'navbat': navbat,
      'phone': phone,
      'time': time.toIso8601String()
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json, String id) {
    return ProfileModel(
      id: id,
      lastName: json['lastName'] ?? '',
      firstName: json['firstName'] ?? 'nul ekan malumot',
      status: json['status'] ?? '',
      navbat: json['navbat'] ?? 0,
      phone: json['phone'] ?? '',
      time: json['time'] != null ? DateTime.parse(json['time']) : DateTime.now(),
    );
  }
}

class UserModel {
  final String firstName, lastName;
  final String status;
  final int navbat;
  final DateTime time;
  final String phone;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.navbat,
    required this.status,
    required this.phone,
    required this.time
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'status': status,
      'navbat': navbat,
      'phone': phone,
      'time': time.toIso8601String()
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json, ) {
    return UserModel(
      lastName: json['lastName'] ?? '',
      firstName: json['firstName'] ?? 'nul ekan malumot',
      status: json['status'] ?? '',
      navbat: json['navbat'] ?? 0,
      phone: json['phone'] ?? '',
      time: json['time'] != null ? DateTime.parse(json['time']) : DateTime.now(),
    );
  }
}

