import 'package:event_app/core/prefs_manager/prefs_manager.dart';
import 'package:event_app/core/resource/images_manager/image_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      'image': ImageAssets.onboarding1,
      'title': 'Personalize Your Experience',
      'desc':
      'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'
    },
    {
      'image': ImageAssets.onboarding2,
      'title': 'Find Events That Inspire You',
      'desc':
      'Discover events crafted to fit your unique interests. From networking to workshops, find exactly what suits you.'
    },
    {
      'image': ImageAssets.onboarding3,
      'title': 'Effortless Event Planning',
      'desc':
      'Take the hassle out of organizing events. From start to finish, we help you create unforgettable experiences.'
    },
    {
      'image': ImageAssets.onboarding4,
      'title': 'Connect & Share Moments',
      'desc':
      'Share your experience with others and make every event memorable. Connect, inspire, and enjoy together.'
    },
  ];

  Future<void> _nextPage() async {
    if (_currentIndex == pages.length - 1) {
      await PrefsManager.setBool('seenOnboarding', true);
      final user = FirebaseAuth.instance.currentUser;
      if (!mounted) return;
      if (user == null) {
        Navigator.pushReplacementNamed(context, RouteManager.login);
      } else {
        Navigator.pushReplacementNamed(context, RouteManager.mainLayout);
      }
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Logo
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Image.asset(
                ImageAssets.evently_onborading,
                height: 50,
              ),
            ),
            const SizedBox(height: 10),

            // 🔹 PageView
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(page['image']!, height: 270),
                        const SizedBox(height: 40),
                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3A6FEF),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['desc']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🔹 Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentIndex == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? const Color(0xFF3A6FEF)
                        : const Color(0xFF3A6FEF).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Next / Start Button
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A6FEF),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: _nextPage,
                child: Text(
                  _currentIndex == pages.length - 1 ? "Let's Start" : "Next",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
