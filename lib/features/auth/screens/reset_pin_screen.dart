import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ResetPinScreen extends StatefulWidget {
  const ResetPinScreen({Key? key}) : super(key: key);

  @override
  State<ResetPinScreen> createState() => _ResetPinScreenState();
}

class _ResetPinScreenState extends State<ResetPinScreen> {
  bool _isOtpVerified = false;
  
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  
  String _errorMessage = '';

  // Dummy OTP Verification
  void _verifyOtp() {
    if (_otpController.text == '123456') { // Test ke liye OTP
      setState(() {
        _isOtpVerified = true;
        _errorMessage = '';
      });
    } else {
      setState(() {
        _errorMessage = 'Galat OTP! Testing ke liye 123456 daalein.';
      });
    }
  }

  // Dummy PIN Reset
  void _resetPin() {
    if (_newPinController.text.length != 4) {
      setState(() => _errorMessage = 'PIN 4 digits ka hona chahiye.');
      return;
    }
    if (_newPinController.text != _confirmPinController.text) {
      setState(() => _errorMessage = 'PIN match nahi kar raha hai.');
      return;
    }
    
    // Agar sab sahi hai toh success message dikhao aur Login screen pe wapas bhej do
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PIN successfully reset! Please login with new PIN.'),
        backgroundColor: Colors.green,
      ),
    );
    context.go('/pin-login');
  }

  @override
  void dispose() {
    _otpController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.kDarkText),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(LucideIcons.shieldCheck, size: 64, color: AppColors.kPrimary),
                const SizedBox(height: 24),
                Text(
                  _isOtpVerified ? "Set New PIN" : "Verify OTP",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.kDarkText,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isOtpVerified 
                      ? "Create a new 4-digit PIN for your account." 
                      : "We have sent a 6-digit OTP to your registered mobile number.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.kLightText),
                ),
                const SizedBox(height: 32),

                // Error Message
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),

                // STEP 1: OTP Input
                if (!_isOtpVerified) ...[
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, letterSpacing: 8, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: "000000",
                      counterText: "",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.kPrimary, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Verify OTP", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ],

                // STEP 2: New PIN Input
                if (_isOtpVerified) ...[
                  _buildPinField("Enter New 4-Digit PIN", _newPinController),
                  const SizedBox(height: 16),
                  _buildPinField("Confirm New 4-Digit PIN", _confirmPinController),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _resetPin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Set New PIN", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      obscureText: true,
      obscuringCharacter: '●',
      maxLength: 4,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24, letterSpacing: 16, color: AppColors.kPrimary),
      decoration: InputDecoration(
        labelText: label,
        counterText: "",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kPrimary, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}