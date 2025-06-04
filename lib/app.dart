import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tool_nest/application/blocs/bottom_nav/nav_bloc.dart';
import 'package:tool_nest/config/theme/theme.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/main_page.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBloc>(create: (_) => NavBloc(),),

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
