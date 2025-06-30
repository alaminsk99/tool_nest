import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:toolest/application/blocs/pdf_tools/split_pdf/split_pdf_bloc.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/core/utils/file_services/file_services.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:toolest/presentation/widgets/loader/progress_indicator_for_all.dart';
import 'package:toolest/presentation/widgets/dialogs/custom_error_dialog.dart';
import 'package:archive/archive_io.dart';
import 'package:gap/gap.dart';

class SplitPdfResult extends StatelessWidget {
  const SplitPdfResult({super.key});

  Future<void> _downloadFiles(BuildContext context, List<File> files) async {
    if (files.length == 1) {
      final path = await FileServices().saveToDownloads(files.first.path);
      _showSnack(context, path);
    } else {
      final zipFile = await _createZip(files);
      final path = await FileServices().saveToDownloads(zipFile.path);
      _showSnack(context, path);
    }
  }

  void _showSnack(BuildContext context, String? path) {
    if (path != null) {
      DialogOptions().showModernSuccessDialog(context, TNTextStrings.savedToDownloads);
      Future.delayed(const Duration(seconds: 1), () {
        context.pushNamed(
          AppRoutes.processFinishedForImgToPdf,
          extra: path,
        );
      });
    } else {
      DialogOptions().showModernErrorDialog(context, TNTextStrings.failedToSave);
    }
  }

  Future<File> _createZip(List<File> files) async {
    final encoder = ZipFileEncoder();
    final tempDir = await Directory.systemTemp.createTemp('split_pdf_zip');
    final zipPath = '${tempDir.path}/split_files_${DateTime.now().millisecondsSinceEpoch}.zip';

    encoder.create(zipPath);

    for (final file in files) {
      if (await file.exists()) {
        final bytes = await file.readAsBytes();
        final copyPath = '${tempDir.path}/${file.uri.pathSegments.last}';
        final copiedFile = File(copyPath);
        await copiedFile.writeAsBytes(bytes, flush: true);
        encoder.addFile(copiedFile);
      }
    }

    encoder.close();
    return File(zipPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.splitPdfResult,
        isLeadingIcon: true,
      ),
      backgroundColor: TNColors.primaryBackground,
      body: BlocBuilder<SplitPdfBloc, SplitPdfState>(
        builder: (context, state) {
          if (state is SplitSuccess) {
            final files = state.splitFiles;

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: TNSizes.spaceMD,
                      vertical: TNSizes.spaceMD,
                    ).copyWith(bottom: TNSizes.spaceXL * 2),
                    itemCount: files.length,
                    separatorBuilder: (_, __) => const Gap(TNSizes.spaceMD),
                    itemBuilder: (context, index) {
                      final file = files[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: TNColors.lightContainer,
                          borderRadius: BorderRadius.circular(TNSizes.borderRadiusLG),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        height: 320,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(TNSizes.borderRadiusLG),
                          child: SfPdfViewer.file(file),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(TNSizes.spaceLG),
                  decoration: BoxDecoration(
                    color: TNColors.lightContainer,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(TNSizes.borderRadiusLG),
                      topRight: Radius.circular(TNSizes.borderRadiusLG),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TNTextStrings.compressionSummary,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: TNColors.textPrimary,
                        ),
                      ),
                      const Gap(TNSizes.spaceSM),
                      _buildSummaryInfo(TNTextStrings.original, '${files.length} page(s)', context),
                      const Gap(TNSizes.spaceXS),
                      _buildSummaryInfo(TNTextStrings.splitPDF, '${files.length} file(s)', context),
                      const Gap(TNSizes.spaceLG),
                      DownloadButton(
                        onPressed: () => _downloadFiles(context, files),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else if (state is SplittingInProgress) {
            return const Center(child: ProgressIndicatorForAll());
          } else if (state is SplitFailed) {
            return Center(child: Text("${TNTextStrings.somThingWrong}"));
          } else {
            return const Center(child: Text("${TNTextStrings.noImageSelected}"));
          }
        },
      ),
    );
  }

  Widget _buildSummaryInfo(String label, String value, BuildContext context, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TNColors.textSecondary),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: valueColor ?? TNColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
