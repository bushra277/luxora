import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_flutter/features/auth/service/auth_service.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final User? user;
  AuthSuccess({this.user});
  @override
  List<Object?> get props => [user];
}
class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
  @override
  List<Object?> get props => [message];
}

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  AuthCubit(this._authService) : super(AuthInitial());

  Future<void> login({
  required String email,
  required String password,
}) async {
  emit(AuthLoading());
  try {
    final user = await _authService.login(
      email: email,
      password: password,
    );
    emit(AuthSuccess(user: user)); // هذا الحدث يخبر الـ UI بالنجاح
  } catch (e) {
    emit(AuthError(message: e.toString()));
  }
}

Future<void> register({
  required String name,
  required String email,
  required String password,
}) async {
  emit(AuthLoading());
  try {
    final user = await _authService.register(
      name: name,
      email: email,
      password: password,
    );
    emit(AuthSuccess(user: user)); 
  } catch (e) {
    emit(AuthError(message: e.toString()));
  }
}

}



