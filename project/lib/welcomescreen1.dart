import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login1.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: WelcomeScreen()),
  );
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<WelcomeScreenData> _screens = [
    WelcomeScreenData(
      title: "Learn Anything. Learn Intelligently.",
      subtitle:
          "From code to chemistry — Osmium finds what works best for you, and helps you master it.",
      svgAsset: 'assets/group.svg',
      buttonText: "Next",
    ),
    WelcomeScreenData(
      title: "Mock Tests That Actually Matter.",
      subtitle: "Experience AI-powered mocks built to mirror real exam trends.",
      svgAsset: 'assets/group2.svg',
      buttonText: "Next",
    ),
    WelcomeScreenData(
      title: "Real-Time Analytics,\nReal Progress",
      subtitle:
          "Osmium tracks your performance and turns\nweaknesses into strengths with smart insights.",
      svgAsset: 'assets/group3.svg',
      buttonText: "Next",
    ),
    WelcomeScreenData(
      title: "Step Into Smarter Learning",
      subtitle:
          "Your journey to mastery starts now.\nLet Osmium be your guide.",
      svgAsset: 'assets/group4.svg',
      buttonText: "Get Started",
    ),
  ];

  void _nextPage() {
    if (_currentPage < _screens.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => const Login1(),
          transitionsBuilder: (_, animation, __, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: Curves.easeInOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F7),
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login1()),
                  );
                },
                child: Text(
                  "skip",
                  style: GoogleFonts.manrope(
                    color: const Color.fromARGB(255, 123, 123, 123),
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _screens.length,
                itemBuilder: (context, index) {
                  return _buildScreen(_screens[index], size);
                },
              ),
            ),

            // Progress Indicator Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _screens.length,
                (index) => _buildDot(index == _currentPage, index),
              ),
            ),

            const SizedBox(height: 20),

            // Next Button
            SizedBox(
              width: _currentPage == 3 ? double.infinity : 300,
              child: Padding(
                padding: _currentPage == 3
                    ? const EdgeInsets.symmetric(horizontal: 20)
                    : EdgeInsets.zero,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    _screens[_currentPage].buttonText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(WelcomeScreenData screen, Size size) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),

        // Title
        Text(
          screen.title,
          textAlign: TextAlign.center,
          style: GoogleFonts.redRose(
            fontSize: size.width * 0.06,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 16),

        // Subtitle
        Text(
          screen.subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: size.width * 0.04,
            color: const Color.fromARGB(255, 93, 88, 86),
          ),
        ),

        const SizedBox(height: 40),

        // SVG
        Expanded(
          child: _currentPage == 0
              ? SvgPicture.asset(screen.svgAsset, height: size.height * 0.50)
              : Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    screen.svgAsset,
                    height: size.height * 0.75,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildDot(bool isActive, int index) {
    Color dotColor;

    if (isActive) {
      dotColor = const Color.fromARGB(255, 186, 148, 71);
    } else if (index < _currentPage) {
      dotColor = const Color(0xFFEAE5C6);
    } else {
      dotColor = const Color.fromARGB(255, 233, 233, 233);
    }

    return Container(
      height: 6,
      width: 40,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: dotColor,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class WelcomeScreenData {
  final String title;
  final String subtitle;
  final String svgAsset;
  final String buttonText;

  WelcomeScreenData({
    required this.title,
    required this.subtitle,
    required this.svgAsset,
    required this.buttonText,
  });
}
