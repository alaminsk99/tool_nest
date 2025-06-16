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


class ImageFormatConverterSettings extends StatefulWidget {
  const ImageFormatConverterSettings({super.key});

  @override
  State<ImageFormatConverterSettings> createState() => _ImageFormatConverterSettingsState();
}

class _ImageFormatConverterSettingsState extends State<ImageFormatConverterSettings> {


  // Add 'WEBP' if needed

  @override
  Widget build(BuildContext context) {
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
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
              builder: (context, state) {
                if (state is ImageFormatPickedState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Dropdownbuttonselectionusingbottomsheets(
                        titleForBottomSheet: TNTextStrings.imageSelectFormat,
                        titleOfTheSection: TNTextStrings.format,
                        selectedItem: state.currentFormat.toUpperCase(),
                        options: const ['JPG', 'JPEG', 'PNG'],
                        onSelect: (value) {
                          context.read<ImageFormatConverterBloc>().add(
                            UpdateFormatEvent(value.toLowerCase()),
                          );
                        },
                      ),
                      Gap(TNSizes.spaceBetweenSections),
                      ProcessButton(
                        onPressed: () {
                          context.read<ImageFormatConverterBloc>().add(ConvertFormatEvent());
                        },
                      ),
                    ],
                  );
                } else if (state is ImageFormatLoading) {
                  return const Center(child: ProgressIndicatorForAll());
                } else {
                  return const Center(
                    child: Text(TNTextStrings.pleaseSelectImage),
                  );
                }
              }
          ),
        ),
      ),
    );
  }
}
