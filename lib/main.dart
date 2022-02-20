import 'package:flutter/material.dart';
import 'package:peliculasapp/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home': ((context) => const HomeScreen()),
        'details': (context) => const DetailsScreen()
      },
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Colors.amber),
      ),
    );
  }
}
