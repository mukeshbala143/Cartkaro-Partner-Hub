import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({Key? key}) : super(key: key);

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/logo.png',
                    height: 100,
                    errorBuilder: (context, error, stackTrace) => 
                        const Icon(LucideIcons.shoppingBag, size: 64, color: AppColors.kPrimary),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Welcome Back!",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.kDarkText,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Enter your 4-digit PIN to access your dashboard.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.kLightText),
                ),
                const SizedBox(height: 48),
                
                // PIN Input Field
                TextFormField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  obscuringCharacter: '●',
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 32, letterSpacing: 24, color: AppColors.kPrimary),
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "••••",
                    hintStyle: TextStyle(color: AppColors.kBorder, letterSpacing: 24),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.kPrimary, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Demo verification
                      if (_pinController.text == '1234') {
                        context.go('/dashboard');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Login", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 16),
                
                TextButton(
                  onPressed: () {
                    // Yahan Forgot PIN / OTP verify ka bottom sheet ya screen khulega
                    _showForgotPinBottomSheet(context);
                  },
                  child: const Text("Forgot PIN?", style: TextStyle(color: AppColors.kPrimary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showForgotPinBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Reset PIN", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text("We will send an OTP to your registered mobile number to reset your PIN."),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.kPrimary, padding: const EdgeInsets.symmetric(vertical: 16)),
                  onPressed: () {
                    Navigator.pop(context); // Pehle Bottom Sheet band karo
                    context.push('/reset-pin'); // Fir naye page par bhej do
                  }, // Aage OTP screen pe bhejenge
                  child: const Text("Send OTP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}