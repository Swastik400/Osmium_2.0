import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: Login1()),
  );
}

class Login1 extends StatefulWidget {
  const Login1({super.key});

  @override
  State<Login1> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login1> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String countryCode = '+91';
  String? _flagAsset;
  bool showPasswordScreen = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showPasswordScreen)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      showPasswordScreen = false;
                    });
                  },
                ),
              const SizedBox(height: 10),
              SvgPicture.asset('assets/osmiumlogo.svg', height: 40),
              const SizedBox(height: 20),
              Text(
                'Welcome back',
                style: GoogleFonts.redRose(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                showPasswordScreen ? 'Enter your password' : 'Enter your phone number',
                style: GoogleFonts.manrope(fontSize: 16, color: const Color.fromARGB(255, 82, 82, 82)),
              ),
              const SizedBox(height: 24),

              // === PHONE OR PASSWORD SECTION ===
              showPasswordScreen ? _buildPasswordInput() : _buildPhoneInput(),

              const SizedBox(height: 16),
              Row(
                children: [
                  Text("Don't have an account? ", style: GoogleFonts.manrope()),
                  Text(
                    "Sign up",
                    style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),

              // === GOOGLE SIGN IN ===
              OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: const BorderSide(color: Colors.grey),
                ),
                icon: SvgPicture.asset('assets/google.svg', height: 20),
                label: const Text("Sign in with Google"),
              ),
              const Spacer(),

              // === FORWARD BUTTON ===
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    if (!showPasswordScreen) {
                      if (_phoneController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter your phone number")),
                        );
                        return;
                      }
                      setState(() {
                        showPasswordScreen = true;
                      });
                    } else {
                      if (_passwordController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter your password")),
                        );
                        return;
                      }
                      // Proceed to login
                      print("Login with ${_phoneController.text}, password: ${_passwordController.text}");
                    }
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneInput() {
    return Row(
      children: [
        Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: CountryCodePicker(
            onChanged: (code) {
              setState(() {
                countryCode = code.dialCode!;
                _flagAsset = 'packages/country_code_picker/${code.flagUri}';
              });
            },
            initialSelection: 'IN',
            favorite: const ['+91', 'IN'],
            showFlag: true,
            showFlagDialog: true,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: '00000 00000',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 138, 138, 138)),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 186, 148, 71)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            children: [
              if (_flagAsset != null)
                Image.asset(
                  _flagAsset!,
                  width: 32,
                  height: 24,
                  package: 'country_code_picker',
                ),
              const SizedBox(width: 8),
              Text("$countryCode ${_phoneController.text}", style: GoogleFonts.manrope(fontSize: 16)),
              const Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    showPasswordScreen = false;
                  });
                },
                child: const Text("Edit", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: obscurePassword,
          decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromARGB(255, 138, 138, 138)),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromARGB(255, 186, 148, 71)),
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
