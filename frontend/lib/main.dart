import 'package:flutter/material.dart';

import 'auth_check.dart';

void main() {

  runApp(
    const MyApp(),
  );
}

class MyApp
    extends StatelessWidget {

  const MyApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return MaterialApp(

  debugShowCheckedModeBanner:
      false,

  home: const AuthCheck(),
);
  }
}