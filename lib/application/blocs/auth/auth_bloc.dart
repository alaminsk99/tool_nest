
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tool_nest/domain/models/auth/user_model.dart';
import 'package:tool_nest/domain/repositories/auth_repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<User?> _authSubscription;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    _authSubscription = _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        add(UserAuthenticated(user));
      } else {
        add(UserUnauthenticated());
      }
    });

    on<AppStarted>(_onAppStarted);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<UserAuthenticated>(_onUserAuthenticated);
    on<UserUnauthenticated>(_onUserUnauthenticated);
  }

  Future<void> _onAppStarted(
      AppStarted event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (isLoggedIn) {
        final user = _authRepository.currentUser;
        if (user != null) {
          await _cacheUserData(user);
          emit(Authenticated(AppUser.fromFirebaseUser(user)));
        } else {
          emit(Unauthenticated());
        }
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInRequested(
      SignInRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signInWithGoogle();
      if (user != null) {
        await _cacheUserData(user);
        emit(Authenticated(AppUser.fromFirebaseUser(user)));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      await _authRepository.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onUserAuthenticated(
      UserAuthenticated event,
      Emitter<AuthState> emit,
      ) async {
    await _cacheUserData(event.user);
    emit(Authenticated(AppUser.fromFirebaseUser(event.user)));
  }

  void _onUserUnauthenticated(
      UserUnauthenticated event,
      Emitter<AuthState> emit,
      ) {
    emit(Unauthenticated());
  }

  Future<void> _cacheUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userId', user.uid);
    await prefs.setString('userName', user.displayName ?? '');
    await prefs.setString('userEmail', user.email ?? '');
    await prefs.setString('userPhotoUrl', user.photoURL ?? '');
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}