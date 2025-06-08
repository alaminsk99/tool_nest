import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tool_nest/application/blocs/bottom_nav/nav_bloc.dart';
import 'package:tool_nest/config/theme/theme.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/main_page.dart';

import 'application/blocs/image_tools/image_to_pdf/image_to_pdf_bloc.dart';
import 'config/router/app_router.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBloc>(create: (_) => NavBloc(),),
        BlocProvider<ImageToPdfBloc>(create: (_) => ImageToPdfBloc(),),

      ],
      child: MaterialApp.router(
        title: TNTextStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: TNTheme.lightTheme,
        routerConfig: appRouter,

      ),
    );
  }
}
