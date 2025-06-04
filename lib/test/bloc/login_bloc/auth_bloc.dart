
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';





class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthBloc():super(AuthInitial()){
    on<LoginBtnTapped>((event, emit) async {
      emit(AuthLoading()); // ✅ Emit loading state

      await Future.delayed(Duration(seconds: 2));

      if (event.email == "test@gmail.com" && event.password == "123456") {
        emit(AuthSuccess());
      } else {
        emit(AuthError("Invalid credentials"));
      }
    });
    
    
    on<ToggleEvent>((event, emit) {
      final currentToggle = state is ToggleState ? (state as ToggleState).isToggle : false;
      emit(ToggleState(!currentToggle));
    });






  }
}