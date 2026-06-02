import 'package:flutter/material.dart';
import 'services/api_service.dart';

class EditAppointmentScreen
    extends StatefulWidget {

  final Map appointment;

  const EditAppointmentScreen({

    super.key,

    required this.appointment,
  });

  @override
  State<EditAppointmentScreen>
      createState() =>
          _EditAppointmentScreenState();
}

class _EditAppointmentScreenState
    extends State<
        EditAppointmentScreen> {

  late TextEditingController
      customerController;

  late TextEditingController
      phoneController;

  late TextEditingController
      priceController;

  @override
  void initState() {

    super.initState();

    customerController =
        TextEditingController(
      text:
          widget.appointment[
              'customer_name'],
    );

    phoneController =
        TextEditingController(
      text:
          widget.appointment[
              'customer_phone'],
    );

    priceController =
        TextEditingController(
      text:
          widget.appointment[
              'price']
              .toString(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Editar Agendamento',
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

                  await ApiService
                      .updateAppointment(

                    id:
                        widget.appointment['id'],

                    customerName:
                        customerController.text,

                    customerPhone:
                        phoneController.text,

                    price:
                        priceController.text,
                  );

                  if (context.mounted) {

                    Navigator.pop(
                      context,
                    );
                  }
                },

                child: const Text(
                  'Salvar Alterações',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}