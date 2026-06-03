import 'package:flutter/material.dart';

class CompanyScreen
    extends StatelessWidget {

  const CompanyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Empresa',
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: ListView(

          children: [

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

                children: [

                  CircleAvatar(

                    radius: 50,

                    child: const Icon(

                      Icons.business,

                      size: 50,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Text(

                    'FlowBook Company',

                    style: TextStyle(

                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  const Text(
                    'Plano Premium',
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  Row(

                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceAround,

                    children: [

                      companyStat(

                        'Clientes',

                        '128',
                      ),

                      companyStat(

                        'Agenda',

                        '54',
                      ),

                      companyStat(

                        'Equipe',

                        '6',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            settingsCard(

              context,

              Icons.person,

              'Usuários',

              'Gerenciar equipe',
            ),

            settingsCard(

              context,

              Icons.workspace_premium,

              'Plano',

              'Gerenciar assinatura',
            ),

            settingsCard(

              context,

              Icons.palette,

              'Branding',

              'Logo e identidade',
            ),

            settingsCard(

              context,

              Icons.security,

              'Segurança',

              'Permissões e acesso',
            ),
          ],
        ),
      ),
    );
  }

  Widget companyStat(
    String title,
    String value,
  ) {

    return Column(

      children: [

        Text(

          value,

          style: const TextStyle(

            fontSize: 22,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
          height: 6,
        ),

        Text(title),
      ],
    );
  }

  Widget settingsCard(

    BuildContext context,

    IconData icon,

    String title,

    String subtitle,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 16,
      ),

      child: ListTile(

        contentPadding:
            const EdgeInsets.all(20),

        shape: RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
            20,
          ),
        ),

        tileColor:
            Theme.of(context)
                .cardColor,

        leading: CircleAvatar(

          child: Icon(icon),
        ),

        title: Text(

          title,

          style: const TextStyle(

            fontWeight:
                FontWeight.bold,
          ),
        ),

        subtitle: Text(
          subtitle,
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}