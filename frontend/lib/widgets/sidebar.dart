import 'package:flutter/material.dart';

import '../dashboard_screen.dart';
import '../calendar_screen.dart';
import '../customers_screen.dart';
import '../ai_screen.dart';
import '../notifications_screen.dart';
import '../company_screen.dart';
import '../plans_screen.dart';
import '../reports_screen.dart';
import '../team_screen.dart';

class Sidebar extends StatelessWidget {

  const Sidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: 250,

      color: Colors.black,

      child: Column(

        children: [

          const SizedBox(
            height: 50,
          ),

          const Text(

            'FlowBook AI',

            style: TextStyle(

              color: Colors.white,

              fontSize: 24,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 40,
          ),

          ListTile(

            leading: const Icon(
              Icons.dashboard,
              color: Colors.white,
            ),

            

            title: const Text(

              'Dashboard',

              style: TextStyle(
                color: Colors.white,
              ),
            ),

            

            onTap: () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                      const DashboardScreen(),
                ),
              );
            },
          ),

                            ListTile(

                              leading: const Icon(
                                Icons.people,
                                color: Colors.white,
                              ),

                              title: const Text(

                                'Clientes',

                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),

                              onTap: () {

                                Navigator.push(

                                  context,

                                  MaterialPageRoute(

                                    builder: (_) =>
                                        const CustomersScreen(),
                                  ),
                                );
                              },
                            ),

            ListTile(

              leading: const Icon(
                Icons.psychology,
                color: Colors.white,
              ),

              title: const Text(

                'IA',

                style: TextStyle(
                  color: Colors.white,
                ),
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                        const AiScreen(),
                  ),
                );
              },
            ),
          
          
              ListTile(

                leading: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),

                title: const Text(

                  'Notificações',

                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          const NotificationsScreen(),
                    ),
                  );
                },
              ),
          
              ListTile(

                leading: const Icon(
                  Icons.business,
                  color: Colors.white,
                ),

                title: const Text(

                  'Empresa',

                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          const CompanyScreen(),
                    ),
                  );
                },
              ),

              
               ListTile(

                leading: const Icon(
                  Icons.workspace_premium,
                  color: Colors.white,
                ),

                title: const Text(

                  'Planos',

                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          const PlansScreen(),
                    ),
                  );
                },
              ),

          ListTile(

            leading: const Icon(
              Icons.bar_chart,
              color: Colors.white,
            ),

            title: const Text(

              'Relatórios',

              style: TextStyle(
                color: Colors.white,
              ),
            ),

            onTap: () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                      const ReportsScreen(),
                ),
              );
            },
          ),

        ListTile(

          leading: const Icon(
            Icons.groups,
            color: Colors.white,
          ),

          title: const Text(

            'Equipe',

            style: TextStyle(
              color: Colors.white,
            ),
          ),

          onTap: () {

            Navigator.push(

              context,

              MaterialPageRoute(

                builder: (_) =>
                    const TeamScreen(),
              ),
            );
          },
        ),

          ListTile(

            leading: const Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),

            title: const Text(

              'Calendário',

              style: TextStyle(
                color: Colors.white,
              ),
            ),

            onTap: () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) =>
                      const CalendarScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}