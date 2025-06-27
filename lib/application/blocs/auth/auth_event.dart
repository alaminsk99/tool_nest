
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class SignInRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}

class UserAuthenticated extends AuthEvent {
  final User user;
  UserAuthenticated(this.user);
}

class UserUnauthenticated extends AuthEvent {}