import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/application/blocs/bottom_nav/nav_bloc.dart';
import 'package:tool_nest/application/blocs/bottom_nav/nav_event.dart';
import 'package:tool_nest/application/blocs/bottom_nav/nav_state.dart';
import 'package:tool_nest/core/constants/sizes.dart';

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
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home" ),
            BottomNavigationBarItem(icon: Icon(LucideIcons.search), label: "Search" ),
            BottomNavigationBarItem(icon: Icon(LucideIcons.penTool), label: "Tools"),
            BottomNavigationBarItem(icon: Icon(LucideIcons.user),label: "Profile"),
          ],
        );
      },
    );
  }
}
