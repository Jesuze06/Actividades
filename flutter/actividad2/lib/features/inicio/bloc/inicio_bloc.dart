import 'dart:convert';
import 'dart:developer' as developer; // 👈 en vez de print, para logs
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../../../models/user.dart';

part 'inicio_event.dart';
part 'inicio_state.dart';

class HomeInfoBloc extends Bloc<HomeInfoEvent, HomeInfoState> {
  HomeInfoBloc() : super(HomeInfoInitial()) {
    on<CargarHomeInfo>((event, emit) async {
      emit(HomeInfoLoading());

      try {
        final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/users'),
        );

        if (response.statusCode == 200) {
          final List<dynamic> decode = jsonDecode(response.body); 

          final users = decode
              .whereType<Map<String, dynamic>>()
              .map((e) => User.fromJson(e))
              .toList();

          emit(HomeInfoSuccess(users));
        } else {
          developer.log("Error: Código de estado ${response.statusCode}");
          emit(HomeInfoFailed());
        }
      } catch (e) {
        developer.log("Error al realizar la petición", error: e);
        emit(HomeInfoFailed());
      }
    });

    on<RetryHomeInfo>((event, emit) async {
      emit(HomeInfoLoading());
      add(CargarHomeInfo());
    });
  }
}
