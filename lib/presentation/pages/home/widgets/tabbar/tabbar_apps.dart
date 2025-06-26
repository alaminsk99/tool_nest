import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:tool_nest/application/blocs/home/home_page_bloc.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/presentation/pages/home/widgets/tabbar/recent_tabs.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';

class TabSection extends StatefulWidget {
  const TabSection({super.key});

  @override
  State<TabSection> createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = [
    RecentTabs.downloads,
    RecentTabs.processed,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context.read<HomePageBloc>().add(
          ChangeRecentTabEvent(tabs[_tabController.index]),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        final activeTab = (state is HomeLoaded) ? state.activeTab : RecentTabs.downloads;

        // Sync tab controller index with state
        final index = tabs.indexOf(activeTab);
        if (_tabController.index != index) {
          _tabController.animateTo(index);
        }

        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: TNColors.white,
            unselectedLabelColor: TNColors.textPrimary,
            dividerHeight: 0,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            indicator: RectangularIndicator(
              color: TNColors.primary,
              topLeftRadius: 10,
              topRightRadius: 10,
              bottomLeftRadius: 10,
              bottomRightRadius: 10,
              paintingStyle: PaintingStyle.fill,
            ),
            indicatorColor: Colors.transparent, // Make sure no default line shows
            indicatorWeight: 0.0001, // Avoid Flutter fallback to underline
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            tabs: tabs
                .map(
                  (label) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(label),
              ),
            )
                .toList(),
          ),
        );

      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
