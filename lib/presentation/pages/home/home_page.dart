import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/application/blocs/home/home_page_bloc.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/home/widgets/appbar/home_appbar.dart';
import 'package:toolest/presentation/pages/home/widgets/card/tool_card.dart';
import 'package:toolest/presentation/pages/home/widgets/scroll/recent_files_scroll.dart';
import 'package:toolest/presentation/pages/home/widgets/tabbar/tabbar_apps.dart';

import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/custom_shapes/container/background_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);


    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomePageBloc>().add(LoadRecentFilesEvent());
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<HomePageBloc>().add(LoadRecentFilesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundContainer(),
          Column(
            children: [
              const HomeAppbar(),

              Expanded(
                child: SingleChildScrollView(
                  padding: TNPaddingStyle.allPadding,
                  physics: const PageScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(TNSizes.spaceBetweenSections),

                      /// Recent Files Title
                      Padding(
                        padding: TNPaddingStyle.onlyLeftMD,
                        child: Text(
                          TNTextStrings.recentFiles,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: TNColors.textPrimary,
                          ),
                        ),
                      ),

                      Gap(TNSizes.spaceBetweenSections),

                      /// Tabs
                      TabSection(),

                      Gap(TNSizes.spaceBetweenSections),

                      /// Recent Files Horizontal Scroll
                      RecentFilesScroll(),


                      Gap(TNSizes.spaceBetweenSections * 1.3),

                      ///
                      StaticContainer(),
                      Gap(TNSizes.spaceBetweenSections),
                      /// Image Tools Section
                      _sectionTitle(TNTextStrings.featured, context),
                      Gap(TNSizes.spaceBetweenItems),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,

                        clipBehavior: Clip.antiAlias,
                        children: [
                          ToolCard(
                            title: TNTextStrings.pdfToImage,
                            icon: LucideIcons.image,
                            color: Colors.orange,
                            onTap: () => context.goNamed(AppRoutes.pdfToImage),
                            subtitle: 'Convert PDFs',
                          ),
                          ToolCard(
                            title: TNTextStrings.imageResizer,
                            icon: LucideIcons.minimize,
                            color: Colors.teal,
                            onTap: () =>
                                context.goNamed(AppRoutes.imageResize),
                            subtitle: 'Adjust dimensions',
                          ),
                          ToolCard(
                            title: TNTextStrings.mergePDFs,
                            icon: LucideIcons.arrowRightLeft,
                            color: Colors.purple,
                            onTap: () => context.goNamed(AppRoutes.mergePdf),
                            subtitle: 'Combine PDFs',
                          ),
                        ],
                      ),
                      Gap(TNSizes.spaceBetweenSections * 1.3),

                      /// PDF Tools Section
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: Theme
          .of(context)
          .textTheme
          .titleLarge
          ?.copyWith(
        fontWeight: FontWeight.bold,
        color: TNColors.textPrimary,
      ),
    );
  }


}

class StaticContainer extends StatelessWidget {
  const StaticContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TNPaddingStyle.allPaddingLG,
      decoration: BoxDecoration(
        border: Border.all(color: TNColors.specialGreenColor),
        borderRadius: BorderRadius.circular(TNSizes.borderRadiusMD),
        gradient:TNColors.specialGreenGradientVeriasion,

      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Activity',style: Theme
              .of(context)
              .textTheme
              .titleLarge
              ?.copyWith(
            fontWeight: FontWeight.bold,
            color: TNColors.textPrimary,
            fontSize: 25,
          ),),
          Gap(TNSizes.spaceBetweenItems),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: TNColors.grey,
                  shape: BoxShape.circle,
                    border: Border.all(color: TNColors.white.withOpacity(0.7)),
                ),
                child: Center(child: Text('8',style: Theme.of(context).textTheme.headlineLarge?.copyWith(),)),
              ),

              Text('File Processed today',style: Theme.of(context).textTheme.bodyMedium,),

              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: TNColors.grey.withOpacity(0.5),
                    shape: BoxShape.circle,
                    border: Border.all(color: TNColors.cusClipperBack.withOpacity(0.7))
                  ),
                  child: Center(child: Icon(LucideIcons.file,size: 30,color: TNColors.textWhite,))),
            ],
          ),
        ],
      ),
    );
  }
}