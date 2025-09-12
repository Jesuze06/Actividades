import 'package:flutter/material.dart';
import '../../../models/user.dart';

class SuccessWidget extends StatelessWidget {
  final List<User> users;

  const SuccessWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 247, 193, 44), // Amarillo fuerte
            Color.fromARGB(255, 248, 148, 18), // Naranja
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            color: Colors.white, // Card limpio sobre el fondo naranja/amarillo
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Encabezado con avatar e ID
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor:
                            const Color.fromARGB(255, 248, 148, 18)
                                .withOpacity(0.2),
                        child: const Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 248, 148, 18),
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        "ID: ${user.id ?? ''}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 248, 148, 18),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Nombre del usuario
                  Text(
                    user.name ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Email
                  Row(
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        color: Colors.black54,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          user.email ?? '',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
