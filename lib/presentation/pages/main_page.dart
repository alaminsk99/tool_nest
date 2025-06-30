import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolest/application/blocs/bottom_nav/nav_bloc.dart';
import 'package:toolest/application/blocs/bottom_nav/nav_state.dart';
import 'package:toolest/presentation/pages/home/home_page.dart';
import 'package:toolest/presentation/pages/settings/settings_page.dart';

import 'package:toolest/presentation/pages/tools/tools_pages.dart';
import 'package:toolest/presentation/widgets/bottom_nav_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: [
              const HomePage(),
              ToolsPages(),
              const SettingsPage(),
            ],
          ),
          bottomNavigationBar: BottomNavBar(),
        );
      },
    );
  }
}
