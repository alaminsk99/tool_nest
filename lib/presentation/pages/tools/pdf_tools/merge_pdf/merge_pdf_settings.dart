import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toolest/application/blocs/pdf_tools/merge_pdfs/merge_pdf_bloc.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';

class MergePdfSettings extends StatefulWidget {
  const MergePdfSettings({super.key});

  @override
  State<MergePdfSettings> createState() => _MergePdfSettingsState();
}

class _MergePdfSettingsState extends State<MergePdfSettings> {
  double _spacing = 0;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MergePdfBloc>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.mergePdfSettings,
        isLeadingIcon: true,
      ),
      backgroundColor: TNColors.primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: TNPaddingStyle.allPaddingLG,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TNTextStrings.adjSpaceBetweenPages,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: TNColors.textPrimary,
                ),
              ),
              const SizedBox(height: TNSizes.spaceMD),
              Text(
                TNTextStrings.mergePdfTitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: TNColors.textSecondary,
                ),
              ),
              const SizedBox(height: TNSizes.spaceXL),

              // Preview Box
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: TNColors.white,
                  borderRadius: BorderRadius.circular(TNSizes.borderRadiusLG),
                  boxShadow: [
                    BoxShadow(
                      color: TNColors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  '${_spacing.toInt()} pt spacing',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: TNColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: TNSizes.spaceXL),

              // Slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: TNColors.primary,
                  inactiveTrackColor: TNColors.primary.withOpacity(0.3),
                  thumbColor: TNColors.primary,
                  overlayColor: TNColors.primary.withOpacity(0.2),
                  trackHeight: 4,
                ),
                child: Slider(
                  min: 0,
                  max: 72,
                  divisions: 12,
                  value: _spacing,
                  onChanged: (v) => setState(() => _spacing = v),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("0 pt", style: TextStyle(fontSize: 12)),
                    Text("72 pt", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),

              const Spacer(),

              // Process Button
              ProcessButton(
                text: TNTextStrings.pdfMergeNowButtonText,
                onPressed: () {
                  bloc.add(UpdateSettings(_spacing.toInt()));
                  bloc.add(MergeRequested(context: context));
                  context.pushNamed(AppRoutes.mergePdfResult);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
