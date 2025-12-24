import 'dart:async';
import 'package:flutter/material.dart';
import 'package:house_rent_sale/utils/routes.dart';
import '../services/theme_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 sec time
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, PakLandRoutes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: PakLandColor.maingradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Center Logo from your assets
            Image.asset('assets/images/pak_land_logo.png', width: 300),
            const SizedBox(height: 5),
            const Text(
              "Pakistan’s Trusted Property Marketplace",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(color: PakLandColor.white),
          ],
        ),
      ),
    );
  }
}
