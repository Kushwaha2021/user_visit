import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_visit/providers/visits_provider.dart';
import 'package:user_visit/screens/visits_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VisitsProvider(),
      child: MaterialApp(
        title: 'Visits App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[100],
            foregroundColor: Colors.black87,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black54),
          ),
          chipTheme: ChipThemeData(
              backgroundColor: Colors.grey.shade200,
              selectedColor: Colors.blue.shade600,
              secondarySelectedColor: Colors.blue.shade600,
              labelStyle: const TextStyle(color: Colors.black87),
              secondaryLabelStyle: const TextStyle(color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const VisitsScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
