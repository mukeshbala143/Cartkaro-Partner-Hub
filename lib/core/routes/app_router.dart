import 'package:go_router/go_router.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/pin_login_screen.dart';
import '../../features/auth/screens/business_type_screen.dart';
import '../../features/auth/screens/grocery_registration_screen.dart';
import '../../features/dashboard/screens/dashboard_layout.dart';
import '../../features/auth/screens/reset_pin_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      // Naya user Mobile + OTP se register/login karega
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      // Purana user direct PIN se login karega
      GoRoute(
        path: '/pin-login',
        builder: (context, state) => const PinLoginScreen(),
      ),
      GoRoute(
        path: '/business-type',
        builder: (context, state) => const BusinessTypeScreen(),
      ),
      // Grocery Registration (9-Step Wizard)
      GoRoute(
        path: '/register/grocery',
        builder: (context, state) => const GroceryRegistrationScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardLayout(),
      ),
      GoRoute(
        path: '/reset-pin',
        builder: (context, state) => const ResetPinScreen(),
      ),
    ],
  );
}