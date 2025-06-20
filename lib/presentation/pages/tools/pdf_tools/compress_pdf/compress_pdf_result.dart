import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';
import 'package:tool_nest/domain/models/pdf_tools/compress_pdf_model/compress_pdf_model.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/dialogs/custom_error_dialog.dart';

class CompressPdfResult extends StatelessWidget {
  final CompressedPdfModel compressedPdf;
  const CompressPdfResult({super.key, required this.compressedPdf});

  String _formatBytes(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    var size = bytes.toDouble();
    var i = 0;
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(2)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    final originalSize = _formatBytes(compressedPdf.originalSize);
    final compressedSize = _formatBytes(compressedPdf.compressedSize);
    final saved = compressedPdf.originalSize - compressedPdf.compressedSize;
    final savedPercent = ((saved / compressedPdf.originalSize) * 100).clamp(0, 100).toStringAsFixed(1);

    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.compressPdfResult,
        isLeadingIcon: true,
      ),
      backgroundColor: TNColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            /// PDF Viewer Section
            Expanded(
              child: Padding(
                padding: TNPaddingStyle.onlyBottomXXL,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(TNSizes.borderRadiusLG),
                  child: SfPdfViewer.file(compressedPdf.file),
                ),
              ),
            ),

            /// Bottom Summary & Download Panel
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TNTextStrings.compressionSummary,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: TNColors.textPrimary,
                    ),
                  ),
                  Gap(TNSizes.spaceSM),
                  _buildInfoRow(TNTextStrings.original, originalSize, context),
                  Gap(TNSizes.spaceXS),
                  _buildInfoRow(TNTextStrings.compressed, compressedSize, context),
                  Gap(TNSizes.spaceXS),
                  _buildInfoRow(
                    TNTextStrings.saved,
                    '$savedPercent%',
                    context,
                    valueColor: TNColors.success,
                  ),
                  const Gap(TNSizes.spaceLG),
                  DownloadButton(
                    onPressed: () async {
                      final filePath = await FileServices().saveToDownloads(compressedPdf.file.path);
                      if (filePath != null) {
                        DialogOptions().showModernSuccessDialog(context, TNTextStrings.save);
                      } else {
                        DialogOptions().showModernErrorDialog(context, TNTextStrings.savingFailed);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper: Create an aligned info row
  Widget _buildInfoRow(String label, String value, BuildContext context, {Color? valueColor}) {
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
