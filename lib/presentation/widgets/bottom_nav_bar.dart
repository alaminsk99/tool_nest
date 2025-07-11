import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/application/blocs/bottom_nav/nav_bloc.dart';
import 'package:toolest/application/blocs/bottom_nav/nav_event.dart';
import 'package:toolest/application/blocs/bottom_nav/nav_state.dart';
import 'package:toolest/core/constants/sizes.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.selectedIndex,
          onTap: (index) => context.read<NavBloc>().add(NavItemSelected(index)),
          elevation: 0,
          iconSize: TNSizes.iconSizeMD,
          

          items: const [
            BottomNavigationBarItem(icon: Icon(LucideIcons.house),label: "Home" ),
            BottomNavigationBarItem(icon: Icon(LucideIcons.wrench), label: "Tools"),
            BottomNavigationBarItem(icon: Icon(LucideIcons.settings),label: "Settings"),
          ],
        );
      },
    );
  }
}
