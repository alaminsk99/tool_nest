import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tool_nest/application/blocs/pdf_tools/merge_pdfs/merge_pdf_bloc.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/dialogs/custom_error_dialog.dart';

class MergePdfResult extends StatelessWidget {
  const MergePdfResult({super.key});

  Future<void> _download(BuildContext context, File file) async {
    final filePath = await FileServices().saveToDownloads(file.path);
    if (filePath != null) {
      DialogOptions().showModernSuccessDialog(context, TNTextStrings.save);
      Future.delayed(const Duration(seconds: 1), () {
        context.pushNamed(AppRoutes.processFinishedForImgToPdf, extra: filePath);
      });
    } else {
      DialogOptions().showModernErrorDialog(context, TNTextStrings.savingFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.mergePdfResult,
        isLeadingIcon: true,
      ),
      backgroundColor: TNColors.primaryBackground,
      body: BlocBuilder<MergePdfBloc, MergePdfState>(
        builder: (context, state) {
          if (state is MergedSuccess) {
            return Column(
              children: [
                /// PDF Viewer
                Expanded(
                  child: Padding(
                    padding: TNPaddingStyle.onlyBottomXXL,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(TNSizes.borderRadiusLG),
                        bottomRight: Radius.circular(TNSizes.borderRadiusLG),
                      ),
                      child: SfPdfViewer.file(state.mergedPdf),
                    ),
                  ),
                ),

                /// Bottom Download Container
                Container(
                  padding: TNPaddingStyle.allPaddingLG,
                  decoration: BoxDecoration(
                    color: TNColors.lightContainer,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(TNSizes.borderRadiusLG),
                      topRight: Radius.circular(TNSizes.borderRadiusLG),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: TNColors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "PDF Merge Completed",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: TNColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: TNSizes.spaceLG),
                      DownloadButton(
                        onPressed: () => _download(context, state.mergedPdf),
                      ),
                    ],
                  ),
                )
              ],
            );
          }

          /// Loading State
          if (state is MergingInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          /// Error State
          if (state is MergeFailed) {
            return Center(
              child: Text(
                'Error: ${state.error}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: TNColors.error),
              ),
            );
          }

          /// Fallback
          return const Center(child: Text('No merged PDF found.'));
        },
      ),
    );
  }
}
