import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_local/src/providers/great_places.dart';
import 'package:my_local/src/screens/places_form_screen.dart';
import 'package:provider/provider.dart';
import 'src/screens/places_list_screen.dart';
import 'src/utils/app_routs.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Local',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
          ),
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
      ),
    );
  }
}
