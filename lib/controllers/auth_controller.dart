import 'package:bizmate/model/user_model.dart';
import 'package:bizmate/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _collectionReference = FirebaseFirestore.instance
      .collection('users');

  User? get currentUser => _firebaseAuth.currentUser;
  Rx<User?> user = Rx<User?>(null);
  final isLoading = false.obs;
  final isRegis = false.obs;
  late TextEditingController emailC;
  late TextEditingController passC;

  @override
  void onInit() {
    emailC = TextEditingController();
    passC = TextEditingController();
    user.bindStream(_firebaseAuth.authStateChanges());

    ever(user, currentPage);
    super.onInit();
  }

  @override
  void onClose() {
    passC.dispose();
    emailC.dispose();
    super.onClose();
  }

  void currentPage(User? user) {
    if (user == null) {
      Get.offAll(() => Login());
    } else {
      Get.offAllNamed('/home');
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar('Success', 'Succeess Login');
    } on FirebaseAuthException catch (e) {
      final pesanError = messageError(e.code);
      Get.snackbar('Gagal', pesanError);
    } catch (error) {
      Get.snackbar('Gagal', 'Terjadi Kesalahan $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(
    String nama,
    String email,
    String password,
    String role,
    String photoUrl,
  ) async {
    isLoading.value = true;
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = result.user;

      if (user != null) {
        await user.sendEmailVerification();

        UserModel newUser = UserModel(
          email: email,
          id: user.uid,
          nama: nama,
          photoUrl: photoUrl,
          role: role,
          createdAt: FieldValue.serverTimestamp(),
        );

        await _collectionReference.doc(user.uid).set(newUser);
        await user.reload();
        Get.snackbar('Success', 'Success Create user with name $nama');
      }
    } on FirebaseAuthException catch (e) {
      final pesanError = messageError(e.code);
      Get.snackbar('Gagal', pesanError);
    } catch (error) {
      Get.snackbar('Gagal', 'Terjadi Kesalahan $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        final DocumentReference userDoc = _collectionReference.doc(user.uid);

        final DocumentSnapshot snapshot = await userDoc.get();

        if (!snapshot.exists) {
          final newValueUser = UserModel(
            id: user.uid,
            email: user.email ?? 'Test@gmail.com',
            nama: user.displayName ?? 'Unknown',
            role: 'Kasir',
            createdAt: FieldValue.serverTimestamp(),
            photoUrl: user.photoURL ?? '',
          );

          await userDoc.set(newValueUser);
        } else {
          await userDoc.update({'createdAt': FieldValue.serverTimestamp()});
          Get.snackbar('Success', 'Welcome back Sirr');
        }
      }

      Get.snackbar('Success', 'Success sign-in with google');
    } catch (error) {
      Get.snackbar('gagal', 'Terjadi Kesalahan Silahkan Coba lagi nanti');
    } finally {
      isLoading.value = false;
    }
  }

  String messageError(String message) {
    switch (message) {
      case 'email-already-in-use':
        return 'Email ini sudah terdaftar. Silakan login saja.';
      case 'invalid-email':
        return 'Format email tidak valid. Cek lagi ya.';
      case 'operation-not-allowed':
        return 'Metode login ini sedang dinonaktifkan.';
      case 'weak-password':
        return 'Password terlalu lemah. Gunakan minimal 6 karakter.';
      case 'user-not-found':
        return 'Email tidak ditemukan. Silakan daftar dulu.';
      case 'wrong-password':
        return 'Password salah. Coba ingat-ingat lagi.';
      case 'invalid-credential':
        return 'Email atau Password salah.';
      default:
        return 'Terjadi kesalahan: $message';
    }
  }
}
