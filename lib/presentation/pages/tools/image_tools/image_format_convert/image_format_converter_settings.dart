import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tool_nest/application/blocs/image_tools/image_format_converter/image_format_converter_bloc.dart';
import 'package:tool_nest/application/blocs/image_tools/image_format_converter/image_format_converter_event.dart';
import 'package:tool_nest/application/blocs/image_tools/image_format_converter/image_format_converter_state.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/domain/models/image_tools/image_format_converter_model.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/dropdownButtonSelectionUsingBottomSheets.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/loader/progress_indicator_for_all.dart';
import 'package:tool_nest/core/constants/colors.dart';

class ImageFormatConverterSettings extends StatefulWidget {
  const ImageFormatConverterSettings({super.key});

  @override
  State<ImageFormatConverterSettings> createState() =>
      _ImageFormatConverterSettingsState();
}

class _ImageFormatConverterSettingsState
    extends State<ImageFormatConverterSettings> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.imageFormatConverterSettings,
        isLeadingIcon: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: TNPaddingStyle.allPadding,
          child: BlocConsumer<ImageFormatConverterBloc, ImageFormatConverterState>(
            listener: (context, state) {
              if (state is ImageFormatDone) {
                context.goNamed(
                  AppRoutes.imageFormatConverterResult,
                  extra: ImageFormatConverterResultDataModel(
                    convertedBytes: state.convertedBytes,
                    format: state.format,
                  ),
                );
              } else if (state is ImageFormatError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is ImageFormatPickedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// --- Preview Card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: TNColors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selected Image Preview",
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Gap(8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              state.imageBytes,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Gap(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Original Format:",
                                style: theme.textTheme.bodyMedium?.copyWith(color: TNColors.textSecondary),
                              ),
                              Text(
                                state.originalFormat.toUpperCase(),
                                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Gap(TNSizes.spaceXL),

                    /// --- Format Dropdown
                    Text(
                      "Convert to",
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Gap(TNSizes.spaceXS),
                    DropdownButtonSelectionUsingBottomSheets(
                      titleForBottomSheet: TNTextStrings.imageSelectFormat,
                      titleOfTheSection: "Select Target Format",
                      selectedItem: state.currentFormat.toUpperCase(),
                      options: const ['JPG', 'JPEG', 'PNG'],
                      onSelect: (value) {
                        context.read<ImageFormatConverterBloc>().add(
                          UpdateFormatEvent(value.toLowerCase()),
                        );
                      },
                    ),

                    const Spacer(),

                    /// --- Convert Button + Note
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Note: Image quality will be preserved unless resized or compressed manually.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, color: TNColors.textSecondary),
                          ),
                          const Gap(TNSizes.spaceMD),
                          ProcessButton(
                            text: "Convert Image",
                            onPressed: () {
                              context.read<ImageFormatConverterBloc>().add(ConvertFormatEvent());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is ImageFormatLoading) {
                return const Center(child: ProgressIndicatorForAll());
              } else {
                return const Center(
                  child: Text(
                    TNTextStrings.pleaseSelectImage,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
