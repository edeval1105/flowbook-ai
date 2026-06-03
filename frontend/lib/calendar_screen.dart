import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'services/api_service.dart';

class CalendarScreen extends StatefulWidget {

  const CalendarScreen({
    super.key,
  });

  @override
  State<CalendarScreen> createState() =>
      _CalendarScreenState();
}

class _CalendarScreenState
    extends State<CalendarScreen> {

  DateTime focusedDay =
      DateTime.now();

  DateTime? selectedDay;

  List appointments = [];

  bool loading = true;

  @override
  void initState() {

    super.initState();

    loadAppointments();
  }

  Future<void> loadAppointments() async {

    try {

      final data =
          await ApiService
              .getAppointments();

      setState(() {

        appointments =
            data;

        loading = false;
      });

    } catch (e) {

      print(e);

      setState(() {

        loading = false;
      });
    }
  }

  List getAppointmentsForDay(
    DateTime day,
  ) {

    return appointments.where((a) {

      final date =
          DateTime.parse(
        a['start_at'],
      );

      return
          date.year == day.year &&
          date.month == day.month &&
          date.day == day.day;

    }).toList();
  }

  Color getStatusColor(
    String status,
  ) {

    switch (status) {

      case 'confirmed':
        return Colors.green;

      case 'pending':
        return Colors.orange;

      case 'canceled':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    final dayAppointments =
        selectedDay == null

            ? []

            : getAppointmentsForDay(
                selectedDay!,
              );

    return Scaffold(

      backgroundColor:
          Colors.grey.shade100,

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            Colors.blue,

        foregroundColor:
            Colors.white,

        title: const Text(
          'Calendário',
        ),
      ),

      body: loading

          ? const Center(

              child:
                  CircularProgressIndicator(),
            )

          : Padding(

              padding:
                  const EdgeInsets.all(
                16,
              ),

              child: Column(

                children: [

                  Container(

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color: Colors.black
                              .withValues(
                            alpha: 0.05,
                          ),

                          blurRadius: 10,
                        ),
                      ],
                    ),

                    child: TableCalendar(

                      firstDay:
                          DateTime.utc(
                        2020,
                      ),

                      lastDay:
                          DateTime.utc(
                        2035,
                      ),

                      focusedDay:
                          focusedDay,

                      selectedDayPredicate:
                          (day) {

                        return isSameDay(
                          selectedDay,
                          day,
                        );
                      },

                      onDaySelected:
                          (
                            selected,
                            focused,
                          ) {

                        setState(() {

                          selectedDay =
                              selected;

                          focusedDay =
                              focused;
                        });
                      },

                      calendarStyle:
                          const CalendarStyle(

                        todayDecoration:
                            BoxDecoration(

                          color: Colors.blue,

                          shape:
                              BoxShape.circle,
                        ),

                        selectedDecoration:
                            BoxDecoration(

                          color: Colors.black,

                          shape:
                              BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Expanded(

                    child:
                        dayAppointments
                                .isEmpty

                            ? const Center(

                                child: Text(

                                  'Nenhum agendamento',

                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              )

                            : ListView.builder(

                                itemCount:
                                    dayAppointments
                                        .length,

                                itemBuilder:
                                    (
                                      context,
                                      index,
                                    ) {

                                  final appt =
                                      dayAppointments[
                                          index];

                                  final startAt =
                                      DateTime.parse(
                                    appt['start_at'],
                                  );

                                  return Container(

                                    margin:
                                        const EdgeInsets
                                            .only(
                                      bottom: 16,
                                    ),

                                    padding:
                                        const EdgeInsets
                                            .all(
                                      20,
                                    ),

                                    decoration:
                                        BoxDecoration(

                                      color: Colors
                                          .blue
                                          .shade50,

                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        20,
                                      ),

                                      boxShadow: [

                                        BoxShadow(

                                          color: Colors
                                              .black
                                              .withValues(
                                            alpha: 0.05,
                                          ),

                                          blurRadius:
                                              10,
                                        ),
                                      ],
                                    ),

                                    child: Column(

                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [

                                        Text(

                                          appt[
                                              'customer_name'],

                                          style:
                                              const TextStyle(

                                            fontSize:
                                                22,

                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 12,
                                        ),

                                        Row(

                                          children: [

                                            const Icon(
                                              Icons.phone,
                                              size: 18,
                                            ),

                                            const SizedBox(
                                              width: 8,
                                            ),

                                            Text(
                                              appt[
                                                  'customer_phone'],
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(

                                          children: [

                                            const Icon(
                                              Icons.attach_money,
                                              size: 18,
                                            ),

                                            const SizedBox(
                                              width: 8,
                                            ),

                                            Text(
                                              'R\$ ${appt['price']}',
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(

                                          children: [

                                            const Icon(
                                              Icons.access_time,
                                              size: 18,
                                            ),

                                            const SizedBox(
                                              width: 8,
                                            ),

                                            Text(

                                              '${startAt.hour.toString().padLeft(2, '0')}:'
                                              '${startAt.minute.toString().padLeft(2, '0')}',
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 16,
                                        ),

                                        Container(

                                          padding:
                                              const EdgeInsets
                                                  .symmetric(

                                            horizontal: 14,

                                            vertical: 8,
                                          ),

                                          decoration:
                                              BoxDecoration(

                                            color:
                                                getStatusColor(
                                              appt['status'],
                                            ),

                                            borderRadius:
                                                BorderRadius
                                                    .circular(
                                              30,
                                            ),
                                          ),

                                          child: Text(

                                            appt['status']
                                                .toString()
                                                .toUpperCase(),

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