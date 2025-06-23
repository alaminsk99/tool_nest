import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tool_nest/config/router/route_paths.dart';
import 'package:tool_nest/core/constants/colors.dart';
import 'package:tool_nest/core/constants/sizes.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'package:tool_nest/core/utils/file_services/file_services.dart';
import 'package:tool_nest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:tool_nest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:tool_nest/presentation/styles/spacing_style/padding_style.dart';
import 'package:tool_nest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:tool_nest/presentation/widgets/dialogs/custom_error_dialog.dart';


class ImageFormatConverterResult extends StatelessWidget {
  final Uint8List convertedBytes;
  final String format;

  const ImageFormatConverterResult({
    super.key,
    required this.convertedBytes,
    required this.format,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TNColors.primaryBackground,
      appBar: AppbarForMainSections(
        title: TNTextStrings.imageFormatConverterResult,
        isLeadingIcon: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Image Preview
            Expanded(
              child: Padding(
                padding: TNPaddingStyle.onlyBottomXXL,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(TNSizes.borderRadiusLG),
                    bottomRight: Radius.circular(TNSizes.borderRadiusLG),
                  ),
                  child: Image.memory(
                    convertedBytes,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            /// Download & Info Panel
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
                  /// Title
                  Text(
                    TNTextStrings.conversionSummary,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: TNColors.textPrimary,
                    ),
                  ),
                  const Gap(TNSizes.spaceSM),

                  /// Format Row
                  _buildInfoRow(
                    TNTextStrings.convertedTo,
                    format.toUpperCase(),
                    context,
                  ),
                  const Gap(TNSizes.spaceLG),

                  /// Download Button
                  DownloadButton(
                    onPressed: () async {
                      try {
                        final tempDir = await getTemporaryDirectory();
                        final timestamp = DateTime.now().millisecondsSinceEpoch;
                        final fileName = "${TNTextStrings.appNameDirectory}converted_$timestamp.$format";
                        final tempFile = File('${tempDir.path}/$fileName');

                        await tempFile.writeAsBytes(convertedBytes);

                        final downloadedPath = await FileServices().saveToDownloads(tempFile.path);

                        if (downloadedPath != null) {
                          DialogOptions().showModernSuccessDialog(context, TNTextStrings.save);
                          await Future.delayed(const Duration(seconds: 1));
                          context.pushNamed(AppRoutes.processFinishedForImgToPdf, extra: 'null');
                        } else {
                          SnackbarHelper.showError(context, TNTextStrings.savingFailed);
                        }
                      } catch (e) {
                        SnackbarHelper.showError(context, TNTextStrings.failedToSave);
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

  /// UI Helper: Info Row
  Widget _buildInfoRow(String label, String value, BuildContext context) {
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
            fontWeight: FontWeight.w500,
            color: TNColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
