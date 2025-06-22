// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:project/welcomescreen4.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: WelcomeScreen3(),
//     ),
//   );
// }

// class WelcomeScreen3 extends StatelessWidget {
//   const WelcomeScreen3({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: const Color(0xFFFAF9F7),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Skip button
//             Align(
//               alignment: Alignment.topRight,
//               child: TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   "skip",
//                   style: GoogleFonts.manrope(
//                     color: const Color(0xFF7B7B7B),
//                     fontSize: size.width * 0.04,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Title
//             Text(
//               "Real-Time Analytics,\nReal Progress",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.redRose(
//                 fontSize: size.width * 0.065,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 14),

//             // Subtitle
//             Text(
//               "Osmium tracks your performance and turns\nweaknesses into strengths with smart insights.",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.manrope(
//                 fontSize: size.width * 0.038,
//                 color: const Color(0xFF5D5856),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Progress Indicator
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildDot(const Color(0xFFEAE5C6)),
//                 const SizedBox(width: 10),
//                 _buildDot(const Color(0xFFEAE5C6)),
//                 const SizedBox(width: 10),
//                 _buildDot(const Color(0xFFB69347)), // Active dot
//                 const SizedBox(width: 10),
//                 _buildDot(const Color(0xFFE9E9E9)),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // SVG Center Right
//             Expanded(
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: SvgPicture.asset(
//                   'assets/group3.svg',
//                   height: size.height * 0.75,
//                   width: size.width,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),

//             // Next Button with smaller horizontal width
//             Center(
//               child: SizedBox(
//                 width: 300,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       PageRouteBuilder(
//                         transitionDuration: const Duration(milliseconds: 500),
//                         pageBuilder: (_, __, ___) => const WelcomeScreen4(),
//                         transitionsBuilder: (_, animation, __, child) {
//                           const begin = Offset(1.0, 0.0); // Slide from right
//                           const end = Offset.zero;
//                           final tween = Tween(
//                             begin: begin,
//                             end: end,
//                           ).chain(CurveTween(curve: Curves.easeInOut));

//                           return SlideTransition(
//                             position: animation.drive(tween),
//                             child: child,
//                           );
//                         },
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
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

//   Widget _buildDot(Color color) {
//     return Container(
//       height: 6,
//       width: 40,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(4),
//       ),
//     );
//   }
// }
