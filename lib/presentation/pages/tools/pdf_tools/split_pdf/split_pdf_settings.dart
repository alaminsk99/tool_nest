import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/application/blocs/pdf_tools/split_pdf/split_pdf_bloc.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/icon_with_process.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/loader/processing_screen.dart';

class SplitPdfSettings extends StatefulWidget {
  const SplitPdfSettings({super.key});

  @override
  State<SplitPdfSettings> createState() => _SplitPdfSettingsState();
}

class _SplitPdfSettingsState extends State<SplitPdfSettings> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

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
    final input = _controller.text;
    final pages = _parsePageRanges(input);

    if (pages.isEmpty) {
      setState(() {
        _errorText = "Enter a valid page range like 1-3,5";
      });
      return;
    }

    _errorText = null;

    context.read<SplitPdfBloc>()
      ..add(ApplySplitSettings(pages))
      ..add(PerformSplit());
  }

  void _showLoader(BuildContext context) {
    isProcessingDialogShown = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ProcessingScreen(
        title: TNTextStrings.splitingPdf,
        warningMessage: TNTextStrings.pleWaitWhileSplitting,
      ),
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
          // Navigate to result screen
          context.pushNamed(AppRoutes.splitPdfResult);
        }

        if (state is SplitFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Split failed: ${state.error}")),
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
                    Text(
                      "Enter Page Range",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: TNSizes.spaceSM),

                    /// Page Range Input
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Example: 1-3,5",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorText: _errorText,
                      ),
                      onChanged: (_) => setState(() {
                        _errorText = null;
                      }),
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

