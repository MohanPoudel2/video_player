import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/provider/shoes_list_provider/shoes_list_provider.dart';
import 'package:video_player_app/screens/login_screen/login_screen.dart';

void main()  {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewShoesListProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const LoginScreen(), // Set HomeScreen as the initial screen
      ),
    );
  }
}
