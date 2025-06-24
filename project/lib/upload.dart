import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class ExamUploadScreen extends StatefulWidget {
  const ExamUploadScreen({Key? key}) : super(key: key);

  @override
  State<ExamUploadScreen> createState() => _ExamUploadScreenState();
}

class _ExamUploadScreenState extends State<ExamUploadScreen> {
  List<File> uploadedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                  const Icon(Icons.notifications_outlined, size: 24),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Upload Container
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Upload Icon
                          SvgPicture.asset(
                            'assets/file.svg',
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(height: 16),
                          
                          // Title
                          const Text(
                            'Upload Exam Papers',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // File List or Empty State
                          uploadedFiles.isEmpty 
                              ? const Text(
                                  'Upload at least 5 previous year question papers (PDF, DOC, or image files) to generate an AI-powered mock test that matches your exam\'s pattern and difficulty level.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                )
                              : uploadedFiles.length <= 6
                                  ? Column(
                                      children: uploadedFiles.asMap().entries.map((entry) {
                                        return _buildFileItem(uploadedFiles[entry.key], entry.key);
                                      }).toList(),
                                    )
                                  : Container(
                                      height: 200,
                                      child: ListView.builder(
                                        itemCount: uploadedFiles.length,
                                        itemBuilder: (context, index) {
                                          return _buildFileItem(uploadedFiles[index], index);
                                        },
                                      ),
                                    ),
                          
                          const SizedBox(height: 16),
                          
                          // Upload Button
                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: ElevatedButton(
                              onPressed: _pickFiles,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Upload',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            
            // Generate Button at Bottom
            Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: uploadedFiles.length >= 5
                      ? const LinearGradient(
                          colors: [Color(0xFF9C6ADE), Color(0xFF7C3AED)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                  color: uploadedFiles.length >= 5 ? null : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ElevatedButton(
                  onPressed: uploadedFiles.length >= 5 ? () => _showGenerateDialog(context) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 18,
                        color: uploadedFiles.length >= 5 ? Colors.white : Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Generate',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: uploadedFiles.length >= 5 ? Colors.white : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItemSvg('assets/vector1.svg', false),
              _buildNavItemSvg('assets/vector2.svg', false),
              _buildNavItemSvg('assets/vector3.svg', false),
              _buildNavItemSvg('assets/vector4.svg', true),
              _buildNavItemSvg('assets/vector5.svg', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileItem(File file, int index) {
    String fileName = file.path.split('/').last;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.description,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                uploadedFiles.removeAt(index);
              });
            },
            child: const Icon(
              Icons.close,
              color: Colors.grey,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItemSvg(String svgPath, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        SvgPicture.asset(
          svgPath,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            isActive ? Colors.black87 : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 8),
        if (isActive)
          Container(
            width: 20,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        const SizedBox(height: 12),
      ],
    );
  }

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          for (var file in result.files) {
            if (file.path != null) {
              uploadedFiles.add(File(file.path!));
            }
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _showGenerateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Generate Mock Test',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          content: Text(
            uploadedFiles.length >= 5 
                ? 'Ready to generate your AI-powered mock test!'
                : 'Please upload at least 5 exam papers first.',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Upload App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ExamUploadScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}