import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/login_screen.dart';
import 'dashboard_screen.dart';

class AuthCheck
    extends StatefulWidget {

  const AuthCheck({
    super.key,
  });

  @override
  State<AuthCheck> createState() =>
      _AuthCheckState();
}

class _AuthCheckState
    extends State<AuthCheck> {

  bool loading = true;

  bool logged = false;

  @override
  void initState() {

    super.initState();

    checkLogin();
  }

  Future<void> checkLogin() async {

    final prefs =
        await SharedPreferences.getInstance();

    final token =
        prefs.getString('token');

    setState(() {

      logged =
          token != null;

      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (loading) {

      return const Scaffold(

        body: Center(

          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (logged) {

      return const DashboardScreen();
    }

    return const LoginScreen();
  }
}