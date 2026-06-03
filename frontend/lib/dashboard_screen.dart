import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'services/api_service.dart';
import 'widgets/sidebar.dart';
import 'widgets/revenue_chart.dart';

import 'calendar_screen.dart';
import 'create_appointment_screen.dart';
import 'edit_appointment_screen.dart';
import 'auth_check.dart';
import 'theme_provider.dart';

class DashboardScreen extends StatefulWidget {

  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  List appointments = [];

  bool loading = true;

  double totalRevenue = 0;

  int confirmedCount = 0;

  @override
  void initState() {

    super.initState();

    loadAppointments();
  }

  Future<void> loadAppointments() async {

    try {

      final data =
          await ApiService.getAppointments();

      double revenue = 0;

      int confirmed = 0;

      for (var appt in data) {

        revenue +=
            double.tryParse(
                  appt['price']
                      .toString(),
                ) ??
                0;

        if (appt['status'] ==
            'confirmed') {

          confirmed++;
        }
      }

      setState(() {

        appointments = data;

        totalRevenue = revenue;

        confirmedCount = confirmed;

        loading = false;
      });

    } catch (e) {

      debugPrint(e.toString());

      setState(() {

        loading = false;
      });
    }
  }

  Future<void> logout() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.remove('token');

    if (context.mounted) {

      Navigator.pushAndRemoveUntil(

        context,

        MaterialPageRoute(

          builder: (_) =>
              const AuthCheck(),
        ),

        (route) => false,
      );
    }
  }

  Color getStatusColor(
    String status,
  ) {

    switch (status) {

      case 'confirmed':
        return Colors.green;

      case 'pending':
        return Colors.orange;

      case 'cancelled':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    final isMobile =
        MediaQuery.of(context)
                .size
                .width <
            900;

    return Scaffold(

      drawer: isMobile

          ? const Drawer(
              child: Sidebar(),
            )

          : null,

      floatingActionButton:
          FloatingActionButton(

        onPressed: () async {

          await Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) =>
                  const CreateAppointmentScreen(),
            ),
          );

          loadAppointments();
        },

        child: const Icon(
          Icons.add,
        ),
      ),

      appBar: AppBar(

        leading: isMobile

            ? Builder(

                builder: (context) {

                  return IconButton(

                    icon: const Icon(
                      Icons.menu,
                    ),

                    onPressed: () {

                      Scaffold.of(
                        context,
                      ).openDrawer();
                    },
                  );
                },
              )

            : null,

        title: const Text(
          'FlowBook AI',
        ),

        actions: [

          IconButton(

            onPressed: () {

              Provider.of<
                  ThemeProvider>(

                context,

                listen: false,
              ).toggleTheme();
            },

            icon: const Icon(
              Icons.dark_mode,
            ),
          ),

          IconButton(

            onPressed: () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                      const CalendarScreen(),
                ),
              );
            },

            icon: const Icon(
              Icons.calendar_month,
            ),
          ),

          IconButton(

            onPressed: logout,

            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),

      body: loading

          ? const Center(

              child:
                  CircularProgressIndicator(),
            )

          : isMobile

              ? Padding(

                  padding:
                      const EdgeInsets.all(
                    16,
                  ),

                  child: content(),
                )

              : Row(

                  children: [

                    const Sidebar(),

                    Expanded(

                      child: Padding(

                        padding:
                            const EdgeInsets
                                .all(16),

                        child: content(),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget content() {

    return Column(

      children: [

        Row(

          children: [

            Expanded(

              child: analyticsCard(

                'Agendamentos',

                appointments.length
                    .toString(),

                Icons.calendar_month,

                Colors.blue,
              ),
            ),

            const SizedBox(
              width: 16,
            ),

            Expanded(

              child: analyticsCard(

                'Confirmados',

                confirmedCount
                    .toString(),

                Icons.check_circle,

                Colors.green,
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 16,
        ),

        Row(

          children: [

            Expanded(

              child: analyticsCard(

                'Faturamento',

                'R\$ ${totalRevenue.toStringAsFixed(2)}',

                Icons.attach_money,

                Colors.orange,
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 24,
        ),

        const RevenueChart(),

        const SizedBox(
          height: 24,
        ),

        Expanded(

          child: appointments.isEmpty

              ? const Center(

                  child: Text(
                    'Nenhum agendamento',
                  ),
                )

              : ListView.builder(

                  itemCount:
                      appointments.length,

                  itemBuilder:
                      (context, index) {

                    final appointment =
                        appointments[index];

                    final status =
                        appointment['status']
                            .toString();

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
                            BorderRadius
                                .circular(20),

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

                                appointment[
                                        'customer_name'] ??
                                    '',

                                style:
                                    const TextStyle(

                                  fontSize: 20,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              Container(

                                padding:
                                    const EdgeInsets
                                        .symmetric(

                                  horizontal: 12,

                                  vertical: 6,
                                ),

                                decoration:
                                    BoxDecoration(

                                  color:
                                      getStatusColor(
                                    status,
                                  ),

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    20,
                                  ),
                                ),

                                child: Text(

                                  status,

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
                            height: 12,
                          ),

                          Text(
                            'Telefone: ${appointment['customer_phone']}',
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Text(
                            'Preço: R\$ ${appointment['price']}',
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          SizedBox(

                            width:
                                double.infinity,

                            child: ElevatedButton(

                              onPressed:
                                  () async {

                                await Navigator
                                    .push(

                                  context,

                                  MaterialPageRoute(

                                    builder: (_) =>
                                        EditAppointmentScreen(
                                      appointment:
                                          appointment,
                                    ),
                                  ),
                                );

                                loadAppointments();
                              },

                              child: const Text(
                                'Editar',
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          SizedBox(

                            width:
                                double.infinity,

                            child: ElevatedButton(

                              onPressed:
                                  () async {

                                final confirm =
                                    await showDialog(

                                  context:
                                      context,

                                  builder:
                                      (context) {

                                    return AlertDialog(

                                      title:
                                          const Text(
                                        'Excluir agendamento',
                                      ),

                                      content:
                                          const Text(
                                        'Deseja realmente excluir?',
                                      ),

                                      actions: [

                                        TextButton(

                                          onPressed:
                                              () {

                                            Navigator.pop(
                                              context,
                                              false,
                                            );
                                          },

                                          child:
                                              const Text(
                                            'Cancelar',
                                          ),
                                        ),

                                        ElevatedButton(

                                          onPressed:
                                              () {

                                            Navigator.pop(
                                              context,
                                              true,
                                            );
                                          },

                                          child:
                                              const Text(
                                            'Excluir',
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm ==
                                    true) {

                                  await ApiService
                                      .deleteAppointment(
                                    appointment[
                                        'id'],
                                  );

                                  loadAppointments();

                                  if (context
                                      .mounted) {

                                    ScaffoldMessenger
                                            .of(
                                      context,
                                    ).showSnackBar(

                                      const SnackBar(

                                        content:
                                            Text(
                                          'Agendamento excluído',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },

                              child: const Text(
                                'Excluir',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget analyticsCard(

    String title,

    String value,

    IconData icon,

    Color color,
  ) {

    return Container(

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: color,

        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(

            icon,

            color: Colors.white,

            size: 32,
          ),

          const SizedBox(
            height: 20,
          ),

          Text(

            value,

            style: const TextStyle(

              color: Colors.white,

              fontSize: 24,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          Text(

            title,

            style: const TextStyle(

              color: Colors.white70,

              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}