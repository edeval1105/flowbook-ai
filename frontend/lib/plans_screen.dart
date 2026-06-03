import 'package:flutter/material.dart';

class PlansScreen
    extends StatelessWidget {

  const PlansScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final plans = [

      {
        'name': 'Free',
        'price': 'R\$ 0',

        'features': [

          '20 agendamentos',
          'Dashboard básico',
          '1 usuário',
        ],

        'color': Colors.grey,
      },

      {
        'name': 'Pro',
        'price': 'R\$ 49/mês',

        'features': [

          'Agendamentos ilimitados',
          'WhatsApp',
          'IA integrada',
          'Analytics',
        ],

        'color': Colors.blue,
      },

      {
        'name': 'Business',
        'price': 'R\$ 99/mês',

        'features': [

          'Multiusuário',
          'Equipe',
          'CRM avançado',
          'IA premium',
          'Relatórios',
        ],

        'color': Colors.purple,
      },
    ];

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Planos',
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: ListView.builder(

          itemCount: plans.length,

          itemBuilder:
              (context, index) {

            final plan =
                plans[index];

            return Container(

              margin:
                  const EdgeInsets.only(
                bottom: 20,
              ),

              padding:
                  const EdgeInsets.all(
                24,
              ),

              decoration:
                  BoxDecoration(

                color:
                    Theme.of(context)
                        .cardColor,

                borderRadius:
                    BorderRadius.circular(
                  24,
                ),

                border: Border.all(

                  color:
                      plan['color']
                          as Color,

                  width: 2,
                ),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black
                        .withOpacity(
                      0.05,
                    ),

                    blurRadius: 10,
                  ),
                ],
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Row(

                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,

                    children: [

                      Text(

                        plan['name']
                            .toString(),

                        style:
                            const TextStyle(

                          fontSize: 24,

                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),

                      Container(

                        padding:
                            const EdgeInsets
                                .symmetric(

                          horizontal: 16,

                          vertical: 8,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              plan['color']
                                  as Color,

                          borderRadius:
                              BorderRadius
                                  .circular(
                            20,
                          ),
                        ),

                        child: Text(

                          plan['price']
                              .toString(),

                          style:
                              const TextStyle(

                            color:
                                Colors.white,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  ...(plan['features']
                          as List<String>)
                      .map(

                    (feature) {

                      return Padding(

                        padding:
                            const EdgeInsets
                                .only(
                          bottom: 12,
                        ),

                        child: Row(

                          children: [

                            Icon(

                              Icons.check_circle,

                              color:
                                  plan['color']
                                      as Color,
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Text(feature),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  SizedBox(

                    width:
                        double.infinity,

                    child: ElevatedButton(

                      onPressed: () {

                        ScaffoldMessenger
                                .of(
                          context,
                        ).showSnackBar(

                          SnackBar(

                            content: Text(
                              'Plano ${plan['name']} selecionado',
                            ),
                          ),
                        );
                      },

                      child: const Text(
                        'Escolher plano',
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}