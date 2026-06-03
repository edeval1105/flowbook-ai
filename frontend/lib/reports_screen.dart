import 'package:flutter/material.dart';

class ReportsScreen
    extends StatelessWidget {

  const ReportsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final reports = [

      {
        'title':
            'Faturamento mensal',

        'value':
            'R\$ 12.540',

        'icon':
            Icons.attach_money,

        'color':
            Colors.green,
      },

      {
        'title':
            'Clientes ativos',

        'value':
            '84',

        'icon':
            Icons.people,

        'color':
            Colors.blue,
      },

      {
        'title':
            'Crescimento semanal',

        'value':
            '+22%',

        'icon':
            Icons.trending_up,

        'color':
            Colors.orange,
      },

      {
        'title':
            'Agendamentos hoje',

        'value':
            '26',

        'icon':
            Icons.calendar_month,

        'color':
            Colors.purple,
      },
    ];

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Relatórios',
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: ListView(

          children: [

            GridView.builder(

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount:
                  reports.length,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,

                crossAxisSpacing: 16,

                mainAxisSpacing: 16,

                childAspectRatio: 1.1,
              ),

              itemBuilder:
                  (context, index) {

                final report =
                    reports[index];

                return Container(

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
                      24,
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

                      Container(

                        padding:
                            const EdgeInsets
                                .all(12),

                        decoration:
                            BoxDecoration(

                          color:
                              report['color']
                                  as Color,

                          borderRadius:
                              BorderRadius
                                  .circular(
                            16,
                          ),
                        ),

                        child: Icon(

                          report['icon']
                              as IconData,

                          color:
                              Colors.white,
                        ),
                      ),

                      const Spacer(),

                      Text(

                        report['value']
                            .toString(),

                        style:
                            const TextStyle(

                          fontSize: 24,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        report['title']
                            .toString(),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(
              height: 32,
            ),

            Container(

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

                  const Text(

                    'Insights IA',

                    style: TextStyle(

                      fontSize: 22,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  insightTile(
                    Icons.psychology,
                    'Clientes respondem mais às 18h.',
                  ),

                  insightTile(
                    Icons.auto_graph,
                    'Seu faturamento cresceu 22% esta semana.',
                  ),

                  insightTile(
                    Icons.notifications_active,
                    '3 clientes ainda não confirmaram.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget insightTile(
    IconData icon,
    String text,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 16,
      ),

      child: Row(

        children: [

          Icon(icon),

          const SizedBox(
            width: 12,
          ),

          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}