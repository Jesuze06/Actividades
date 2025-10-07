// ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      emit(LoginInitial());
    });

    on<LoginRetryEvent>((event, emit) async{
      emit(LoginInitial());

    });

    on<CreateUserEvent>((event, emit) async {
      emit(LoginLoading());

      try {
        final response = await http.post(
          Uri.parse("https://jsonplaceholder.typicode.com/posts"),
          body: jsonEncode({
            'name': event.nombre,
            'job': event.cedula,
          }),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 201) {
          print("Usuario creado: ${response.body}");
          final decode = jsonDecode(response.body);
          emit(LoginSuccess(decode['name'] ?? ''));
        } else {
          print("Error: Código de estado ${response.statusCode}");
          emit(LoginFailed());
        }
      } catch (e){
        print(e);
        emit(LoginFailed());
      }

      emit(LoginSuccess(event.nombre));
    });
  }
}