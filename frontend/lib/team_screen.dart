import 'package:flutter/material.dart';

class TeamScreen
    extends StatelessWidget {

  const TeamScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final members = [

      {
        'name': 'Edeval Oliveira',
        'role': 'Administrador',
        'icon': Icons.admin_panel_settings,
        'color': Colors.red,
      },

      {
        'name': 'Maria Souza',
        'role': 'Recepcionista',
        'icon': Icons.support_agent,
        'color': Colors.blue,
      },

      {
        'name': 'Carlos Lima',
        'role': 'Funcionário',
        'icon': Icons.person,
        'color': Colors.green,
      },
    ];

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Equipe',
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: () {

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(

            const SnackBar(

              content: Text(
                'Adicionar usuário em breve',
              ),
            ),
          );
        },

        child: const Icon(
          Icons.add,
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: ListView.builder(

          itemCount:
              members.length,

          itemBuilder:
              (context, index) {

            final member =
                members[index];

            return Container(

              margin:
                  const EdgeInsets.only(
                bottom: 16,
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

              child: ListTile(

                contentPadding:
                    const EdgeInsets.all(
                  20,
                ),

                leading: CircleAvatar(

                  radius: 28,

                  backgroundColor:
                      member['color']
                          as Color,

                  child: Icon(

                    member['icon']
                        as IconData,

                    color: Colors.white,
                  ),
                ),

                title: Text(

                  member['name']
                      .toString(),

                  style:
                      const TextStyle(

                    fontWeight:
                        FontWeight.bold,

                    fontSize: 18,
                  ),
                ),

                subtitle: Padding(

                  padding:
                      const EdgeInsets.only(
                    top: 8,
                  ),

                  child: Text(
                    member['role']
                        .toString(),
                  ),
                ),

                trailing: PopupMenuButton(

                  itemBuilder:
                      (context) => [

                    const PopupMenuItem(

                      value: 'edit',

                      child: Text(
                        'Editar',
                      ),
                    ),

                    const PopupMenuItem(

                      value: 'permissions',

                      child: Text(
                        'Permissões',
                      ),
                    ),

                    const PopupMenuItem(

                      value: 'remove',

                      child: Text(
                        'Remover',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}