import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String nama;
  String email;
  String? role;
  String photoUrl;
  final FieldValue? createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.nama,
    this.role,
    required this.photoUrl,
    this.createdAt,
  });
}
