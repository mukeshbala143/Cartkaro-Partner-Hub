import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CartKaroPartnerApp());
}

class CartKaroPartnerApp extends StatelessWidget {
  const CartKaroPartnerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScreenUtil setup for responsive typography and spacing
    return ScreenUtilInit(
      designSize: const Size(390, 844), // Base mobile design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            // Add your state management providers here later (e.g., AuthProvider, ProductProvider)
            Provider(create: (_) => ()), 
          ],
          child: MaterialApp.router(
            title: 'CartKaro Partner Hub',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}