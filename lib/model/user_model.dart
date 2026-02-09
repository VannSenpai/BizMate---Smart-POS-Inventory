import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String nama;
  String email;
  String? photoUrl;
  String business;
  final dynamic createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.nama,
    this.photoUrl,
    required this.business,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'photoUrl': photoUrl ?? '',
      'business': business,
      'createdAt': createdAt,
    };
  }
}
