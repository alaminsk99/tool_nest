import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/core/utils/file_services/file_services.dart';
import 'package:toolest/presentation/pages/tools/widgets/buttons/download_button.dart';
import 'package:toolest/presentation/pages/tools/widgets/container/single_image_view_container.dart';
import 'package:toolest/presentation/styles/spacing_style/padding_style.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:toolest/presentation/widgets/dialogs/custom_error_dialog.dart';

class ImageResizeResult extends StatelessWidget {
  final Uint8List imageBytes;
  final int width;
  final int height;

  const ImageResizeResult({
    super.key,
    required this.imageBytes,
    required this.width,
    required this.height,
  });

  Future<void> _saveImage(BuildContext context) async {
    final tempDir = await getTemporaryDirectory();
    final file = File(
      '${tempDir.path}/resized_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    await file.writeAsBytes(imageBytes);

    bool isSuccess = false;
    await FileServices.saveImageToGallery(
      context: context,
      imageFile: file,
      onComplete: () => isSuccess = true,
    );

    if (isSuccess) {
      DialogOptions().showModernSuccessDialog(context, TNTextStrings.savedToDownloads);
      Future.delayed(const Duration(seconds: 1), () {
        context.pushNamed(AppRoutes.processFinishedForImgToPdf, extra: 'null');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppbarForMainSections(
        title: TNTextStrings.imageResizeResult,
        isLeadingIcon: true,
      ),
      backgroundColor: TNColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: TNPaddingStyle.allPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Image preview container
                    Container(
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(TNSizes.borderRadiusLG),
                        child: SingleImageViewContainer(imageBytes: imageBytes),
                      ),
                    ),


                  ],
                ),
              ),
            ),

            /// Bottom Summary + Save Button
            Container(
              width: double.infinity,
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
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: TNColors.textPrimary,
                    ),
                  ),
                  const Gap(TNSizes.spaceSM),
                  _buildSummaryInfo(
                    TNTextStrings.imageResizeResult,
                    '$width x $height px',
                    context,
                  ),
                  const Gap(TNSizes.spaceLG),

                  /// Save Button
                  DownloadButton(onPressed: () => _saveImage(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryInfo(String label, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: TNColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: TNColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
