import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {

  static const String baseUrl =
      'http://127.0.0.1:5000';

  static Future<dynamic> login(
    String email,
    String password,
  ) async {

    final response = await http.post(

      Uri.parse('$baseUrl/auth/login'),

      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({

        'email': email,
        'password': password,
      }),
    );

    final data =
        jsonDecode(response.body);

    print(data);


    if (data['token'] != null) {

      final prefs =
          await SharedPreferences.getInstance();

      await prefs.setString(
        'token',
        data['token'],
      );
    }

    return data;
  }
  
  static Future<List<dynamic>>
getAppointments() async {

  final prefs =
      await SharedPreferences.getInstance();

  final token =
      prefs.getString('token');

    print('Token: $token');

  final response = await http.get(

    Uri.parse(
      '$baseUrl/appointments',
    ),

    headers: {
      'Authorization':
          'Bearer $token',
    },
  );

  print('Appointments: ${response.body}');
  return jsonDecode(response.body);
}

static Future<dynamic>
createAppointment({

  required String customerName,
  required String customerPhone,
  required String price,

}) async {

  final prefs =
      await SharedPreferences.getInstance();

  final token =
      prefs.getString('token');

  final response =
      await http.post(

    Uri.parse(
      '$baseUrl/appointments',
    ),

    headers: {

      'Content-Type':
          'application/json',

      'Authorization':
          'Bearer $token',
    },

    body: jsonEncode({

      'professional_id': 1,

      'customer_id': 1,

      'service_id': 2,

      'start_at':
          DateTime.now()
              .toIso8601String(),

      'end_at':
          DateTime.now()
              .add(
                const Duration(
                  hours: 1,
                ),
              )
              .toIso8601String(),

      'price': price,

      'status': 'confirmed',

      'customer_name':
          customerName,

      'customer_phone':
          customerPhone,

      'notes':
          'Criado pelo Flutter',
    }),
  );

  return jsonDecode(
    response.body,
  );
}

static Future<void>
deleteAppointment(int id) async {

  final prefs =
      await SharedPreferences.getInstance();

  final token =
      prefs.getString('token');

  await http.delete(

    Uri.parse(
      '$baseUrl/appointments/$id',
    ),

    headers: {

      'Authorization':
          'Bearer $token',
    },
  );
}

static Future<dynamic>
updateAppointment({

  required int id,

  required String customerName,

  required String customerPhone,

  required String price,

}) async {

  final prefs =
      await SharedPreferences.getInstance();

  final token =
      prefs.getString('token');

  final response =
      await http.put(

    Uri.parse(
      '$baseUrl/appointments/$id',
    ),

    headers: {

      'Content-Type':
          'application/json',

      'Authorization':
          'Bearer $token',
    },

    body: jsonEncode({

      'customer_name':
          customerName,

      'customer_phone':
          customerPhone,

      'price': price,
    }),
  );

  return jsonDecode(
    response.body,
  );
}

}