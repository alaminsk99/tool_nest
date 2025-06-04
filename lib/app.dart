import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tool_nest/application/blocs/bottom_nav/nav_bloc.dart';
import 'package:tool_nest/config/theme/theme.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/main_page.dart';
import 'package:tool_nest/test/bloc/CounterBloc/counter_bloc.dart';
import 'package:tool_nest/test/bloc/login_bloc/auth_bloc.dart';
import 'package:tool_nest/test/bloc/theme_changer_bloc/theme_bloc.dart'; // 👈 create this if you haven’t

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBloc>(create: (_) => NavBloc(),),
        BlocProvider<CounterBloc>(create: (_) => CounterBloc(),),
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc(),),
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(),),
      ],
      child: MaterialApp(
        title: TNTextStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: TNTheme.lightTheme,
        home:const MainNavigationPage(),

      ),
    );
  }
}
