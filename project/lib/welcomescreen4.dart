import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen4(),
    ),
  );
}

class WelcomeScreen4 extends StatelessWidget {
  const WelcomeScreen4({super.key});

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
                "Step Into Smarter Learning",
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
                "Your journey to mastery starts now.\nLet Osmium be your guide.",
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
                  _buildDot(customColor: const Color(0xFFEAE5C6)),
                  const SizedBox(width: 10),
                  _buildDot(customColor: const Color(0xFFEAE5C6)),
                  const SizedBox(width: 10),
                  _buildDot(customColor: const Color(0xFFEAE5C6)),
                  const SizedBox(width: 10),
                  _buildDot(customColor: const Color(0xFFB69347)),
                ],
              ),

              const SizedBox(height: 20),

              // SVG
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    'assets/group4.svg',
                    height: size.height * 0.75, // Increased height
                    width: size.width, // Full width
                    fit: BoxFit.cover, // Makes it fill without distortion
                  ),
                ),
              ),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to WelcomeScreen3
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Get Started",
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
  Widget _buildDot({bool active = false, Color? customColor}) {
    return Container(
      height: 6,
      width: 40,
      decoration: BoxDecoration(
        color:
            customColor ??
            (active
                ? const Color.fromARGB(255, 186, 148, 71)
                : const Color.fromARGB(255, 233, 233, 233)),
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
