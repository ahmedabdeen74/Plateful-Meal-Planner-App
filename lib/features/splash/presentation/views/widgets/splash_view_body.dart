import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/constants.dart';
import 'package:meal_planner/core/utility/app_router.dart';

import 'package:meal_planner/core/utility/assets.dart';
import 'package:meal_planner/core/utility/routers/app_router.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/features/auth/data/auth_service.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        // Trigger navigation after checking user status
        _checkUserStatus();
      }
    });
  }

  void _checkUserStatus() async {
    final user = await AuthService().getCurrentUser();
    if (mounted) {
      if (user != null) {
       // AppRouter.toReplacement(AppRouter.kHomeView);
        GoRouter.of(context).replace(AppRouter.kHomeView);
      } else {
      //  AppRouter.toReplacement(AppRouter.kAuthView);
      GoRouter.of(context).replace(AppRouter.kAuthView);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AssetsData.splash, fit: BoxFit.cover),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AssetsData.burger,
                height: height * 0.6,
                width: width * 0.6,
              ),
            ),
            SizedBox(height: 8),
            Text("Plateful", style: Styles.textStyle61),
            FittedBox(
              child: Text(
                "M E A L    P L A N N E R",
                style: Styles.textStyleMedium14.copyWith(
                  color: kSecondaryColor,
                ),
              ),
            ),
            SizedBox(height: 32),
            FittedBox(
              child: Text(
                "Your meal planning,",
                style: Styles.textStyleRegular18.copyWith(
                  color: Color(0xE5FFFFFF),
                ),
              ),
            ),
            FittedBox(
              child: Text(
                "served on a full plate.",
                style: Styles.textStyleRegular18.copyWith(
                  color: Color(0xE5FFFFFF),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
