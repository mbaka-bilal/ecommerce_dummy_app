import 'package:flutter/material.dart';

import 'pages/onboarding/splash_screen.dart';
import 'utils/appstyles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.w400
          )
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
