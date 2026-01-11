import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/core/utility/assets.dart';
import 'package:meal_planner/core/utility/routers/app_router.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/features/auth/data/auth_service.dart';
import 'package:meal_planner/features/auth/presentation/widgets/sign_in_with_email.dart';
import 'package:meal_planner/features/auth/presentation/widgets/sign_in_with_google_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewBody extends StatelessWidget {
  AuthViewBody({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AssetsData.authImage, fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 36,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.19),
                child: Row(
                  children: [
                    Text(
                      "Join Us ",
                      style: Styles.textStyleregular36.copyWith(
                        color: Colors.white,
                        fontFamily: 'noto_sans',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "Now",
                      style: Styles.textStyleBold36.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Start planning your meals today.",
                style: Styles.textStyleLight14.copyWith(color: Colors.white),
              ),
              SizedBox(height: 32),
              SignInWithGoogleContainer(
                onTap: () async {
                  final result = await _authService.signInWithGoogle();
                  if (result['user'] != null) {
                    GoRouter.of(context).replace(AppRouter.kHomeView);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          result['error'] ?? 'Google sign-in failed. Please try again.',
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 16),
              CustomContainerAuth(
                onTap: () {
                  GoRouter.of(context).replace(AppRouter.kSignupView);
                },
                text: "Continue with Email",
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  await _authService.signOut();
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('username');
                  GoRouter.of(context).replace(AppRouter.kHomeView);
                },
                child: Text(
                  "Continue as Guest",
                  style: Styles.textStyleBold14.copyWith(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    decorationThickness: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}