import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/change_notifiers/registration_controller.dart';
import 'package:notes_app/pages/main_page.dart';
import 'package:notes_app/pages/registration_page.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/tools/constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Take Notes',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: background,
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: Colors.transparent,
            titleTextStyle: TextStyle(
              color: primary,
              fontSize: 32,
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: StreamBuilder<User?>(
          stream: AuthService.userStream,
          builder: (context, snapshot) {
            return snapshot.hasData && AuthService.isEmailVerified
                ? const MainPage()
                : const RegistrationPage();
          },
        ),
      ),
    );
  }
}
