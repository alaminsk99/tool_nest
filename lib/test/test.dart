import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tool_nest/test/bloc/theme_changer_bloc/theme_bloc.dart';
import 'package:tool_nest/test/bloc/theme_changer_bloc/theme_state.dart';

import 'bloc/CounterBloc/counter_bloc.dart';
import 'bloc/CounterBloc/counter_event.dart';
import 'bloc/CounterBloc/counter_state.dart';
import 'bloc/theme_changer_bloc/theme_event.dart';


class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc,ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: state.isDark? Colors.blueAccent: Colors.white,
          appBar: AppBar(title: Text('Counter with BLoC')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              Center(
                child: Text('Count: 0', style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'increment',
                onPressed: () => context.read<ThemeBloc>().add(IsBlackTheme()),
                child: Icon(Icons.add),
              ),
              // SizedBox(height: 10),
              // FloatingActionButton(
              //   heroTag: 'decrement',
              //   onPressed: () => context.read<CounterBloc>().add(Decrement()),
              //   child: Icon(Icons.remove),
              // ),
            ],
          ),
        );
      }
    );
  }
}
