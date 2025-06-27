import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/application/blocs/pdf_tools/split_pdf/split_pdf_bloc.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/dropdownButtonSelectionUsingBottomSheets.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_process.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/loader/progress_indicator_for_all.dart';


class SplitPdfSettings extends StatefulWidget {
  const SplitPdfSettings({super.key});

  @override
  State<SplitPdfSettings> createState() => _SplitPdfSettingsState();
}

class _SplitPdfSettingsState extends State<SplitPdfSettings> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<String?> _errorText = ValueNotifier(null);
  final ValueNotifier<String> _splitMode = ValueNotifier('Range');
  final ValueNotifier<bool> _extractAllPages = ValueNotifier(false);

  bool isProcessingDialogShown = false;

  List<int> _parsePageRanges(String input) {
    final pages = <int>{};
    final parts = input.split(',');

    for (final part in parts) {
      if (part.contains('-')) {
        final bounds = part.split('-');
        if (bounds.length == 2) {
          final start = int.tryParse(bounds[0].trim());
          final end = int.tryParse(bounds[1].trim());
          if (start != null && end != null && start <= end) {
            pages.addAll(List.generate(end - start + 1, (i) => start + i));
          }
        }
      } else {
        final page = int.tryParse(part.trim());
        if (page != null) pages.add(page);
      }
    }

    return pages.toList()..sort();
  }

  void _submit(BuildContext context) {
    final mode = _splitMode.value;
    List<int> pages = [];

    if (mode == 'Range') {
      pages = _parsePageRanges(_controller.text);
    } else {
      if (_extractAllPages.value) {
        final blocState = context.read<SplitPdfBloc>().state;
        if (blocState is FileSelected) {
          pages = List.generate(blocState.file.totalPages, (i) => i + 1);
        }
      } else {
        pages = _parsePageRanges(_controller.text);
      }
    }

    if (pages.isEmpty) {
      _errorText.value = "Enter a valid page input";
      return;
    }

    _errorText.value = null;
    context.read<SplitPdfBloc>()
      ..add(ApplySplitSettings(pages))
      ..add(PerformSplit(context));
  }

  void _showLoader(BuildContext context) {
    isProcessingDialogShown = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ProgressIndicatorForAll(),
    );
  }

  void _hideLoader() {
    if (isProcessingDialogShown) {
      Navigator.of(context, rootNavigator: true).pop();
      isProcessingDialogShown = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplitPdfBloc, SplitPdfState>(
      listener: (context, state) {
        if (state is SplittingInProgress) {
          _showLoader(context);
        } else {
          _hideLoader();
        }

        if (state is SplitSuccess) {
          context.pushNamed(AppRoutes.splitPdfResult);
        }

        if (state is SplitFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Split failed: \${state.error}")),
          );
        }
      },
      child: Scaffold(
        appBar: AppbarForMainSections(
          title: TNTextStrings.splitPdfSettings,
          isLeadingIcon: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: TNPaddingStyle.allPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Split Mode Selector using bottom sheet
                    ValueListenableBuilder(
                      valueListenable: _splitMode,
                      builder: (_, mode, __) => DropdownButtonSelectionUsingBottomSheets(
                        titleForBottomSheet: 'Select Split Mode',
                        titleOfTheSection: 'Split Mode',
                        selectedItem: mode,
                        options: const ['Range', 'Pages'],
                        onSelect: (selected) => _splitMode.value = selected,
                      ),
                    ),

                    const SizedBox(height: TNSizes.spaceSM),

                    /// Extract All Checkbox or Input
                    ValueListenableBuilder(
                      valueListenable: _splitMode,
                      builder: (_, mode, __) {
                        if (mode == 'Pages') {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: _extractAllPages,
                                    builder: (_, extractAll, __) => Checkbox(
                                      value: extractAll,
                                      onChanged: (val) => _extractAllPages.value = val!,
                                    ),
                                  ),
                                  const Text('Extract All Pages')
                                ],
                              ),
                              ValueListenableBuilder(
                                valueListenable: _extractAllPages,
                                builder: (_, extractAll, __) {
                                  return extractAll
                                      ? const SizedBox.shrink()
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Enter Page Numbers (e.g. 1,3,5)"),
                                      const SizedBox(height: TNSizes.spaceSM),
                                      ValueListenableBuilder(
                                        valueListenable: _errorText,
                                        builder: (_, err, __) => TextField(
                                          controller: _controller,
                                          decoration: InputDecoration(
                                            hintText: "e.g. 2,4,6",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            errorText: err,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Enter Page Range (e.g. 1-3,5)"),
                              const SizedBox(height: TNSizes.spaceSM),
                              ValueListenableBuilder(
                                valueListenable: _errorText,
                                builder: (_, err, __) => TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: "Example: 1-3,5",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorText: err,
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),

              /// Split Button
              Positioned(
                bottom: TNSizes.spaceMD,
                left: TNSizes.spaceMD,
                right: TNSizes.spaceMD,
                child: IconWithProcess(
                  title: TNTextStrings.splitPDF,
                  icon: LucideIcons.squareSplitVertical,
                  onPressed: () => _submit(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
