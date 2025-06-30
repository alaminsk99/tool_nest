import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:toolest/application/blocs/home/home_page_bloc.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/presentation/pages/home/widgets/tabbar/recent_tabs.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';

class TabSection extends StatefulWidget {
  const TabSection({super.key});

  @override
  State<TabSection> createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = [RecentTabs.downloads, RecentTabs.processed];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // User triggered change → notify Bloc
        context.read<HomePageBloc>().add(
          ChangeRecentTabEvent(tabs[_tabController.index]),
        );
      }
    });
  }

  @override
  void didUpdateWidget(covariant TabSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncTabWithState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Also call here to ensure tab sync on first build
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncTabWithState());
  }

  void _syncTabWithState() {
    final state = context.read<HomePageBloc>().state;
    if (state is HomeLoaded) {
      final blocIndex = tabs.indexOf(state.activeTab);
      if (_tabController.index != blocIndex && !_tabController.indexIsChanging) {
        _tabController.animateTo(blocIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
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
            indicatorColor: Colors.transparent,
            indicatorWeight: 0.0001,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            tabs: tabs
                .map((label) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(label),
            ))
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

