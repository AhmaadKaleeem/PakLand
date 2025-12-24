import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:house_rent_sale/services/auth_service.dart';
import '../services/theme_services.dart';
import '../utils/routes.dart';

import 'dart:ui';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _useremail = TextEditingController();
  final TextEditingController _userpassword = TextEditingController();
  final TextEditingController _userphone = TextEditingController();
  final TextEditingController _username = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    _useremail.dispose();
    _userpassword.dispose();
    _userphone.dispose();
    _username.dispose();
    super.dispose();
  }

  String? _selectedRole;
  bool _obscurepassword = true;
  // Regex
  final RegExp nameregex = RegExp(r'^[a-zA-Z ]+$');
  final RegExp emailregex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  final RegExp phoneregex = RegExp(r"^(?:\+92|0092|0)3[0-7]{2}[0-9]{7}$");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: PakLandColor.transperant,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: PakLandColor.white),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, PakLandRoutes.home),
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
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    PakLandColor.pureBlack.withOpacity(0.5),
                    PakLandColor.primaryDark.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset('assets/images/pak_land_logo.png', width: 110),
                    const SizedBox(height: 30),
                    const Text(
                      "Welcome to PakLand",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Register to Pakistan’s Trusted Property Marketplace",
                        textAlign: TextAlign.center,

                        style: TextStyle(color: Colors.white70),
                      ),
                    ),

                    const SizedBox(height: 50),
                    loginTextField(
                      "Full Name",
                      Icons.person,
                      _username,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        if (value.trim().length < 3) {
                          return "Name must be at least 3 characters";
                        } else if (!nameregex.hasMatch(value.trim())) {
                          return "Please enter a valid name (No Digits)";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    loginTextField(
                      "Phone Number",
                      Icons.phone,
                      _userphone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your phone";
                        } else if (!phoneregex.hasMatch(value)) {
                          return "Please enter a valid Pakistani phone number (e.g., +923XXXXXXXXX, 00923XXXXXXXXX, or 03XXXXXXXXX).";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Email Field with Regex Validation
                    loginTextField(
                      "Email Address",
                      Icons.email_outlined,
                      _useremail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        } else if (!emailregex.hasMatch(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Password Field with 6-char limit
                    loginTextField(
                      "Password",
                      Icons.lock_outline,
                      _userpassword,
                      isPassword: true,
                      obscureText: _obscurepassword,
                      onToggleVisibility: () {
                        setState(() {
                          _obscurepassword = !_obscurepassword;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      dropdownColor: PakLandColor.primaryDark,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person_2,
                          color: Colors.white70,
                        ),
                        hintText: "Select Role",
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        errorStyle: const TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1,
                          ),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Buyer",
                          child: Text(
                            "Buyer",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Seller",
                          child: Text(
                            "Seller",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select your role";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // 5. Signup Button with Validation Trigger
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PakLandColor.white,
                          foregroundColor: PakLandColor.primaryDark,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        onPressed: _isloading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => _isloading = true);
                                  try {
                                    String? validation_result =
                                        await AuthService().registeruser(
                                          name: _username.text.trim(),
                                          email: _useremail.text.trim(),
                                          password: _userpassword.text,
                                          phone: _userphone.text.trim(),
                                          role: _selectedRole,
                                        );
                                    if (!context.mounted) return;
                                    if (validation_result == "success") {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Login Successful!"),
                                          backgroundColor:
                                              PakLandColor.darkGrey,
                                        ),
                                      );
                                      Navigator.pushReplacementNamed(
                                        context,
                                        PakLandRoutes.home,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            validation_result ?? "Error",
                                          ),
                                          backgroundColor:
                                              PakLandColor.redAccent,
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "An unexpected error occurred.",
                                        ),
                                        backgroundColor: PakLandColor.darkGrey,
                                      ),
                                    );
                                  } finally {}
                                }
                              },
                        child: _isloading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: PakLandColor.primaryDark,
                                  strokeWidth: 3,
                                ),
                              )
                            : Text(
                                "Register",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    const Text(
                      "Or continue with",
                      style: TextStyle(color: Colors.white60),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        socialCircle(
                          FontAwesomeIcons.google,
                          PakLandColor.redAccent,
                          () async {
                            setState(() => _isloading = true);
                            final result = await AuthService()
                                .signInWithGoogle();
                            setState(() => _isloading = false);
                            if (!context.mounted) return;
                            if (result == "success") {
                              Navigator.pushReplacementNamed(
                                context,
                                PakLandRoutes.home,
                              );
                            } else if (result != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result),
                                  backgroundColor: PakLandColor.redAccent,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(width: 30),
                        socialCircle(
                          FontAwesomeIcons.facebook,
                          PakLandColor.accentBlue,
                          () async {
                            setState(() => _isloading = true);
                            final result = await AuthService()
                                .signInWithGoogle();
                            setState(() => _isloading = false);
                            if (!context.mounted) return;
                            if (result == "success") {
                              Navigator.pushReplacementNamed(
                                context,
                                PakLandRoutes.home,
                              );
                            } else if (result != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result),
                                  backgroundColor: PakLandColor.redAccent,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PakLandRoutes.login);
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginTextField(
    String hint,
    IconData icon,
    TextEditingController contoller, {
    bool isPassword = false,
    bool? obscureText,
    VoidCallback? onToggleVisibility,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: contoller,
      obscureText: isPassword ? (obscureText ?? true) : false,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText! ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: onToggleVisibility,
              )
            : null,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        errorStyle: const TextStyle(color: Colors.redAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 1),
        ),
      ),
    );
  }

  Widget socialCircle(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 26),
      ),
    );
  }
}
