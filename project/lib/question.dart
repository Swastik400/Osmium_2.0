import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const MaterialApp(
      home: JeeMockTestPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class JeeMockTestPage extends StatefulWidget {
  const JeeMockTestPage({super.key});
  @override
  State<JeeMockTestPage> createState() => _JeeMockTestPageState();
}

class _JeeMockTestPageState extends State<JeeMockTestPage> {
  int? selectedOption;
  String? lastButtonPressed;
  Duration remainingTime = Duration(hours: 2, minutes: 59, seconds: 2);
  late Timer countdownTimer;

  final List<String> options = ['9', '1/27', '1/9', '27'];

  @override
  void initState() {
    super.initState();
    countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => updateTime(),
    );
  }

  void updateTime() {
    if (mounted) {
      setState(() {
        if (remainingTime.inSeconds > 0) {
          remainingTime -= const Duration(seconds: 1);
        } else {
          countdownTimer.cancel();
        }
      });
    }
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inHours)}:'
        '${twoDigits(duration.inMinutes.remainder(60))}:'
        '${twoDigits(duration.inSeconds.remainder(60))}';
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8F4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TimerBar(
                timeString: formatTime(remainingTime),
                onSubmit: () => setState(() => lastButtonPressed = 'Submit'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SubjectTabs(),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: QuestionCard(
                  number: 1,
                  positiveMark: 4.0,
                  negativeMark: 1.0,
                  selectedOption: selectedOption,
                  question:
                      "A solid sphere of radius R acquires a terminal velocity v1 when falling (due to gravity) through a viscous fluid having a coefficient of viscosity η. The sphere is broken into 27 identical spheres. If each of these acquires a terminal velocity v2, when falling through the same fluid, the ratio (v1/v2) equals",
                  options: options,
                  textStyle: GoogleFonts.manrope(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  onOptionTap: (idx) => setState(() => selectedOption = idx),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: BottomButtons(
                lastPressed: lastButtonPressed,
                onPressed: (label) => setState(() => lastButtonPressed = label),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerBar extends StatelessWidget {
  final String timeString;
  final VoidCallback onSubmit;

  const TimerBar({super.key, required this.timeString, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              timeString,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("JEE MAINS Test", style: GoogleFonts.manrope(fontSize: 14)),
          ],
        ),
        const Spacer(),
        OutlinedButton(
          onPressed: onSubmit,
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFFFFFBF3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            side: const BorderSide(color: Color(0xFFB1B1B1)),
          ),
          child: const Text("Submit", style: TextStyle(color: Colors.black)),
        ),
        const SizedBox(width: 6),
        const Icon(Icons.menu, size: 26, color: Color(0xFF494949)),
      ],
    );
  }
}

class SubjectTabs extends StatelessWidget {
  const SubjectTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SubjectTab(title: "Physics", isActive: true),
        SizedBox(width: 40),
        SubjectTab(title: "Chemistry", isActive: false),
        SizedBox(width: 40),
        SubjectTab(title: "Mathematics", isActive: false),
      ],
    );
  }
}

class SubjectTab extends StatelessWidget {
  final String title;
  final bool isActive;
  const SubjectTab({super.key, required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: isActive ? const Color(0xFF4B4023) : Colors.black54,
          ),
        ),
        if (isActive)
          Container(height: 2, width: 60, color: const Color(0xFF4B4023)),
      ],
    );
  }
}

class QuestionCard extends StatelessWidget {
  final int number;
  final double positiveMark, negativeMark;
  final String question;
  final List<String> options;
  final int? selectedOption;
  final void Function(int) onOptionTap;
  final TextStyle textStyle;

  const QuestionCard({
    super.key,
    required this.number,
    required this.positiveMark,
    required this.negativeMark,
    required this.question,
    required this.options,
    required this.selectedOption,
    required this.onOptionTap,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
Row(
  children: [
    Container(
      padding: const EdgeInsets.all(2), 
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color.fromARGB(255, 213, 213, 213), 
          width: 1,
        ),
      ),
      child: CircleAvatar(
        radius: 14,
        backgroundColor: const Color.fromARGB(255, 249, 248, 244),
        child: Text(
          '$number',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    ),
    const SizedBox(width: 10),
    ScoreBadge(
      text: '+${positiveMark.toStringAsFixed(1)}',
      bgColor: const Color(0xFFF2FBEA),
      textColor: const Color(0xFF195139),
      bordercolor: const Color(0xFFA2E4B0),
      borderradius: BorderRadius.circular(10),
    ),
    const SizedBox(width: 6),
    ScoreBadge(
      text: '-${negativeMark.toStringAsFixed(1)}',
      bgColor: const Color(0xFFFFF4F4),
      textColor: const Color(0xFF723B51),
      bordercolor: const Color(0xFFEF9B9B),
      borderradius: BorderRadius.circular(10),
    ),
    const Spacer(),
    const Icon(Icons.bookmark_border, color: Colors.grey),
  ],
),
        const SizedBox(height: 16),
        Text(
          question,
          style: textStyle,
          // maxLines: 4,
          // overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 30),
        ...options.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: OptionItem(
              index: entry.key,
              text: entry.value,
              isSelected: selectedOption == entry.key,
              onTap: onOptionTap,
            ),
          );
        }).toList(),
      ],
    );
  }
}

class ScoreBadge extends StatelessWidget {
  final String text;
  final Color bgColor, textColor;
  final Color? bordercolor;
  final BorderRadius? borderradius;

  const ScoreBadge({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    this.bordercolor,
    this.borderradius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderradius ?? BorderRadius.circular(5),
        border: Border.all(color: bordercolor ?? Colors.transparent),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 12)),
    );
  }
}

class OptionItem extends StatelessWidget {
  final int index;
  final String text;
  final bool isSelected;
  final void Function(int) onTap;

  const OptionItem({
    super.key,
    required this.index,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFEFEF) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 224, 166, 48)
                : Colors.grey.shade300,
            width: 2,
          ),
        ),
        width: double.infinity,
        child: Text(
          '${index + 1}. $text',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {
  final String? lastPressed;
  final void Function(String) onPressed;

  const BottomButtons({
    super.key,
    required this.lastPressed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildBtn("Previous"), _buildBtn("Next")],
    );
  }

  Widget _buildBtn(String label) {
    final bool isPressed = label == lastPressed;
    return OutlinedButton(
      onPressed: () => onPressed(label),
      style: OutlinedButton.styleFrom(
        backgroundColor: isPressed ? Colors.black : Colors.transparent,
        side: const BorderSide(color: Color(0xFF585858)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        label,
        style: TextStyle(color: isPressed ? Colors.white : Colors.black),
      ),
    );
  }
}
