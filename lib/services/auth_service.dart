import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _signINGoogle = GoogleSignIn.instance;
  bool _isInitialized = false;

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await _signINGoogle.initialize();
      _isInitialized = true;
    }
  }

  Future<String?> registeruser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String? role,
  }) async {
    try {
      UserCredential userResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userResult.user;
      if (user != null) {
        await _createUserInFirestore(user, name, phone, email, role);
        return "success";
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "An unexpected error occurred.";
    }
    return null;
  }

  Future<String?> loginUser(String useremail, String userpassword) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: useremail,
        password: userpassword,
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        return "Invalid credentials. Please try again.";
      }

      if (e.code == 'network-request-failed') {
        return "Server is down. Check your internet.";
      }

      return e.message ?? "Firebase Error: ${e.code}";
    } catch (e) {
      return "Connection error: ${e.toString()}";
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      await _ensureInitialized();

      final GoogleSignInAccount? googleUser = await _signINGoogle
          .authenticate();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final authClient = googleUser.authorizationClient;
      final authorization = await authClient.authorizeScopes([
        'email',
        'profile',
      ]);

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authorization.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userResult = await _auth.signInWithCredential(credential);
      await _syncSocialUser(userResult.user);
      return "success";
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      return "Google Sign-In error: ${e.code}";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return "This email is already linked to another login method.";
      }
      return e.message ?? "Authentication failed.";
    } catch (e) {
      return "An unexpected error occurred.";
    }
  }

  Future<void> _createUserInFirestore(
    User user,
    String name,
    String phone,
    String email,
    String? role,
  ) async {
    await _db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role ?? 'Buyer',
      'trustScore': 50,
      'photourl': user.photoURL ?? '',
      'stats': {'totalads': 0, 'ontime_verified': 0, 'flaggedads': 0},
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _syncSocialUser(User? user) async {
    if (user == null) return;
    final doc = await _db.collection('users').doc(user.uid).get();
    if (!doc.exists) {
      await _createUserInFirestore(
        user,
        user.displayName ?? "User",
        "",
        user.email ?? "",
        "Buyer",
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _signINGoogle.disconnect();
  }

  Future<String?> resetPassword(String useremail) async {
    try {
      await _auth.sendPasswordResetEmail(email: useremail);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred";
    } catch (e) {
      return e.toString();
    }
  }
}
