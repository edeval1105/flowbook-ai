import 'package:flutter/material.dart';

class NotificationsScreen
    extends StatelessWidget {

  const NotificationsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final notifications = [

      {
        'title':
            'Agendamento próximo',
        'message':
            'João possui agendamento em 30 minutos.',
        'icon':
            Icons.access_alarm,
        'color':
            Colors.orange,
      },

      {
        'title':
            'Clientes pendentes',
        'message':
            '2 clientes ainda não confirmaram.',
        'icon':
            Icons.notifications_active,
        'color':
            Colors.red,
      },

      {
        'title':
            'Faturamento',
        'message':
            'Faturamento abaixo da média hoje.',
        'icon':
            Icons.attach_money,
        'color':
            Colors.green,
      },

      {
        'title':
            'Insight IA',
        'message':
            'Clientes respondem mais às 18h.',
        'icon':
            Icons.psychology,
        'color':
            Colors.purple,
      },
    ];

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Notificações',
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: ListView.builder(

          itemCount:
              notifications.length,

          itemBuilder:
              (context, index) {

            final item =
                notifications[index];

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
                          item['color']
                              as Color,

                      borderRadius:
                          BorderRadius
                              .circular(
                        16,
                      ),
                    ),

                    child: Icon(

                      item['icon']
                          as IconData,

                      color:
                          Colors.white,

                      size: 30,
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

                          item['title']
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
                          item['message']
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