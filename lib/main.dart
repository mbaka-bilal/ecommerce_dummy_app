import 'package:ecommerce_dummy_app/repositories/authentication_respository.dart';
import 'package:ecommerce_dummy_app/repositories/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication_bloc.dart';
import 'bloc/form_state_cubit.dart';
import 'firebase_options.dart';
import 'onboarding/splash_screen.dart';
import 'utils/appstyles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}): super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    // _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
              userRepository: _userRepository,
            ),
          ),
          BlocProvider<LoginFormStatus>(
            create: (context) => LoginFormStatus(),
          ),
        ],
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          }
        }))),
        fontFamily: "Poppins",
        textTheme: const TextTheme(
            titleMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            titleLarge: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 28,
            ),
            bodySmall: TextStyle(fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
