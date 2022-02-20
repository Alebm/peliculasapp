import 'package:flutter/material.dart';
import 'package:peliculasapp/providers/movie_provider.dart';
import 'package:peliculasapp/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

/*Creo el provider en lo mas alto de la app, para poder tener acceso a el en 
cualquier lugar de la app */

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        ),
      ],
      //Luego LLamamos MyApp para continuar con la app
      child: const MyApp(),
    );
  }
}

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
