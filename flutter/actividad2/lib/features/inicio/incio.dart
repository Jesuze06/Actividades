import 'package:actividad2/features/inicio/cubit/inicio_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/faild.dart';
import 'widgets/loidng.dart'; 
import 'widgets/success.dart';

class HomeContainer extends StatelessWidget {
  final String nombre;
  const HomeContainer({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InicioCubit, InicioState>(
      builder: (context, state) {
        if (state is InicioLoading) {
          return LoadingWidget();
        } if (state is InicioError) {
          return FailedWidget();
        } if (state is InicioSuccess) {
          return Expanded(child: SuccessWidget(users: state.users));
        }
        
        return Text('Bienvenido $nombre');
      },
    );
  }
}