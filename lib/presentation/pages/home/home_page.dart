import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/application/blocs/home/home_page_bloc.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/home/widgets/appbar/home_appbar.dart';
import 'package:tool_nest/presentation/pages/home/widgets/card/tool_card.dart';
import 'package:tool_nest/presentation/pages/home/widgets/scroll/recent_files_scroll.dart';
import 'package:tool_nest/presentation/pages/home/widgets/tabbar/tabbar_apps.dart';

import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/custom_shapes/container/background_container.dart';

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
                  physics:const PageScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(TNSizes.spaceBetweenSections),

                      /// Recent Files Title
                      Padding(
                        padding: TNPaddingStyle.onlyLeftMD,
                        child: Text(
                          TNTextStrings.recentFiles,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
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


                      Gap(TNSizes.spaceBetweenSections *1.3),

                      /// Image Tools Section
                      _sectionTitle(TNTextStrings.imageTools, context),
                      Gap(TNSizes.spaceXS),
                      _toolGrid([
                        ToolCard(title: TNTextStrings.compressImage, icon: LucideIcons.image, color: Colors.orange, onTap:() => context.goNamed(AppRoutes.imageCompressor),),
                        ToolCard(title: TNTextStrings.imageResizer, icon: LucideIcons.minimize, color: Colors.teal, onTap: () => context.goNamed(AppRoutes.imageResize)),
                        ToolCard(title: TNTextStrings.imageToPDF, icon: LucideIcons.fileImage, color: Colors.yellow.shade800, onTap: () => context.goNamed(AppRoutes.imageToPdf)),
                        ToolCard(title: TNTextStrings.formatConverter, icon: LucideIcons.arrowRightLeft, color: Colors.purple, onTap: () => context.goNamed(AppRoutes.imageFormatConverter)),
                      ]),

                      Gap(TNSizes.spaceBetweenSections*1.3 ),

                      /// PDF Tools Section
                      _sectionTitle(TNTextStrings.pdfTools, context),
                      Gap(TNSizes.spaceXS),
                      _toolGrid([
                        ToolCard(title: TNTextStrings.pdfToImage, icon: LucideIcons.image, color: Colors.blue, onTap: ()=> context.goNamed(AppRoutes.pdfToImage)),
                        ToolCard(title: TNTextStrings.mergePDFs, icon: LucideIcons.merge, color: Colors.green, onTap: ()=> context.goNamed(AppRoutes.mergePdf)),
                        ToolCard(title: TNTextStrings.splitPDF, icon: LucideIcons.split, color: Colors.red, onTap: ()=> context.goNamed(AppRoutes.splitPdf)),
                        ToolCard(title: TNTextStrings.compressPDF, icon: LucideIcons.fileAxis3d, color: Colors.indigo, onTap: ()=> context.goNamed(AppRoutes.compressPdf)),
                      ]),
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
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: TNColors.textPrimary,
      ),
    );
  }

  Widget _toolGrid(List<Widget> children) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: TNSizes.spaceSM,
      crossAxisSpacing: TNSizes.spaceSM,
      childAspectRatio: 0.8,
      children: children,
    );
  }
}

