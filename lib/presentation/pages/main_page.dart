import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tool_nest/application/blocs/bottom_nav/nav_bloc.dart';
import 'package:tool_nest/application/blocs/bottom_nav/nav_state.dart';
import 'package:tool_nest/presentation/pages/home/home_page.dart';
import 'package:tool_nest/presentation/pages/profile/profile_page.dart';
import 'package:tool_nest/presentation/pages/search/search_pages.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_page.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_result.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/image_to_pdf_settings.dart';
import 'package:tool_nest/presentation/pages/tools/image_tools/image_to_pdf/widgets/image_preview_card.dart';
import 'package:tool_nest/presentation/pages/tools/tools_pages.dart';
import 'package:tool_nest/presentation/widgets/bottom_nav_bar.dart';

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
              SearchPages(),
              ToolsPages(),
              const ProfilePage(),
            ],
          ),
          bottomNavigationBar: BottomNavBar(),
        );
      },
    );
  }
}
