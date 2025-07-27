import 'package:flutter/material.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/tools/constants.dart';
import 'package:notes_app/pages/main_page.dart';
import 'package:provider/provider.dart';


void main() async {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => NotesProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Take Notes',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
      home: MainPage(), 
    ));
  }
}