import 'package:flutter/material.dart';
import 'package:house_rent_sale/screens/authhome_screen.dart';
import 'package:house_rent_sale/screens/forgot_password_screen.dart';
import 'package:house_rent_sale/screens/splash_screen.dart';

import '../screens/login_page.dart';
import '../screens/onboarding_screen.dart';
import '../screens/signup_screen.dart';
import '../services/theme_services.dart';

class PakLandRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String authscreen = '/authscreen';
  static const String forgotpassword = '/forgotpassword';
  static const String splashscreen = '/splashscreen';
  static const String onboarding = '/onboarding';

  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) // setting is route name
  {
    switch (settings.name) {
      case splashscreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case authscreen:
        return MaterialPageRoute(builder: (_) => const AuthWelcomeScreen());
      case forgotpassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: PakLandColor.accentBlue,
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
                style: TextStyle(color: PakLandColor.redAccent),
              ),
            ),
          ),
        );
    }
  }
}
