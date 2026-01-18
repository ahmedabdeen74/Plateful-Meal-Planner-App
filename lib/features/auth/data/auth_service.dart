import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Ensure user document exists in Firestore
  Future<void> _ensureUserDocument(User user) async {
    final userDocRef = _firestore.collection('users').doc(user.uid);
    final userDoc = await userDocRef.get();
    if (!userDoc.exists) {
      await userDocRef.set({
        'username': user.displayName ?? user.email!.split('@')[0],
        'email': user.email,
        'profileImageBase64': null,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // Sign in with email and password
  Future<Map<String, dynamic>> signInWithEmailAndPassword(
      String email,
      String password,
      ) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        final prefs = await SharedPreferences.getInstance();
        final username = userCredential.user!.displayName ?? userCredential.user!.email!.split('@')[0];
        await prefs.setString('username', username);
        await prefs.setString('email', userCredential.user!.email!);
        await _ensureUserDocument(userCredential.user!); // Ensure document exists
      }
      return {'user': userCredential.user, 'error': null};
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        default:
          errorMessage = 'Sign-in failed: ${e.message}';
      }
      return {'user': null, 'error': errorMessage};
    } catch (e) {
      return {'user': null, 'error': 'An unexpected error occurred: $e'};
    }
  }

  // Sign up with email and password
  Future<Map<String, dynamic>> signUpWithEmailAndPassword(
      String email,
      String password, {
        String? username,
      }) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (username != null && userCredential.user != null) {
        await userCredential.user!.updateDisplayName(username);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);
        await prefs.setString('email', userCredential.user!.email!);
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': username,
          'email': userCredential.user!.email,
          'profileImageBase64': null,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      return {'user': userCredential.user, 'error': null};
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Email is already in use';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak';
          break;
        default:
          errorMessage = 'Sign-up failed: ${e.message}';
      }
      return {'user': null, 'error': errorMessage};
    } catch (e) {
      return {'user': null, 'error': 'An unexpected error occurred: $e'};
    }
  }

  // Sign in with Google
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return {'user': null, 'error': 'Google sign-in was cancelled'};
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        final prefs = await SharedPreferences.getInstance();
        final username = userCredential.user!.displayName ?? userCredential.user!.email!.split('@')[0];
        await prefs.setString('username', username);
        await prefs.setString('email', userCredential.user!.email!);
        await _ensureUserDocument(userCredential.user!); // Ensure document exists
      }
      return {'user': userCredential.user, 'error': null};
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage = 'Account exists with different credentials';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid Google credentials';
          break;
        default:
          errorMessage = 'Google sign-in failed: ${e.message}';
      }
      return {'user': null, 'error': errorMessage};
    } catch (e) {
      if (e.toString().contains('ApiException: 10')) {
        return {
          'user': null,
          'error': 'Google sign-in configuration error. Check Firebase and Google Cloud Console settings.'
        };
      }
      return {'user': null, 'error': 'An unexpected error occurred: $e'};
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('profile_image_base64');
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Upload profile image as Base64 to Firestore
  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('Error: No user signed in');
        throw Exception('No user signed in');
      }
      print('Uploading image for user: ${user.uid}');

      // Compress image to ensure size is under 1MB
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        '${imageFile.path}_compressed.jpg',
        quality: 50,
        minWidth: 200,
        minHeight: 200,
      );
      if (compressedFile == null) {
        print('Error: Image compression failed');
        return null;
      }

      // Convert image to Base64
      final bytes = await File(compressedFile.path).readAsBytes();
      final base64Image = base64Encode(bytes);
      print('Base64 image size: ${(base64Image.length / 1024).toStringAsFixed(2)} KB');

      // Check if Base64 size is under 1MB (Firestore document size limit)
      if (base64Image.length > 900000) {
        print('Error: Image size exceeds Firestore document limit (1MB)');
        return null;
      }

      // Store Base64 in Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'profileImageBase64': base64Image,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Update user profile with a placeholder
      await user.updatePhotoURL('firestore://users/${user.uid}');

      // Save Base64 in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_base64', base64Image);

      return base64Image;
    } on FirebaseException catch (e) {
      print('Firestore Error: ${e.code} - ${e.message}');
      if (e.code == 'permission-denied') {
        print('User does not have permission to write to Firestore');
      }
      return null;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}