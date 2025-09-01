import 'package:flutter/material.dart';
import 'package:mi_app/user/user_error.dart';
import 'package:mi_app/user/user_initial.dart';
import 'package:mi_app/user/user_loanding.dart';
import 'package:mi_app/user/user_success.dart';
import 'package:mi_app/userinfo/userinfo_error.dart';
import 'package:mi_app/userinfo/userinfo_initial.dart';
import 'package:mi_app/userinfo/userinfo_loanding.dart';
import 'package:mi_app/userinfo/userinfo_succes.dart';

enum ViewState { initial, loading, error, success }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ViewState userState = ViewState.initial;
  ViewState taskState = ViewState.initial;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Informacion de tramite")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildUserContainer(),
            const SizedBox(height: 20),
            _buildTaskContainer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Cambiar estados para probar
            userState = ViewState.values[(userState.index + 1) % ViewState.values.length];
            taskState = ViewState.values[(taskState.index + 1) % ViewState.values.length];
          });
        }, 
        child: const Icon(Icons.play_arrow), 
      ),
    );
  }

  Widget _buildUserContainer() {
    switch (userState) {
      case ViewState.initial:
        return const UserInitial();
      case ViewState.loading:
        return const UserLoading();
      case ViewState.success:
        return const UserSuccess();
      case ViewState.error:
        return const UserError();
    }
  }

  Widget _buildTaskContainer() {
    switch (taskState) {
      case ViewState.initial:
        return const UserinfoInitial();
      case ViewState.loading:
        return const UserinfoLoanding();
      case ViewState.success:
        return const UserinfoSucces();
      case ViewState.error:
        return const UserinfoError();
    }
  }
}