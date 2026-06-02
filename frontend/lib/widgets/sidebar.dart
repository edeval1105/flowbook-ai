import 'package:flutter/material.dart';

import '../dashboard_screen.dart';
import '../calendar_screen.dart';

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