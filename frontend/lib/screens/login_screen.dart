import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';
import '../dashboard_screen.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({
    super.key,
  });

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

  String responseText = '';

  bool loading = false;

  Future<void> login() async {

    setState(() {

      loading = true;

      responseText = '';
    });

    try {

      final result =
          await ApiService.login(

        emailController.text.trim(),

        passwordController.text.trim(),
      );

      print(result);

      if (result['token'] != null) {

        final prefs =
            await SharedPreferences
                .getInstance();

        await prefs.setString(
          'token',
          result['token'],
        );

        print('TOKEN SALVO');

        if (context.mounted) {

          Navigator.pushReplacement(

            context,

            MaterialPageRoute(

              builder: (_) =>
                  const DashboardScreen(),
            ),
          );
        }

      } else {

        setState(() {

          responseText =
              'Email ou senha inválidos';
        });
      }

    } catch (e) {

      print(e);

      setState(() {

        responseText =
            'Erro ao fazer login';
      });

    } finally {

      if (mounted) {

        setState(() {

          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'FlowBook AI',
        ),
      ),

      body: Center(

        child: SingleChildScrollView(

          child: Padding(

            padding:
                const EdgeInsets.all(24),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.stretch,

              children: [

                const Icon(

                  Icons.calendar_month,

                  size: 90,

                  color: Colors.blue,
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text(

                  'Login',

                  textAlign: TextAlign.center,

                  style: TextStyle(

                    fontSize: 32,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),

                TextField(

                  controller:
                      emailController,

                  decoration:
                      const InputDecoration(

                    labelText: 'Email',

                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                TextField(

                  controller:
                      passwordController,

                  obscureText: true,

                  decoration:
                      const InputDecoration(

                    labelText: 'Senha',

                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                SizedBox(

                  height: 55,

                  child: ElevatedButton(

                    onPressed:
                        loading
                            ? null
                            : login,

                    child:
                        loading

                        ? const CircularProgressIndicator()

                        : const Text(

                            'Entrar',

                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Text(

                  responseText,

                  textAlign:
                      TextAlign.center,

                  style: const TextStyle(

                    color: Colors.red,

                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}