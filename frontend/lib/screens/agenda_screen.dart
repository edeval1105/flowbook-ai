import 'package:flutter/material.dart';

import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  String message = '';

  Future<void> login() async {

    final result = await ApiService.login(
      emailController.text,
      passwordController.text,
    );

    setState(() {
      message = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('FlowBook AI'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: emailController,
              decoration:
                  const InputDecoration(
                labelText: 'Email',
              ),
            ),

            TextField(
              controller:
                  passwordController,

              decoration:
                  const InputDecoration(
                labelText: 'Senha',
              ),

              obscureText: true,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: login,
              child: const Text('Entrar'),
            ),

            const SizedBox(height: 20),

            Text(message),
          ],
        ),
      ),
    );
  }
}