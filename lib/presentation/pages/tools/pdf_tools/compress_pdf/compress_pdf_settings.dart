import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toolest/application/blocs/pdf_tools/compress_pdf/compress_pdf_bloc.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/dropdownButtonSelectionUsingBottomSheets.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/process_button.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:toolest/presentation/widgets/loader/progress_indicator_for_all.dart';
import 'package:go_router/go_router.dart';

class CompressPdfSettings extends StatefulWidget {
  const CompressPdfSettings({super.key});

  @override
  State<CompressPdfSettings> createState() => _CompressPdfSettingsState();
}

class _CompressPdfSettingsState extends State<CompressPdfSettings> {
  late CompressionLevel _selectedLevel;

  @override
  void initState() {
    super.initState();
    final state = context.read<CompressPdfBloc>().state;
    if (state is CompressPdfPicked) {
      _selectedLevel = state.level;
    } else {
      _selectedLevel = CompressionLevel.recommended;
    }
  }

  @override
  Widget build(BuildContext context) {
    final compressionOptions = {
      'Extreme Compression': CompressionLevel.extreme,
      'Recommended Compression': CompressionLevel.recommended,
      'Less Compression': CompressionLevel.less,
    };

    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.compressPdfSettings,
        isLeadingIcon: true,
      ),
      body: SafeArea(
        child: BlocConsumer<CompressPdfBloc, CompressPdfState>(
          listener: (context, state) {
            if (state is CompressPdfSuccess) {
              context.pushNamed(
                AppRoutes.compressPdfResult,
                extra: state.compressedPdf,
              );
            } else if (state is CompressPdfError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is CompressPdfLoading) {
              return const Center(child: ProgressIndicatorForAll());
            }

            if (state is! CompressPdfPicked) {
              return const Center(child: Text("No PDF file selected."));
            }

            return Padding(
              padding: TNPaddingStyle.allPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonSelectionUsingBottomSheets(
                    titleForBottomSheet: TNTextStrings.selectCompressionLevel,
                    titleOfTheSection: TNTextStrings.compressionLevel,
                    selectedItem: compressionOptions.entries
                        .firstWhere((entry) => entry.value == _selectedLevel)
                        .key,
                    options: compressionOptions.keys.toList(),
                    onSelect: (selected) {
                      final selectedLevel = compressionOptions[selected];
                      if (selectedLevel != null) {
                        setState(() {
                          _selectedLevel = selectedLevel;
                        });
                        context
                            .read<CompressPdfBloc>()
                            .add(SetCompressionLevelEvent(selectedLevel));
                      }
                    },
                  ),
                  const Gap(TNSizes.spaceBetweenSections),
                  ProcessButton(
                    onPressed: () {
                      context
                          .read<CompressPdfBloc>()
                          .add(CompressPdfFileEvent(context: context));
                    },
                  ),
                  if (state is CompressPdfLoading) ...[
                    const Gap(TNSizes.spaceBetweenItems),
                    const ProgressIndicatorForAll(),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
