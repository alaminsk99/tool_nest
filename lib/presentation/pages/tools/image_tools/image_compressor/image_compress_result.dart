import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toolest/application/blocs/image_tools/image_compressor/image_compressor_state.dart';
import 'package:toolest/config/router/route_paths.dart';
import 'package:toolest/core/constants/colors.dart';
import 'package:toolest/core/constants/sizes.dart';
import 'package:toolest/core/constants/text_strings.dart';
import 'package:toolest/core/utils/file_services/file_services.dart';
import 'package:toolest/core/utils/snackbar_helpers/snackbar_helper.dart';
import 'package:toolest/presentation/widgets/appbar/main_section_appbar/appbar_for_main_sections.dart';
import 'package:toolest/presentation/widgets/dialogs/custom_error_dialog.dart';

class ImageCompressResult extends StatefulWidget {
  final ImageCompressionSuccess state;
  const ImageCompressResult({super.key, required this.state});

  @override
  State<ImageCompressResult> createState() => _ImageCompressResultState();
}

class _ImageCompressResultState extends State<ImageCompressResult> {
  bool _showOriginal = false;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final currentFile = _showOriginal
        ? widget.state.selectedImage!
        : widget.state.compressedFile;

    final currentSize = _showOriginal
        ? widget.state.originalSize
        : widget.state.compressedSize;

    return Scaffold(
      backgroundColor: TNColors.primaryBackground,
      appBar: AppbarForMainSections(
        title: TNTextStrings.compressionResult,
        isLeadingIcon: true,
        widgets: [
          IconButton(
            icon: Icon(Icons.save_alt, color: TNColors.white),
            onPressed: _isSaving
                ? null
                : () async {
              try {
                await FileServices.saveImageToGallery(
                  context: context,
                  imageFile: widget.state.compressedFile,
                  fileName:
                  "${TNTextStrings.appNameDirectory}${DateTime.now().millisecondsSinceEpoch}",
                  onStart: () => setState(() => _isSaving = true),
                  onComplete: () => setState(() => _isSaving = false),
                );

                DialogOptions().showModernSuccessDialog(context, TNTextStrings.savedToDownloads);

                await Future.delayed(const Duration(seconds: 1));
                if (context.mounted) {
                  context.pushNamed(
                    AppRoutes.processFinishedForImgToPdf,
                    extra: 'null',
                  );
                }
              } catch (e) {
                debugPrint("Save error: $e");
                SnackbarHelper.showError(context, TNTextStrings.failedToSave);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Image Preview
            Expanded(
              child: Stack(
                children: [
                  PhotoView(
                    imageProvider: FileImage(currentFile),
                    backgroundDecoration:
                    BoxDecoration(color: TNColors.primaryBackground),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        currentSize,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Toggle Controls
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
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  /// Toggle Buttons
                  Row(
                    children: [
                      _buildToggleButton(
                        title: TNTextStrings.showOriginal,
                        isSelected: _showOriginal,
                        onTap: () => setState(() => _showOriginal = true),
                      ),
                      const SizedBox(width: 12),
                      _buildToggleButton(
                        title: TNTextStrings.showCompressed,
                        isSelected: !_showOriginal,
                        onTap: () => setState(() => _showOriginal = false),
                      ),
                    ],
                  ),
                  const SizedBox(height: TNSizes.spaceLG),

                  /// Info Panel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoColumn(
                          TNTextStrings.original, widget.state.originalSize),
                      const Icon(Icons.arrow_right_alt, size: 36),
                      _buildInfoColumn(
                          TNTextStrings.compressed, widget.state.compressedSize),
                      _buildInfoColumn(
                        TNTextStrings.reduction,
                        _calculateReduction(
                          widget.state.selectedImage!.lengthSync(),
                          widget.state.compressedFile.lengthSync(),
                        ),
                        valueColor: TNColors.success,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? TNColors.materialPrimaryColor.shade500
                : TNColors.lightContainer,
            borderRadius: BorderRadius.circular(TNSizes.borderRadiusSM),
            border: Border.all(
              color: isSelected
                  ? TNColors.materialPrimaryColor.shade400
                  : TNColors.borderSecondary,
              width: 1.2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color:
              isSelected ? Colors.white : TNColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, {Color? valueColor}) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? TNColors.textPrimary,
          ),
        ),
      ],
    );
  }

  String _calculateReduction(int original, int compressed) {
    final reduction = ((original - compressed) / original * 100).round();
    return '$reduction%';
  }
}
