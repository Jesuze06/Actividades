import 'dart:convert';

import 'package:actividad2/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'inicio_state.dart';

class InicioCubit extends Cubit<InicioState> {
  InicioCubit() : super(InicioLoading());

  Future<void> fetchUsers() async {
    emit(InicioLoading());
    try {
      final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      if (response.statusCode != 200) {
        emit(InicioError());
        return;
      }

      if (jsonDecode(response.body) is! List) {
        emit(InicioError());
        return;
      }

      final List<User> decode = (jsonDecode(response.body) as List)
          .map((e) => User.fromJson(e))
          .toList();
      
      emit(InicioSuccess(users: decode));
    } catch (e) {
      emit(InicioError());
    }
  }
}
