import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_bloc.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_event.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_state.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/button_with_style/two_action_buttons.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/dropdownButtonSelectionUsingBottomSheets.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/loader/processing_screen.dart';
import 'package:tool_nest/presentation/widgets/loader/progress_indicator_for_all.dart';

class ImageCompressorSettings extends StatefulWidget {
  const ImageCompressorSettings({super.key});

  @override
  State<ImageCompressorSettings> createState() => _ImageCompressorSettingsState();
}

class _ImageCompressorSettingsState extends State<ImageCompressorSettings> {
  bool isProcessingDialogShown = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<ImageCompressorBloc>();

    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.imageCompressorSettings,
        isLeadingIcon: true,
      ),
      backgroundColor: TNColors.primaryBackground,
      body: SafeArea(
        child: BlocConsumer<ImageCompressorBloc, ImageCompressorState>(
          listener: (context, state) {
            if (state is ImageCompressionInProgress && !isProcessingDialogShown) {
              isProcessingDialogShown = true;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => ProgressIndicatorForAll(),
              );
            }

            if (state is ImageCompressionSuccess) {
              if (isProcessingDialogShown) {
                Navigator.of(context, rootNavigator: true).pop();
                isProcessingDialogShown = false;
              }
              context.pushNamed(AppRoutes.imageCompressorResult, extra: state);
            }

            if (state is ImageCompressorError) {
              if (isProcessingDialogShown) {
                Navigator.of(context, rootNavigator: true).pop();
                isProcessingDialogShown = false;
              }
              SnackbarHelper.showError(context, state.message);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: TNPaddingStyle.allPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Text(
                    TNTextStrings.imageCompressorSettings,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: TNColors.textPrimary,
                    ),
                  ),
                  const Gap(TNSizes.spaceMD),

                  /// Quality Slider
                  Text(
                    '${TNTextStrings.compressionQuality}: ${state.quality.toInt()}%',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: TNColors.textSecondary,
                    ),
                  ),
                  Slider(
                    value: state.quality,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    activeColor: TNColors.primary,
                    onChanged: (value) {
                      bloc.add(UpdateCompressionSettings(
                        quality: value,
                        format: state.format,
                        resolution: state.resolution,
                      ));
                    },
                  ),

                  const Gap(TNSizes.spaceMD),

                  /// Format Selection
                  DropdownButtonSelectionUsingBottomSheets(
                    titleForBottomSheet: TNTextStrings.selectImgFormat,
                    titleOfTheSection: TNTextStrings.saveAsTitle,
                    selectedItem: state.format,
                    options: const ['JPG', 'JPEG', 'PNG'],
                    onSelect: (value) {
                      bloc.add(UpdateCompressionSettings(
                        quality: state.quality,
                        format: value,
                        resolution: state.resolution,
                      ));
                    },
                  ),

                  const Gap(TNSizes.spaceLG),

                  /// Resolution Selection
                  DropdownButtonSelectionUsingBottomSheets(
                    titleForBottomSheet: TNTextStrings.selectImgResolution,
                    titleOfTheSection: TNTextStrings.resolution,
                    selectedItem: state.resolution,
                    options: const ['original', 'high', 'medium', 'low'],
                    onSelect: (value) {
                      bloc.add(UpdateCompressionSettings(
                        quality: state.quality,
                        format: state.format,
                        resolution: value,
                      ));
                    },
                  ),

                  const Gap(TNSizes.spaceLG),

                  /// Reset Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => bloc.add(ResetCompressionSettings()),
                      icon: const Icon(LucideIcons.refreshCw, size: 18),
                      label: Text(
                        TNTextStrings.restButton,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: TNColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const Gap(TNSizes.spaceXL),

                  /// Action Buttons
                  ProcessButton(
                        onPressed: () {
                      bloc.add(CompressImageNow());
                    },
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
