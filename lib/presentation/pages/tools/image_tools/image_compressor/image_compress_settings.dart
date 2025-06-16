import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_bloc.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_event.dart';
import 'package:tool_nest/application/blocs/image_tools/image_compressor/image_compressor_state.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/button_with_style/two_action_buttons.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/dropdownButtonSelectionUsingBottomSheets.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/loader/processing_screen.dart';

class ImageCompressorSettings extends StatefulWidget {
  const ImageCompressorSettings({super.key});

  @override
  State<ImageCompressorSettings> createState() => _ImageCompressorSettingsState();
}


class _ImageCompressorSettingsState extends State<ImageCompressorSettings> {
  @override
  Widget build(BuildContext context) {
    bool  isProcessingDialogShown = false;
    final bloc = context.read<ImageCompressorBloc>();

    return Scaffold(
      // ... (appbar)
      appBar: AppbarForMainSections(title: TNTextStrings.imageCompressorSettings, isLeadingIcon: true),
      body: SafeArea(
        child: BlocConsumer<ImageCompressorBloc, ImageCompressorState>(
          listener: (context, state) {
            if (state is ImageCompressionInProgress && !isProcessingDialogShown) {
              isProcessingDialogShown = true;

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const ProcessingScreen(
                  title: TNTextStrings.compressingImage,
                  warningMessage: TNTextStrings.pleWaitWhileCompressing,
                ),
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
                  // Compression quality slider
                  Text(TNTextStrings.compressionQuality, style: Theme.of(context).textTheme.bodyLarge),
                  Slider(
                    value: state.quality,
                    min: 0,
                    max: 100,
                    onChanged: (value) => bloc.add(UpdateCompressionSettings(
                      quality: value,
                      format: state.format,
                      resolution: state.resolution,
                    )),
                  ),

                  // Format dropdown
                  Dropdownbuttonselectionusingbottomsheets(
                    titleForBottomSheet: TNTextStrings.selectImgFormat,
                    titleOfTheSection: TNTextStrings.saveAsTitle,
                    selectedItem: state.format,
                    options:  const ['JPG', 'JPEG', 'PNG'],
                    onSelect: (value) => bloc.add(UpdateCompressionSettings(
                      quality: state.quality,
                      format: value,
                      resolution: state.resolution,
                    )),
                  ),

                  // Resolution dropdown
                  Dropdownbuttonselectionusingbottomsheets(
                    titleForBottomSheet: TNTextStrings.selectImgResolution,
                    titleOfTheSection: TNTextStrings.resolution,
                    selectedItem: state.resolution,
                    options: const ['original', 'high', 'medium', 'low'],
                    onSelect: (value) => bloc.add(UpdateCompressionSettings(
                      quality: state.quality,
                      format: state.format,
                      resolution: value,
                    )),
                  ),

                  // Reset button
                  TextButton(
                    onPressed: () => bloc.add(ResetCompressionSettings()),
                    child: Text(TNTextStrings.restButton),
                  ),

                  // Action buttons
                  TwoActionButtons(
                    title1: TNTextStrings.back,
                    icon1: LucideIcons.chevronLeft,
                    onPressed1: () => Navigator.pop(context),
                    title2: TNTextStrings.compressNowButtonTit,
                    onPressed2: () => bloc.add(CompressImageNow()),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}