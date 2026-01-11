import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:meal_planner/constants.dart';
import 'package:meal_planner/core/utility/assets.dart';
import 'package:meal_planner/core/utility/routers/app_router.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/features/auth/data/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final AuthService _authService = AuthService();

  Future<void> _pickAndUploadImage(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No internet connection')),
      );
      return;
    }
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      final url = await _authService.uploadProfileImage(file);
      if (url != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile image updated successfully!')),
        );
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image')),
        );
      }
    }
  }

  void showProfileDialog(BuildContext context, String displayName, String? email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kAlertColor,
        title: Text('Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: Future.wait([
                SharedPreferences.getInstance().then((prefs) => prefs.getString('profile_image_base64')),
                _authService.getCurrentUser() != null
                    ? FirebaseFirestore.instance.collection('users').doc(_authService.getCurrentUser()?.uid).get()
                    : Future.value(null),
              ]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                String? profileImageBase64;
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  profileImageBase64 = snapshot.data?[0] as String?;
                  final docSnapshot = snapshot.data?[1] as DocumentSnapshot?;
                  if (docSnapshot != null && docSnapshot.exists) {
                    profileImageBase64 ??= docSnapshot.get('profileImageBase64') as String?;
                  }
                }
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: profileImageBase64 != null && profileImageBase64.isNotEmpty
                      ? MemoryImage(base64Decode(profileImageBase64))
                      : AssetImage(AssetsData.user),
                  child: profileImageBase64 == null || profileImageBase64.isEmpty
                      ? Icon(Icons.person)
                      : null,
                );
              },
            ),
            SizedBox(height: 16),
            Text('Name: $displayName'),
            Text('Email: ${email ?? 'Unavailable'}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => _pickAndUploadImage(context),
            child: Text('Change Image'),
          ),
          TextButton(
            onPressed: () async {
              await _authService.signOut();
              Navigator.pop(context);
              GoRouter.of(context).push(AppRouter.kAuthView);
            },
            child: Text('Log Out'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        SharedPreferences.getInstance().then(
              (prefs) => {
            'username': prefs.getString('username'),
            'email': prefs.getString('email'),
            'profile_image_base64': prefs.getString('profile_image_base64'),
          },
        ),
        Future.value(_authService.getCurrentUser()),
        _authService.getCurrentUser() != null
            ? FirebaseFirestore.instance.collection('users').doc(_authService.getCurrentUser()?.uid).get()
            : Future.value(null),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        String displayName = 'Guest';
        String? email = 'Unavailable';
        String? profileImageBase64;

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data![1] != null) {
          final prefsData = snapshot.data![0] as Map<String, dynamic>;
          if (prefsData['username'] != null &&
              (prefsData['username'] as String).isNotEmpty) {
            displayName = prefsData['username'] as String;
          }
          email = prefsData['email'] as String? ??
              (snapshot.data![1] as User).email ??
              'Unavailable';
          profileImageBase64 = prefsData['profile_image_base64'] as String?;
          final docSnapshot = snapshot.data![2] as DocumentSnapshot?;
          if (docSnapshot != null && docSnapshot.exists) {
            profileImageBase64 ??= docSnapshot.get('profileImageBase64') as String?;
          }
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Morning, $displayName",
              style: Styles.textStyleregular36.copyWith(
                color: Color(0xff58544A),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final user = await _authService.getCurrentUser();
                if (user == null) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: kAlertColor,
                      title: Text('Sign In Required'),
                      content: Text(
                        'You need to sign in to access this feature.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            GoRouter.of(context).push(AppRouter.kAuthView);
                          },
                          child: Text('Sign In'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return showProfileDialog(context, displayName, email);
                }
              },
              child: CircleAvatar(
                radius: 25,
                backgroundImage: profileImageBase64 != null && profileImageBase64.isNotEmpty
                    ? MemoryImage(base64Decode(profileImageBase64))
                    : AssetImage(AssetsData.user),
                child: profileImageBase64 == null || profileImageBase64.isEmpty
                    ? Icon(Icons.person)
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}