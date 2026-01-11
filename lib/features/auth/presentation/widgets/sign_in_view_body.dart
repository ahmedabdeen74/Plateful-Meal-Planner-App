import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/core/utility/assets.dart';
import 'package:meal_planner/core/utility/routers/app_router.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/features/auth/data/auth_service.dart';
import 'package:meal_planner/features/auth/presentation/widgets/sign_in_with_email.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  _SignInViewBodyState createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);
  }

  void _validateEmail() {
    setState(() {
      final value = emailController.text.trim();
      _isEmailValid =
          value.isNotEmpty &&
          value.contains('@') &&
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
    });
  }

  void _validatePassword() {
    setState(() {
      final value = passwordController.text.trim();
      _isPasswordValid = value.isNotEmpty && value.length >= 6;
    });
  }

  @override
  void dispose() {
    emailController.removeListener(_validateEmail);
    passwordController.removeListener(_validatePassword);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
            top: 8,
            bottom: 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.19),
                  child: Row(
                    children: [
                      Text(
                        "Sign in ",
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
                SizedBox(height: 12),
                SizedBox(
                  width: size.width * 0.8,
                  child: TextFormField(
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.contains('@') ||
                          !RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      hintText: 'Email Address',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Image.asset(AssetsData.email, width: 30),
                      suffixIcon: _isEmailValid
                          ? Icon(Icons.check, color: Colors.green)
                          : null,
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      errorStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: size.width * 0.8,
                  child: TextFormField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.white),
                    obscureText: !_isPasswordVisible,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Image.asset(
                        AssetsData.password,
                        width: 30,
                        height: 30,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      errorStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                CustomContainerAuth(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      final result = await _authService
                          .signInWithEmailAndPassword(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                      setState(() {
                        _isLoading = false;
                      });
                      if (result['user'] != null) {
                        GoRouter.of(
                          context,
                        ).pushReplacement(AppRouter.kHomeView);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              result['error'] ??
                                  'Sign-in failed. Please check your credentials.',
                            ),
                          ),
                        );
                      }
                    }
                  },
                  text: "SIGN IN",
                  isLoading: _isLoading,
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Styles.textStyleLight14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kSignupView);
                      },
                      child: Text(
                        "Join Us",
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
