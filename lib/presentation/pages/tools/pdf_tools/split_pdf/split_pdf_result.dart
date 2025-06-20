import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tool_nest/application/blocs/pdf_tools/split_pdf/split_pdf_bloc.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:archive/archive_io.dart';
import 'package:tool_nest/presentation/widgets/loader/progress_indicator_for_all.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          path != null
              ? 'Saved to Downloads'
              : 'Failed to save file.',
        ),
      ),
    );
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
      body: BlocBuilder<SplitPdfBloc, SplitPdfState>(
        builder: (context, state) {
          if (state is SplitSuccess) {
            final files = state.splitFiles;

            return Stack(
              children: [
                ListView.separated(
                  padding: const EdgeInsets.only(
                    bottom: TNSizes.spaceXL * 2,
                    left: TNSizes.spaceMD,
                    right: TNSizes.spaceMD,
                    top: TNSizes.spaceMD,
                  ),
                  itemCount: files.length,
                  separatorBuilder: (_, __) => const SizedBox(height: TNSizes.spaceMD),
                  itemBuilder: (context, index) {
                    final file = files[index];
                    return Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SfPdfViewer.file(file),
                      ),
                    );
                  },
                ),

                Positioned(
                  bottom: TNSizes.spaceMD,
                  left: TNSizes.spaceMD,
                  right: TNSizes.spaceMD,
                  child: DownloadButton(
                    onPressed: () => _downloadFiles(context, files),
                  ),
                ),
              ],
            );
          } else if (state is SplittingInProgress) {
            return const Center(child: ProgressIndicatorForAll());
          } else if (state is SplitFailed) {
            return Center(child: Text("Error: try again"));
          }

          return const Center(child: Text("No split files available."));
        },
      ),
    );
  }
}
