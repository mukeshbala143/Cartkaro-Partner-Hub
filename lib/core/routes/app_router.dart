import 'package:go_router/go_router.dart';

import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/pin_login_screen.dart';
import '../../features/auth/screens/business_type_screen.dart';

import '../../features/auth/screens/grocery_registration_screen.dart';
import '../../features/auth/screens/restaurant_registration_screen.dart';
import '../../features/auth/screens/medical_registration_screen.dart';

import '../../features/dashboard/screens/dashboard_layout.dart';

import '../../features/auth/screens/reset_pin_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',

    routes: [
      GoRoute(path: '/', redirect: (context, state) => '/login'),

      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Mobile OTP Login
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

      // Existing Partner PIN Login
      GoRoute(
        path: '/pin-login',
        builder: (context, state) => const PinLoginScreen(),
      ),

      // Choose Grocery / Restaurant / Medical
      GoRoute(
        path: '/business-type',
        builder: (context, state) => const BusinessTypeScreen(),
      ),

      // Grocery Registration
      GoRoute(
        path: '/register/grocery',
        builder: (context, state) => const GroceryRegistrationScreen(),
      ),

      // Restaurant Registration
      GoRoute(
        path: '/register/restaurant',
        builder: (context, state) => const RestaurantRegistrationScreen(),
      ),

      // Medical Registration
      GoRoute(
        path: '/register/medical',
        builder: (context, state) => const MedicalRegistrationScreen(),
      ),

      // Default Dashboard
      GoRoute(
        path: '/dashboard',
        builder: (context, state) =>
            const DashboardLayout(businessType: "grocery"),
      ),

      // Reset PIN
      GoRoute(
        path: '/reset-pin',
        builder: (context, state) => const ResetPinScreen(),
      ),
    ],
  );
}
