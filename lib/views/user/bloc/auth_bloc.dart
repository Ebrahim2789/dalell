import 'package:dalell/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Static user data for demo
  final List<User> _users = [
    User(email: 'admin@example.com', password: 'admin123', role: 'admin'),
    User(email: 'user@example.com', password: 'user123', role: 'user'),
  ];

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    final user = _users.firstWhere(
      (user) => user.email == event.email && user.password == event.password,
      orElse: () => User(email: '', password: '', role: ''),
    );

    if (user.email.isNotEmpty) {
      // Save user email to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', user.email);
      emit(AuthAuthenticated(user));
    } else {
      emit(const AuthError('Invalid email or password'));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    // Clear SharedPreferences on logout
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    emit(AuthInitial());
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1)); // Simulate check

    // Check SharedPreferences for saved user
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('user_email');

    if (email != null) {
      final user = _users.firstWhere(
        (user) => user.email == email,
        orElse: () => User(email: '', password: '', role: ''),
      );
      if (user.email.isNotEmpty) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthInitial());
      }
    } else {
      emit(AuthInitial());
    }
  }
}

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}
void checkLogin() async {
  bool loggedIn = await isLoggedIn();
  if (loggedIn) { 
     

  BlocListener<AuthBloc, AuthState>(listener: (context, state) {

    if (state is AuthAuthenticated) {
      if (state.user.role == 'admin') {
        Navigator.pushReplacementNamed(context, RouteGenerator.marchentPages);
      } else {
        Navigator.pushReplacementNamed(context, RouteGenerator.homePages);
      }
    } else if (state is AuthInitial) {
      Navigator.pushReplacementNamed(context, RouteGenerator.login);
    }
  });
}}
