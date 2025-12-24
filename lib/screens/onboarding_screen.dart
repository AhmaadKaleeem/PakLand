import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../services/theme_services.dart';
import 'package:house_rent_sale/utils/routes.dart';

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

final List<OnboardingItem> onboardingPages = [
  OnboardingItem(
    title: "Find Real Verified Properties",
    description:
        "A marketplace built on trust. No scams, no clutter—just keys waiting for you.",
    image: 'assets/images/onboarding1.png',
  ),
  OnboardingItem(
    title: "Safe & Secure Dealing",
    description:
        "Don't take risks. Choose agents with a high Trust Score to ensure safety.",
    image: 'assets/images/onboarding2.png',
  ),
  OnboardingItem(
    title: "Effortless Bookings",
    description:
        "Whether buying or renting, schedule a property visit in seconds with just one tap.",
    image: 'assets/images/onboarding3.png',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: PakLandColor.maingradient),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (index) {
                  setState(
                    () => isLastPage = index == onboardingPages.length - 1,
                  );
                },
                itemBuilder: (context, index) {
                  return buildOnboardingPage(onboardingPages[index]);
                },
              ),
            ),

            //  The Indicator Dots
            SmoothPageIndicator(
              controller: _pageController,
              count: onboardingPages.length,
              effect: ScrollingDotsEffect(
                activeDotColor: PakLandColor.white,
                dotColor: PakLandColor.primaryLight,
                dotHeight: 10,
              ),
            ),

            const SizedBox(height: 50),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () =>
                        _pageController.jumpToPage(onboardingPages.length - 1),
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: PakLandColor.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PakLandColor.white,
                      foregroundColor: PakLandColor.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      if (isLastPage) {
                        Navigator.pushReplacementNamed(
                          context,
                          PakLandRoutes.authscreen,
                        );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(isLastPage ? "Get Started" : "Next"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build the individual pages
  Widget buildOnboardingPage(OnboardingItem item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(item.image, width: 390, height: 320),
        const SizedBox(height: 40),
        Text(
          item.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            item.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
