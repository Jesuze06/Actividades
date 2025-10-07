part of 'inicio_cubit.dart';

@immutable
sealed class InicioState {}

final class InicioLoading extends InicioState {}
final class InicioError extends InicioState {}
final class InicioSuccess extends InicioState {
  final List<User> users;
  InicioSuccess({required this.users});

  @override
  Object get props => [users];

}
