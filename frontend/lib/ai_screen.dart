import 'package:flutter/material.dart';

class AiScreen extends StatelessWidget {

  const AiScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final insights = [

      {
        'title':
            'Clientes pendentes',
        'description':
            'Você possui 3 clientes pendentes hoje.',
        'icon':
            Icons.notifications_active,
        'color':
            Colors.orange,
      },

      {
        'title':
            'Faturamento',
        'description':
            'Seu faturamento aumentou 18% esta semana.',
        'icon':
            Icons.trending_up,
        'color':
            Colors.green,
      },

      {
        'title':
            'Horário de pico',
        'description':
            'Seu horário mais movimentado é às 18h.',
        'icon':
            Icons.access_time,
        'color':
            Colors.blue,
      },

      {
        'title':
            'Reagendamentos',
        'description':
            'Maria costuma reagendar às sextas-feiras.',
        'icon':
            Icons.psychology,
        'color':
            Colors.purple,
      },
    ];

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'FlowBook AI',
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: ListView.builder(

          itemCount:
              insights.length,

          itemBuilder:
              (context, index) {

            final insight =
                insights[index];

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

                color:
                    Theme.of(context)
                        .cardColor,

                borderRadius:
                    BorderRadius.circular(
                  20,
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

              child: Row(

                children: [

                  Container(

                    padding:
                        const EdgeInsets
                            .all(16),

                    decoration:
                        BoxDecoration(

                      color:
                          insight['color']
                              as Color,

                      borderRadius:
                          BorderRadius
                              .circular(
                        16,
                      ),
                    ),

                    child: Icon(

                      insight['icon']
                          as IconData,

                      color:
                          Colors.white,

                      size: 32,
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(

                          insight['title']
                              .toString(),

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
                          insight[
                                  'description']
                              .toString(),
                        ),
                      ],
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