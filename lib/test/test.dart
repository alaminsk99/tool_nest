import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tool_nest/test/bloc/login_bloc/auth_event.dart';
import 'package:tool_nest/test/bloc/login_bloc/auth_state.dart';
import 'package:tool_nest/test/bloc/theme_changer_bloc/theme_bloc.dart';
import 'package:tool_nest/test/bloc/theme_changer_bloc/theme_state.dart';

import 'bloc/CounterBloc/counter_bloc.dart';
import 'bloc/CounterBloc/counter_event.dart';
import 'bloc/CounterBloc/counter_state.dart';
import 'bloc/login_bloc/auth_bloc.dart';
import 'bloc/theme_changer_bloc/theme_event.dart';


class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final emailEditingController = TextEditingController();

  final passwordEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login Success")),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Counter with BLoC')),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailEditingController,
                    decoration: InputDecoration(labelText: "Email"),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Enter email' : null,
                  ),
                  TextFormField(
                    controller: passwordEditingController,
                    decoration: InputDecoration(
                        labelText: "Password",
                      suffixIcon: IconButton(
                    icon: Icon(
                    state is ToggleState && state.isToggle ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(ToggleEvent());
                    },
                  ),
                    ),
                    obscureText:  state is ToggleState ? (state as ToggleState).isToggle : true,

                    validator: (value) =>
                    value == null || value.isEmpty ? 'Enter password' : null,

                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          LoginBtnTapped(
                            emailEditingController.text,
                            passwordEditingController.text,
                          ),
                        );
                      }
                    },
                    child: state is AuthLoading
                        ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                        strokeWidth: 2,
                      ),
                    )
                        : Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
