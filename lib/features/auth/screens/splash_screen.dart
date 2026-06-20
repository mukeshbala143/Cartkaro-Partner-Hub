import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    
    _controller.forward();

    // 3 seconds ke baad auto-navigate to PIN Login (Returning User)
    // Jab backend lagega tab check karenge ki user logged in hai ya nahi
    Future.delayed(const Duration(seconds: 3), () {
       //if (mounted) context.go('/pin-login');
       if (mounted) context.go('/login'); // Abhi ke liye seedha login page pe bhej rahe hain 
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24), 
                child: Image.asset(
                  'assets/logo.png',
                  height: 120, 
                  width: 120,
                  fit: BoxFit.contain, 
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "CartKaro Partner",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.kDarkText,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                "One platform to grow your business",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.kLightText,
                    ),
              ),
              const SizedBox(height: 48),
              
              // Loading Spinner - Color updated to App brand color
              const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: AppColors.kPrimary,
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}