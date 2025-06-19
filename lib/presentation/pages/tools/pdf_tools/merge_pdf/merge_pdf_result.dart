import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tool_nest/application/blocs/pdf_tools/merge_pdfs/merge_pdf_bloc.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';

class MergePdfResult extends StatelessWidget {
  const MergePdfResult({super.key});

  Future<void> _download(BuildContext context, File file) async {
    final savedPath = await FileServices().saveToDownloads(file.path);
    if (savedPath != null) {
      Future.delayed(const Duration(seconds: 1), () {
        context.pushNamed(
          AppRoutes.processFinishedForImgToPdf,
          extra: savedPath,
        );
      });


    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save file')),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarForMainSections(title: TNTextStrings.mergePdfResult, isLeadingIcon: true),
      body: BlocBuilder<MergePdfBloc, MergePdfState>(
        builder: (context, state) {
          if (state is MergedSuccess) {
            return Stack(
              children: [
                Padding(
                  padding: TNPaddingStyle.allPadding,
                  child: Column(
                    children: [
                      Expanded(child: SfPdfViewer.file(state.mergedPdf)),

                    ],
                  ),
                ),
                Positioned(
                  bottom: TNSizes.spaceMD,
                  left: TNSizes.spaceMD,
                  right: TNSizes.spaceMD,
                  child: DownloadButton(
                    onPressed: () => _download(context, state.mergedPdf),
                  ),
                ),
              ],
            );
          } else if (state is MergingInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MergeFailed) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No merged PDF found.'));
        },
      ),
    );
  }
}
