import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dart:ui';
import '../services/theme_services.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final RegExp emailregex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: PakLandColor.transperant,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: PakLandColor.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/auth_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(color: PakLandColor.pureBlack.withOpacity(0.3)),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: PakLandColor.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: PakLandColor.white.withOpacity(0.2),
                      ),
                    ),
                    child: const Icon(
                      Icons.lock_open_rounded,
                      color: PakLandColor.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Glass Card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: PakLandColor.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: PakLandColor.white.withOpacity(0.2),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Text(
                                "Forgot Password",
                                style: TextStyle(
                                  color: PakLandColor.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Enter your email and we'll send you a link to reset your password",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: PakLandColor.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 35),

                              TextFormField(
                                controller: _emailController,
                                style: const TextStyle(
                                  color: PakLandColor.white,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: PakLandColor.white70,
                                  ),
                                  hintText: "Email Address",
                                  hintStyle: const TextStyle(
                                    color: PakLandColor.white38,
                                  ),
                                  filled: true,
                                  fillColor: PakLandColor.white.withOpacity(
                                    0.05,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: PakLandColor.white54,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your email";
                                  } else if (!emailregex.hasMatch(value)) {
                                    return "Please enter a valid email address";
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 25),

                              // Action Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: PakLandColor.white,
                                    foregroundColor: PakLandColor.primaryDark,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: _isLoading
                                      ? null
                                      : _handlePasswordReset,
                                  child: _isLoading
                                      ? const CircularProgressIndicator(
                                          color: PakLandColor.primaryDark,
                                        )
                                      : const Text(
                                          "SEND LINK",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePasswordReset() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        String? result = await AuthService().resetPassword(
          _emailController.text.trim(),
        );
        if (!mounted) return;

        if (result == "success") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Link sent! Check your inbox."),
              backgroundColor: PakLandColor.darkGrey,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result ?? "Error"),
              backgroundColor: PakLandColor.redAccent,
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
      _emailController.dispose();
    }
  }
}
