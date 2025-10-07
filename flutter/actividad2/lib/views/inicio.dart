import 'package:actividad2/features/inicio/cubit/inicio_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/inicio/incio.dart';

class HomeView extends StatelessWidget {
  final String nombre;
  const HomeView({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'goku.jpg',
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Texto de bienvenida
            Text(
              'Bienvenido $nombre',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Aquí la info ocupa el resto y se puede scrollear
            Expanded(
              child: BlocProvider(
                create: (context) => InicioCubit()..fetchUsers(),
                child: HomeContainer(nombre: nombre),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
