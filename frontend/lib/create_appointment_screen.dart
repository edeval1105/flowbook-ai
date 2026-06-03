import 'package:flutter/material.dart';
import 'services/api_service.dart';

class CreateAppointmentScreen
    extends StatefulWidget {

  const CreateAppointmentScreen({
    super.key,
  });

  @override
  State<CreateAppointmentScreen>
      createState() =>
          _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState
    extends State<
        CreateAppointmentScreen> {

  final customerController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final priceController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Novo Agendamento',
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(

              controller:
                  customerController,

              decoration:
                  const InputDecoration(
                labelText:
                    'Cliente',
              ),
            ),

            const SizedBox(height: 16),

            TextField(

              controller:
                  phoneController,

              decoration:
                  const InputDecoration(
                labelText:
                    'Telefone',
              ),
            ),

            const SizedBox(height: 16),

            TextField(

              controller:
                  priceController,

              decoration:
                  const InputDecoration(
                labelText:
                    'Preço',
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,

              height: 55,

              child: ElevatedButton(

    onPressed: () async {

        final result =
               await ApiService
              .createAppointment(

            customerName:
              customerController.text,

                customerPhone:
                  phoneController.text,

                    price:
                       priceController.text,
      );

                    if (context.mounted) {

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(

                        const SnackBar(

                          content: Text(
                            'Agendamento criado com sucesso',
                          ),
                        ),
                      );
                    }

  print(result);

  if (context.mounted) {

    Navigator.pop(context);
  }
},

                child: const Text(
                  'Salvar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}