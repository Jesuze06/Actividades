import 'package:flutter/material.dart';

class UserinfoInitial extends StatelessWidget {
  const UserinfoInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child:Text("Tareas: estado inicial"),
      ),
    );
  }
}