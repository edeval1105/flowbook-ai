import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_check.dart';
import 'theme_provider.dart';

void main() {

  runApp(

    ChangeNotifierProvider(

      create: (_) => ThemeProvider(),

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final themeProvider =
        Provider.of<ThemeProvider>(
      context,
    );

    return MaterialApp(

      debugShowCheckedModeBanner:
          false,

      themeMode:
          themeProvider.currentTheme,

      theme: ThemeData(

        brightness:
            Brightness.light,

        primarySwatch:
            Colors.blue,
      ),

      darkTheme: ThemeData(

        brightness:
            Brightness.dark,

        scaffoldBackgroundColor:
            const Color(0xff121212),

        cardColor:
            const Color(0xff1E1E1E),
      ),

      home: const AuthCheck(),
    );
  }
}