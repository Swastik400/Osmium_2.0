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
  int? selectedOption = 1; // Second option selected by default to match image
  String? lastButtonPressed = 'Next'; // Next button is active in image
  Duration remainingTime = Duration(hours: 2, minutes: 59, seconds: 2);
  late Timer countdownTimer;
  bool showSidebar = false;

  final List<String> options = ['9', '1/27', '1/9', '27'];

  final Map<int, QuestionStatus> questionStatuses = {
    1: QuestionStatus.notAnswered,
    2: QuestionStatus.answered,
    3: QuestionStatus.answered,
    4: QuestionStatus.answered,
    5: QuestionStatus.notVisited,
    11: QuestionStatus.notAnswered,
    12: QuestionStatus.notVisited,
    26: QuestionStatus.notAnswered,
    27: QuestionStatus.notVisited,
    29: QuestionStatus.answered,
    30: QuestionStatus.notVisited,
  };

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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
                            child: TimerBar(
                              timeString: formatTime(remainingTime),
                              onSubmit: () => setState(() => lastButtonPressed = 'Submit'),
                              onMenuTap: () => setState(() => showSidebar = true),
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
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                            child: BottomButtons(
                              lastPressed: lastButtonPressed,
                              onPressed: (label) => setState(() => lastButtonPressed = label),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 0,
            bottom: 0,
            right: showSidebar ? 0 : -MediaQuery.of(context).size.width,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                color: Color(0xFFFDFBF6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black26,
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEBB4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: const Text("Question grid"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              child: const Text("Question paper"),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => setState(() => showSidebar = false),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _legendItem("Answered", Colors.green),
                                _legendItem("Not Answered", Colors.red),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _legendItem("Not Visited", Colors.grey),
                                _legendItem("Review Later", Colors.purple),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            SubjectSection(
                              title: "Physics",
                              color: const Color(0xFFFFB3BA),
                              questionNumbers: List.generate(25, (i) => i + 1),
                              questionStatuses: questionStatuses,
                            ),
                            const SizedBox(height: 16),
                            SubjectSection(
                              title: "Chemistry",
                              color: const Color(0xFFB5E7A0),
                              questionNumbers: List.generate(25, (i) => i + 26),
                              questionStatuses: questionStatuses,
                            ),
                            const SizedBox(height: 16),
                            SubjectSection(
                              title: "Mathematics",
                              color: const Color(0xFFA8D8EA),
                              questionNumbers: List.generate(25, (i) => i + 51),
                              questionStatuses: questionStatuses,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
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

  Widget _legendDot(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _legendItem(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class TimerBar extends StatelessWidget {
  final String timeString;
  final VoidCallback onSubmit;
  final VoidCallback onMenuTap;

  const TimerBar({super.key, required this.timeString, required this.onSubmit, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              timeString,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "JEE MAINS Test",
              style: GoogleFonts.manrope(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextButton(
            onPressed: onSubmit,
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
               minimumSize: const Size(60, 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "Submit",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onMenuTap,
          child: Icon(
            Icons.menu,
            size: 24,
            color: Colors.grey[700],
          ),
        ),
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
            color: isActive ? Colors.black : Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        if (isActive)
          Container(
            height: 3,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
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
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ScoreBadge(
              text: '+ ${positiveMark.toStringAsFixed(1)}',
              bgColor: const Color(0xFFE8F5E8),
              textColor: const Color(0xFF2E7D32),
              borderColor: const Color(0xFFA5D6A7),
            ),
            const SizedBox(width: 8),
            ScoreBadge(
              text: '- ${negativeMark.toStringAsFixed(1)}',
              bgColor: const Color(0xFFFFF2F2),
              textColor: const Color(0xFFD32F2F),
              borderColor: const Color(0xFFFFCDD2),
            ),
            const Spacer(),
            Icon(
              Icons.bookmark_border_outlined,
              color: Colors.grey[400],
              size: 24,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          question,
          style: textStyle.copyWith(
            height: 1.5,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 24),
        ...options.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: OptionItem(
              index: entry.key,
              text: entry.value,
              isSelected: selectedOption == entry.key,
              onTap: onOptionTap,
            ),
          );
        }),
      ],
    );
  }
}

class ScoreBadge extends StatelessWidget {
  final String text;
  final Color bgColor, textColor;
  final Color borderColor;

  const ScoreBadge({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF8E1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFFFB74D) : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        width: double.infinity,
        child: Text(
          '${index + 1}.    $text',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
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
      children: [
        _buildBtn("Previous"),
        _buildBtn("Next"),
      ],
    );
  }

  Widget _buildBtn(String label) {
    final bool isActive = lastPressed == label;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isActive ? Colors.transparent : Colors.grey[400]!,
        ),
      ),
      child: TextButton(
        onPressed: () => onPressed(label),
        style: TextButton.styleFrom(
          backgroundColor: isActive ? Colors.black : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
enum QuestionStatus {
  answered,
  notAnswered,
  notVisited,
  reviewLater,
}

class SubjectSection extends StatelessWidget {
  final String title;
  final Color color;
  final List<int> questionNumbers;
  final Map<int, QuestionStatus> questionStatuses;

  const SubjectSection({
    super.key,
    required this.title,
    required this.color,
    required this.questionNumbers,
    required this.questionStatuses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: questionNumbers.length,
              itemBuilder: (context, index) {
                final questionNumber = questionNumbers[index];
                final status = questionStatuses[questionNumber] ?? QuestionStatus.notVisited;
                
                return QuestionButton(
                  number: questionNumber,
                  status: status,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionButton extends StatelessWidget {
  final int number;
  final QuestionStatus status;

  const QuestionButton({
    super.key,
    required this.number,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color backgroundColor = Colors.white;

    switch (status) {
      case QuestionStatus.answered:
        borderColor = Colors.green;
        break;
      case QuestionStatus.notAnswered:
        borderColor = Colors.red;
        break;
      case QuestionStatus.reviewLater:
        borderColor = Colors.purple;
        break;
      case QuestionStatus.notVisited:
      default:
        borderColor = Colors.grey;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Center(
        child: Text(
          '$number',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}