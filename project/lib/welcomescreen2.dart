// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:project/welcomescreen3.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: WelcomeScreen2(),
//     ),
//   );
// }

// class WelcomeScreen2 extends StatelessWidget {
//   const WelcomeScreen2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: const Color(0xFFFAF9F7),
//       body: SafeArea(
//         // Removed horizontal padding here
//         child: Column(
//           children: [
//             // Skip button
//             Align(
//               alignment: Alignment.topRight,
//               child: TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   "skip",
//                   style: GoogleFonts.manrope(
//                     color: const Color.fromARGB(255, 123, 123, 123),
//                     fontSize: size.width * 0.04,
//                   ),
//                 ),
//               ),
//             ),

//             SizedBox(height: size.height * 0.02),

//             // Title
//             Text(
//               "Mock Tests That Actually Matter.",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.redRose(
//                 fontSize: size.width * 0.06,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Subtitle
//             Text(
//               "Experience AI-powered mocks built to mirror real exam trends.",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.manrope(
//                 fontSize: size.width * 0.04,
//                 color: const Color.fromARGB(255, 93, 88, 86),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Progress Indicator Dots
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildDot(
//                   customColor: const Color.fromARGB(255, 236, 228, 193),
//                 ),
//                 const SizedBox(width: 12),
//                 _buildDot(active: true),
//                 const SizedBox(width: 12),
//                 _buildDot(),
//                 const SizedBox(width: 12),
//                 _buildDot(),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // SVG
//             Expanded(
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: SvgPicture.asset(
//                   'assets/group2.svg',
//                   height: size.height * 0.75,
//                   width: size.width,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             // Next Button
//             Center(
//               child: SizedBox(
//                 width: 300, // or any desired width
//                 child: ElevatedButton(
//                   onPressed: () {
//                    Navigator.push(
//   context,
//   PageRouteBuilder(
//     transitionDuration: const Duration(milliseconds: 500),
//     pageBuilder: (_, __, ___) => const WelcomeScreen3(),
//     transitionsBuilder: (_, animation, __, child) {
//       const begin = Offset(1.0, 0.0); // Slide from right
//       const end = Offset.zero;
//       final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   ),
// );

//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: const Text(
//                     "Next",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDot({bool active = false, Color? customColor}) {
//     return Container(
//       height: 6,
//       width: 40,
//       decoration: BoxDecoration(
//         color:
//             customColor ??
//             (active
//                 ? const Color.fromARGB(255, 186, 148, 71)
//                 : const Color.fromARGB(255, 233, 233, 233)),
//         borderRadius: BorderRadius.circular(4),
//       ),
//     );
//   }

//   Widget tag(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
//     );
//   }
// }
