import 'package:actividad2/features/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

class InitialWidget extends StatelessWidget {
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();

  InitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          "Registro de Usuario",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.account_circle,
                        size: 80, color: Colors.orange),
                    const SizedBox(height: 16),

                    Text(
                      "Crea tu cuenta",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Ingresa tus datos para continuar",
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 24),

                    // Campo Cédula
                    _buildInput(
                      controller: cedulaController,
                      label: "Cédula",
                      icon: Icons.badge,
                      isNumber: true,
                    ),
                    const SizedBox(height: 16),

                    // Campo Nombre
                    _buildInput(
                      controller: nombreController,
                      label: "Nombre",
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 24),

                    // Botón
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          final cedulaText = cedulaController.text.trim();
                          final nombre = nombreController.text.trim();

                          if (cedulaText.isEmpty || nombre.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Todos los campos son obligatorios'),
                              ),
                            );
                            return;
                          }

                          if (cedulaText.length < 8 || nombre.length < 3) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Por favor ingrese datos válidos"),
                              ),
                            );
                            return;
                          }

                          final cedula = int.tryParse(cedulaText) ?? 0;
                          context.read<LoginBloc>().add(
                              CreateUserEvent(cedula: cedula, nombre: nombre));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        child: const Text("Crear Usuario"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
      inputFormatters:
          isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.orange[700]),
        labelText: label,
        counterText: "",
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
