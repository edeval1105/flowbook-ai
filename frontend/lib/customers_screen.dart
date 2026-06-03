import 'package:flutter/material.dart';

class CustomersScreen extends StatefulWidget {

  const CustomersScreen({
    super.key,
  });

  @override
  State<CustomersScreen> createState() =>
      _CustomersScreenState();
}

class _CustomersScreenState
    extends State<CustomersScreen> {

  final List customers = [

    {
      'name': 'João Silva',
      'phone': '(11) 99999-1111',
      'appointments': 5,
    },

    {
      'name': 'Maria Souza',
      'phone': '(11) 98888-2222',
      'appointments': 3,
    },

    {
      'name': 'Carlos Lima',
      'phone': '(11) 97777-3333',
      'appointments': 8,
    },
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {

    final filteredCustomers =
        customers.where((customer) {

      return customer['name']
          .toString()
          .toLowerCase()
          .contains(
            search.toLowerCase(),
          );
    }).toList();

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Clientes',
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              decoration:
                  InputDecoration(

                hintText:
                    'Buscar cliente',

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius
                          .circular(
                    16,
                  ),
                ),
              ),

              onChanged: (value) {

                setState(() {

                  search = value;
                });
              },
            ),

            const SizedBox(
              height: 24,
            ),

            Expanded(

              child:
                  ListView.builder(

                itemCount:
                    filteredCustomers
                        .length,

                itemBuilder:
                    (context, index) {

                  final customer =
                      filteredCustomers[
                          index];

                  return Container(

                    margin:
                        const EdgeInsets.only(
                      bottom: 16,
                    ),

                    padding:
                        const EdgeInsets.all(
                      20,
                    ),

                    decoration:
                        BoxDecoration(

                      color: Theme.of(
                        context,
                      ).cardColor,

                      borderRadius:
                          BorderRadius
                              .circular(
                        20,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color: Colors
                              .black
                              .withOpacity(
                            0.05,
                          ),

                          blurRadius: 10,
                        ),
                      ],
                    ),

                    child: Row(

                      children: [

                        CircleAvatar(

                          radius: 30,

                          child: Text(

                            customer['name']
                                [0],
                          ),
                        ),

                        const SizedBox(
                          width: 16,
                        ),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(

                                customer[
                                    'name'],

                                style:
                                    const TextStyle(

                                  fontSize: 18,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              Text(
                                customer[
                                    'phone'],
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              Text(
                                '${customer['appointments']} agendamentos',
                              ),
                            ],
                          ),
                        ),

                        IconButton(

                          onPressed: () {},

                          icon: const Icon(
                            Icons.message,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
