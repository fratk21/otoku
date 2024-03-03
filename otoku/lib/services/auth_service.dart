import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_avatar/random_avatar.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _mapFirebaseErrorToMessage(e) {
    switch (e.code) {
      case "weak-password":
        return "Şifre çok zayıf. En az 6 karakterden oluşmalıdır.";
      case "email-already-in-use":
        return "Bu e-posta adresi zaten kullanılıyor.";
      case "invalid-email":
        return "Geçersiz e-posta adresi formatı.";
      case "user-not-found":
        return "Kullanıcı bulunamadı. Lütfen kayıt olun.";
      case "wrong-password":
        return "Yanlış şifre. Tekrar deneyin.";
      default:
        return "Bir hata oluştu: ${e.toString()}";
    }
  }

  Future<String?> registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      // Firebase Authentication ile kullanıcı oluştur
      var authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String svgCode = RandomAvatarString('saytoonz');
      // Firestore'a kullanıcı bilgilerini kaydet
      await _firestore.collection('users').doc(authResult.user!.uid).set({
        'username': displayName,
        "uid": authResult.user!.uid,
        "photoUrl": svgCode,
        'email': email,
        'favorites': [],
        'followers': [],
        'following': [],
      });

      return null;
    } catch (e) {
      return _mapFirebaseErrorToMessage(e);
    }
  }

  Future<String?> changePassword(String oldPassword, String newPassword) async {
    User user = FirebaseAuth.instance.currentUser!;
    AuthCredential credential =
        EmailAuthProvider.credential(email: user.email!, password: oldPassword);

    Map<String, String?> codeResponses = {
      // Re-auth responses
      "user-mismatch": null,
      "user-not-found": null,
      "invalid-credential": null,
      "invalid-email": null,
      "wrong-password": null,
      "invalid-verification-code": null,
      "invalid-verification-id": null,
      // Update password error codes
      "weak-password": null,
      "requires-recent-login": null
    };

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      return null;
    } on FirebaseAuthException catch (error) {
      return codeResponses[error.code] ?? "Unknown";
    }
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return _mapFirebaseErrorToMessage(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> isEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;
    await user?.sendEmailVerification();
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
