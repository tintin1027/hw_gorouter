import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

enum AuthStatus { loggedIn, loggedOut }

class AuthState extends Equatable {
  final AuthStatus status;
  const AuthState(this.status);
  @override
  List<Object?> get props => [status];
}

abstract class AuthEvent {}
class AuthLoginRequested extends AuthEvent {}
class AuthLogoutRequested extends AuthEvent {}

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  AuthenticationBloc() : super(const AuthState(AuthStatus.loggedOut)) {
    on<AuthLoginRequested>((_, emit) => emit(const AuthState(AuthStatus.loggedIn)));
    on<AuthLogoutRequested>((_, emit) => emit(const AuthState(AuthStatus.loggedOut)));
  }
}
