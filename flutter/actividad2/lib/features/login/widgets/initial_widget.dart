import 'package:actividad2/features/login/bloc/login_bloc.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart'; // Importante para el input formatter

class InitialWidget extends StatelessWidget {
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();

  InitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 193, 44),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Icono o logo decorativo
              CircleAvatar(
                radius: 60,
                backgroundColor: const Color.fromARGB(255, 248, 148, 18),
                child: const Icon(Icons.person_pin, size: 80, color: Color.fromARGB(255, 255, 254, 252)),
              ),

              const SizedBox(height: 30),

              // === Caja completa para formulario ===
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                shadowColor: Colors.black26,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        "Crea tu cuenta",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 248, 148, 18),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Ingresa tus datos para continuar",
                        style: TextStyle(color: const Color.fromARGB(255, 248, 148, 18)),
                      ),
                      const SizedBox(height: 32),

                      // Campo Cédula
                      _buildInput(
                        controller: cedulaController,
                        label: "Cédula", 
                        icon: Icons.badge,
                        isNumber: true,
                      ),
                      const SizedBox(height: 20),

                      // Campo Nombre
                      _buildInput(
                        controller: nombreController,
                        label: "Nombre",
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color.fromARGB(255, 248, 148, 18), Color.fromARGB(255, 248, 148, 18)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              final cedulaText = cedulaController.text.trim();
                              final nombre = nombreController.text.trim();

                              if (cedulaText.isEmpty || nombre.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Todos los campos son obligatorios')),
                                );
                                return;
                              }

                              if (cedulaText.length < 8 || nombre.length < 3) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Por favor ingrese datos válidos")),
                                );
                                return;
                              }

                              final cedula = int.tryParse(cedulaText) ?? 0;
                              context.read<LoginBloc>().add(
                                  CreateUserEvent(cedula: cedula, nombre: nombre));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: const Text(
                              "Crear Usuario",
                              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isNumber = false,
  }) {
    return TextField(
      maxLength: isNumber ? 10 : null,
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumber ? [FilteringTextInputFormatter.digitsOnly] : [], // se restringe a números
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
        labelText: label,
        filled: true,
        fillColor: const Color.fromARGB(255, 248, 148, 18), // Diferente del card
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
