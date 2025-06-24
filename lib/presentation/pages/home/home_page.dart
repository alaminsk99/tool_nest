import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/home/widgets/appbar/home_appbar.dart';
import 'package:tool_nest/presentation/pages/home/widgets/card/tool_card.dart';
import 'package:tool_nest/presentation/pages/home/widgets/tabbar/tabbar_apps.dart' show TabButton;
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/custom_shapes/container/background_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  physics: const BouncingScrollPhysics(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          TabButton(label: "Downloads", selected: true),
                          TabButton(label: "Opened"),
                          TabButton(label: "Processed"),
                        ],
                      ),

                      Gap(TNSizes.spaceBetweenSections),

                      /// Recent Files Horizontal Scroll
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Container(
                              width: 140,
                              decoration: BoxDecoration(
                                color: TNColors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: TNColors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(LucideIcons.fileText, color: TNColors.primary, size: 38),
                                  const Gap(12),
                                  Text("Document.pdf", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                                  const Gap(4),
                                  Text("102 KB", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TNColors.textSecondary)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      Gap(TNSizes.spaceBetweenSections * 2),

                      /// Image Tools Section
                      _sectionTitle(TNTextStrings.imageTools, context),
                      Gap(TNSizes.spaceXS),
                      _toolGrid([
                        ToolCard(title: TNTextStrings.compressImage, icon: LucideIcons.image, color: Colors.orange, onTap: () {}),
                        ToolCard(title: TNTextStrings.imageResizer, icon: LucideIcons.image, color: Colors.teal, onTap: () {}),
                        ToolCard(title: TNTextStrings.imageToPDF, icon: LucideIcons.fileImage, color: Colors.yellow.shade800, onTap: () {}),
                        ToolCard(title: TNTextStrings.formatConverter, icon: LucideIcons.arrowRightLeft, color: Colors.purple, onTap: () {}),
                      ]),

                      Gap(TNSizes.spaceBetweenSections * 2),

                      /// PDF Tools Section
                      _sectionTitle(TNTextStrings.pdfTools, context),
                      Gap(TNSizes.spaceXS),
                      _toolGrid([
                        ToolCard(title: TNTextStrings.pdfToImage, icon: LucideIcons.image, color: Colors.blue, onTap: () {}),
                        ToolCard(title: TNTextStrings.mergePDFs, icon: LucideIcons.merge, color: Colors.green, onTap: () {}),
                        ToolCard(title: TNTextStrings.splitPDF, icon: LucideIcons.split, color: Colors.red, onTap: () {}),
                        ToolCard(title: TNTextStrings.compressPDF, icon: LucideIcons.map, color: Colors.indigo, onTap: () {}),
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
      crossAxisCount: 2,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 1.2,
      children: children,
    );
  }

}

