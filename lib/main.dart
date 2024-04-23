import 'package:flutter/material.dart';
import 'package:my_local/src/screens/places_form_screen.dart';
import 'src/screens/places_list_screen.dart';
import 'src/utils/app_routs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My local',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Colors.green,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      routes: {
        AppRoutes.placeForm: (ctx) => const PlacesFormScreen(),
      },
      home: const PlacesListScreen(),
    );
  }
}
