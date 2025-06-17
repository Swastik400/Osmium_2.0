import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcomescreen2.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: WelcomeScreen()),
  );
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "skip",
                    style: GoogleFonts.manrope(
                      color: const Color.fromARGB(255, 123, 123, 123),
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              // Title
              Text(
                "Learn Anything. Learn Intelligently.",
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
                "From code to chemistry — Osmium finds what works best for you, and helps you master it.",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: size.width * 0.04,
                  color: const Color.fromARGB(255, 93, 88, 86),
                ),
              ),

              const SizedBox(height: 16),

              // Progress Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(active: true),
                  const SizedBox(width: 12),
                  _buildDot(),
                  const SizedBox(width: 12),
                  _buildDot(),
                  const SizedBox(width: 12),
                  _buildDot(),
                ],
              ),

              const SizedBox(height: 20),

              // SVG and Bubbles Section
              Expanded(
                child: Column(
                  children: [
                    // Centered SVG
                    SvgPicture.asset(
                      'assets/images/group.svg',
                      height: size.height * 0.50,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen2(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Dot Indicator
  Widget _buildDot({bool active = false}) {
    return Container(
      height: 6,
      width: active ? 40 : 40,
      decoration: BoxDecoration(
        color: active
            ? const Color.fromARGB(255, 186, 148, 71)
            : const Color.fromARGB(255, 233, 233, 233),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // Tag Bubble Widget
  Widget tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
